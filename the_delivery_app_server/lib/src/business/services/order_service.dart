import 'package:serverpod/serverpod.dart' hide Order;
import '../../generated/protocol.dart';
import '../../data_access/daos/order_dao.dart';
import '../models/order_models.dart';

class OrderService {
  final Session session;
  late final OrderDAO orderDAO;

  OrderService(this.session) {
    orderDAO = OrderDAO(session);
  }

  Future<OrderResult> createOrder({
    required int userId,
    required String idempotencyKey,
    required List<BasketItemInput> basketItems,
    required int restaurantId,
    required int deliveryAddressId,
    String? couponCode,
    bool isSplit = false,
    List<int>? splitParticipantIds,
    String? deliveryInstructions,
  }) async {
    try {
      final existingOrder = await orderDAO.findByIdempotencyKey(idempotencyKey);
      if (existingOrder != null) {
        return OrderResult.fromExisting(existingOrder);
      }

      final validationResult = await _validateBasketItems(
        basketItems,
        restaurantId,
      );
      if (!validationResult.isValid) {
        return OrderResult.error(validationResult.errorMessage!);
      }

      final pricing = await _calculatePricing(
        items: validationResult.validatedItems!,
        restaurantId: restaurantId,
        deliveryAddressId: deliveryAddressId,
        couponCode: couponCode,
      );

      final estimatedDeliveryTime = await _estimateDeliveryTime(
        restaurantId: restaurantId,
        deliveryAddressId: deliveryAddressId,
      );

      final orderItems = validationResult.validatedItems!.map((item) {
        return OrderItemData(
          foodItemId: item.foodItemId,
          quantity: item.quantity,
          unitPrice: item.unitPrice,
          specialInstructions: item.specialInstructions,
          foodItemName: item.foodItemName,
          foodItemDescription: item.foodItemDescription,
        );
      }).toList();

      final order = await orderDAO.createOrder(
        userId: userId,
        restaurantId: restaurantId,
        deliveryAddressId: deliveryAddressId,
        items: orderItems,
        subtotal: pricing.subtotal,
        deliveryFee: pricing.deliveryFee,
        serviceFee: pricing.serviceFee,
        discount: pricing.discount,
        totalAmount: pricing.total,
        idempotencyKey: idempotencyKey,
        isSplit: isSplit,
        deliveryInstructions: deliveryInstructions,
        estimatedDeliveryTime: estimatedDeliveryTime,
      );

      await orderDAO.addStatusHistory(
        orderId: order.id!,
        status: OrderStatus.placed,
      );

      if (isSplit &&
          splitParticipantIds != null &&
          splitParticipantIds.isNotEmpty) {
        final amountPerPerson =
            pricing.total / (splitParticipantIds.length + 1);
        await orderDAO.createSplitParticipants(
          orderId: order.id!,
          participantUserIds: splitParticipantIds,
          amountPerPerson: amountPerPerson,
        );
      }

      return OrderResult.success(order);
    } catch (e) {
      session.log('Error creating order: $e', level: LogLevel.error);
      return OrderResult.error('Failed to create order: $e');
    }
  }

  Future<PaymentResult> processPayment({
    required int orderId,
    required int userId,
    required String paymentToken,
    required String paymentMethod,
  }) async {
    try {
      final order = await orderDAO.getById(orderId);
      if (order == null) {
        return PaymentResult.error('Order not found');
      }

      if (order.userId != userId) {
        return PaymentResult.error('Unauthorized');
      }

      if (order.currentStatus != OrderStatus.placed) {
        return PaymentResult.error('Order is not in placed state');
      }

      final paymentSuccess = await _processPaymentWithProvider(
        amount: order.totalAmount,
        paymentToken: paymentToken,
        paymentMethod: paymentMethod,
        idempotencyKey: '${orderId}_payment',
      );

      final payment = await orderDAO.recordPayment(
        orderId: orderId,
        userId: userId,
        amount: order.totalAmount,
        paymentMethod: paymentMethod,
        providerName: 'stripe',
        transactionId: paymentSuccess.transactionId,
      );

      if (!paymentSuccess.success) {
        await orderDAO.updatePaymentStatus(payment.id!, 'failed');
        await _updateOrderStatus(orderId, OrderStatus.placed);
        return PaymentResult.error(
          paymentSuccess.errorMessage ?? 'Payment failed',
        );
      }

      await orderDAO.updatePaymentStatus(payment.id!, 'succeeded');
      await _updateOrderStatus(orderId, OrderStatus.confirmed);

      return PaymentResult.success(
        transactionId: paymentSuccess.transactionId!,
        amount: order.totalAmount,
      );
    } catch (e) {
      session.log('Error processing payment: $e', level: LogLevel.error);
      return PaymentResult.error('Payment processing failed: $e');
    }
  }

  Future<OrderDetails?> getOrderDetails(int orderId, int userId) async {
    try {
      final orderWithDetails = await orderDAO.getOrderWithDetails(orderId);
      if (orderWithDetails == null) {
        return null;
      }

      if (orderWithDetails.order.userId != userId) {
        throw Exception('Unauthorized access to order');
      }

      return OrderDetails(
        order: orderWithDetails.order,
        items: orderWithDetails.items,
        statusHistory: orderWithDetails.statusHistory,
        payment: orderWithDetails.payment,
        splitParticipants: orderWithDetails.splitParticipants,
      );
    } catch (e) {
      session.log('Error getting order details: $e', level: LogLevel.error);
      return null;
    }
  }

  Future<List<Order>> getUserOrderHistory(
    int userId, {
    int limit = 20,
    int offset = 0,
  }) async {
    return await orderDAO.getUserOrders(userId, limit: limit, offset: offset);
  }

