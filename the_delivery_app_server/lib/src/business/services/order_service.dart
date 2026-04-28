import 'package:serverpod/serverpod.dart';
import '../../generated/protocol.dart';
import '../../data_access/daos/order_dao.dart';

/// Handles order creation, validation, and workflow
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
      // 1. prevent duplicate orders
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
        status: OrderStatus.pending,
        note: 'Order created',
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

      if (order.currentStatus != OrderStatus.pending) {
        return PaymentResult.error('Order is not in pending state');
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
        await _updateOrderStatus(orderId, OrderStatus.paymentFailed);
        return PaymentResult.error(
          paymentSuccess.errorMessage ?? 'Payment failed',
        );
      }

      await orderDAO.updatePaymentStatus(payment.id!, 'succeeded');
      await _updateOrderStatus(orderId, OrderStatus.confirmed);

      // 6. TODO: Assign courier (implement in Step 5)
      // await _assignCourier(orderId);

      // 7. TODO: Notify restaurant (implement FCM later)
      // await _notifyRestaurant(order.restaurantId, orderId);

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

      // Verify ownership
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
      note: 'Status updated to ${newStatus.name}',
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
      // Load food item from database
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

    double deliveryFee = 2.99;
    if (subtotal >= 15.0) {
      deliveryFee = 0.0; // Free delivery over £15
    }

    double serviceFee = subtotal * 0.10;

    double discount = 0.0;
    if (couponCode != null) {
      discount = await _calculateDiscount(subtotal, couponCode);
    }

    double total = subtotal + deliveryFee + serviceFee - discount;

    return OrderPricing(
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      serviceFee: serviceFee,
      discount: discount,
      total: total,
    );
  }

  Future<double> _calculateDiscount(double subtotal, String couponCode) async {
    // TODO: Look up coupon in database
    if (couponCode.toUpperCase() == 'SAVE10') {
      return subtotal * 0.10; // 10% off
    }
    return 0.0;
  }

  Future<DateTime> _estimateDeliveryTime({
    required int restaurantId,
    required int deliveryAddressId,
  }) async {
    // estimate 45 minutes
    return DateTime.now().add(Duration(minutes: 45));
  }

  Future<ProviderPaymentResult> _processPaymentWithProvider({
    required double amount,
    required String paymentToken,
    required String paymentMethod,
    required String idempotencyKey,
  }) async {
    // Mock payment processing
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
}

class BasketItemInput {
  final int foodItemId;
  final int quantity;
  final String? specialInstructions;

  BasketItemInput({
    required this.foodItemId,
    required this.quantity,
    this.specialInstructions,
  });
}

class ValidatedBasketItem {
  final int foodItemId;
  final int quantity;
  final double unitPrice;
  final String? specialInstructions;
  final String foodItemName;
  final String? foodItemDescription;

  ValidatedBasketItem({
    required this.foodItemId,
    required this.quantity,
    required this.unitPrice,
    this.specialInstructions,
    required this.foodItemName,
    this.foodItemDescription,
  });
}

class BasketValidationResult {
  final bool isValid;
  final String? errorMessage;
  final List<ValidatedBasketItem>? validatedItems;

  BasketValidationResult.valid(this.validatedItems)
    : isValid = true,
      errorMessage = null;

  BasketValidationResult.invalid(this.errorMessage)
    : isValid = false,
      validatedItems = null;
}

class OrderPricing {
  final double subtotal;
  final double deliveryFee;
  final double serviceFee;
  final double discount;
  final double total;

  OrderPricing({
    required this.subtotal,
    required this.deliveryFee,
    required this.serviceFee,
    required this.discount,
    required this.total,
  });
}

class OrderResult {
  final bool success;
  final Order? order;
  final String? errorMessage;

  OrderResult.success(this.order) : success = true, errorMessage = null;

  OrderResult.fromExisting(this.order) : success = true, errorMessage = null;

  OrderResult.error(this.errorMessage) : success = false, order = null;
}

class PaymentResult {
  final bool success;
  final String? transactionId;
  final double? amount;
  final String? errorMessage;

  PaymentResult.success({
    required this.transactionId,
    required this.amount,
  }) : success = true,
       errorMessage = null;

  PaymentResult.error(this.errorMessage)
    : success = false,
      transactionId = null,
      amount = null;
}

class ProviderPaymentResult {
  final bool success;
  final String? transactionId;
  final String? errorMessage;

  ProviderPaymentResult({
    required this.success,
    this.transactionId,
    this.errorMessage,
  });
}

class OrderDetails {
  final Order order;
  final List<OrderItem> items;
  final List<OrderStatusHistory> statusHistory;
  final Payment? payment;
  final List<SplitPaymentParticipant>? splitParticipants;

  OrderDetails({
    required this.order,
    required this.items,
    required this.statusHistory,
    this.payment,
    this.splitParticipants,
  });
}