  Future<void> _updateOrderStatus(int orderId, OrderStatus newStatus) async {
    await orderDAO.updateStatus(orderId, newStatus);
    await orderDAO.addStatusHistory(
      orderId: orderId,
      status: newStatus,
    );
  }

  Future<BasketValidationResult> _validateBasketItems(
    List<BasketItemInput> items,
    int restaurantId,
  ) async {
    if (items.isEmpty) {
      return BasketValidationResult.invalid('Basket is empty');
    }

    final validatedItems = <ValidatedBasketItem>[];

    for (final item in items) {
      final foodItem = await FoodItem.db.findById(session, item.foodItemId);

      if (foodItem == null) {
        return BasketValidationResult.invalid(
          'Food item ${item.foodItemId} not found',
        );
      }

      if (foodItem.restId != restaurantId) {
        return BasketValidationResult.invalid(
          'Item ${foodItem.foodName} does not belong to this restaurant',
        );
      }

      if (item.quantity <= 0) {
        return BasketValidationResult.invalid(
          'Invalid quantity for ${foodItem.foodName}',
        );
      }

      validatedItems.add(
        ValidatedBasketItem(
          foodItemId: foodItem.id!,
          quantity: item.quantity,
          unitPrice: foodItem.foodPrice,
          specialInstructions: item.specialInstructions,
          foodItemName: foodItem.foodName,
          foodItemDescription: foodItem.description,
        ),
      );
    }

    return BasketValidationResult.valid(validatedItems);
  }

  Future<OrderPricing> _calculatePricing({
    required List<ValidatedBasketItem> items,
    required int restaurantId,
    required int deliveryAddressId,
    String? couponCode,
  }) async {
    double subtotal = 0;
    for (final item in items) {
      subtotal += item.unitPrice * item.quantity;
    }

    final double deliveryFee = subtotal >= 15.0 ? 0.0 : 2.99;
    final double serviceFee = subtotal * 0.10;
    final double discount = couponCode != null
        ? _calculateDiscount(subtotal, couponCode)
        : 0.0;
    final double total =
        (subtotal + deliveryFee + serviceFee - discount).clamp(0.0, double.infinity);

    return OrderPricing(
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      serviceFee: serviceFee,
      discount: discount,
      total: total,
    );
  }

  double _calculateDiscount(double subtotal, String couponCode) {
    switch (couponCode.toUpperCase()) {
      case 'SAVE10': return subtotal * 0.10;
      case 'SAVE20': return subtotal * 0.20;
      case 'FREESHIP': return 2.99;
      default: return 0.0;
    }
  }

  Future<DateTime> _estimateDeliveryTime({
    required int restaurantId,
    required int deliveryAddressId,
  }) async {
    return DateTime.now().add(Duration(minutes: 45));
  }

  Future<ProviderPaymentResult> _processPaymentWithProvider({
    required double amount,
    required String paymentToken,
    required String paymentMethod,
    required String idempotencyKey,
  }) async {
    // this would call Stripe API

    if (paymentToken.startsWith('tok_') || paymentToken == 'test_success') {
      return ProviderPaymentResult(
        success: true,
        transactionId: 'txn_${DateTime.now().millisecondsSinceEpoch}',
      );
    }

    return ProviderPaymentResult(
      success: false,
      errorMessage: 'Invalid payment token',
    );
  }

  Future<bool> updateCourierLocation(
    int orderId,
    double latitude,
    double longitude,
  ) async {
    return orderDAO.updateCourierLocation(orderId, latitude, longitude);
  }

  Future<CourierTrackingInfo?> getCourierTracking(int orderId, int userId) async {
    try {
      final order = await orderDAO.getById(orderId);
      if (order == null || order.userId != userId) return null;
      if (order.courierId == null) return null;

      final courier = await Courier.db.findById(session, order.courierId!);
      if (courier == null) return null;

      int? minutesRemaining;
      if (order.estimatedDeliveryTime != null) {
        final diff = order.estimatedDeliveryTime!.difference(DateTime.now());
        minutesRemaining = diff.inMinutes.clamp(0, 9999);
      }

      return CourierTrackingInfo(
        courierId: courier.id!,
        courierName: '${courier.fname} ${courier.lname}',
        courierPhone: courier.phone,
        vehicleInfo: '${courier.carName} (${courier.plateNum})',
        currentLatitude: order.courierLatitude,
        currentLongitude: order.courierLongitude,
        estimatedDeliveryTime: order.estimatedDeliveryTime,
        minutesRemaining: minutesRemaining,
        currentStatus: order.currentStatus,
      );
    } catch (e) {
      session.log('Error getting courier tracking: $e', level: LogLevel.error);
      return null;
    }
  }
}

class CourierTrackingInfo {
  final int courierId;
  final String courierName;
  final String courierPhone;
  final String vehicleInfo;
  final double? currentLatitude;
  final double? currentLongitude;
  final DateTime? estimatedDeliveryTime;
  final int? minutesRemaining;
  final OrderStatus currentStatus;

  CourierTrackingInfo({
    required this.courierId,
    required this.courierName,
    required this.courierPhone,
    required this.vehicleInfo,
    this.currentLatitude,
    this.currentLongitude,
    this.estimatedDeliveryTime,
    this.minutesRemaining,
    required this.currentStatus,
  });

  Map<String, dynamic> toJson() => {
        'courierId': courierId,
        'courierName': courierName,
        'courierPhone': courierPhone,
        'vehicleInfo': vehicleInfo,
        'currentLatitude': currentLatitude,
        'currentLongitude': currentLongitude,
        'estimatedDeliveryTime': estimatedDeliveryTime?.toIso8601String(),
        'minutesRemaining': minutesRemaining,
        'currentStatus': currentStatus.name,
      };
}



