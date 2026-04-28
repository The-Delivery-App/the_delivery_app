import 'package:serverpod/serverpod.dart';
import '../../generated/protocol.dart';

/// Handles all database interactions for orders
class OrderDAO {
  final Session session;

  OrderDAO(this.session);

  Future<Order?> findByIdempotencyKey(String idempotencyKey) async {
    try {
      return await Order.db.findFirstRow(
        session,
        where: (t) => t.idempotencyKey.equals(idempotencyKey),
      );
    } catch (e) {
      session.log('Error finding order by idempotency key: $e');
      return null;
    }
  }

  /// Create a new order with items in a transaction
  /// Returns the created order with its ID
  Future<Order> createOrder({
    required int userId,
    required int restaurantId,
    required int deliveryAddressId,
    required List<OrderItemData> items,
    required double subtotal,
    required double deliveryFee,
    required double serviceFee,
    required double discount,
    required double totalAmount,
    required String idempotencyKey,
    required bool isSplit,
    String? deliveryInstructions,
    DateTime? estimatedDeliveryTime,
  }) async {
    return await session.db.transaction((transaction) async {
      // Create the order
      final order = await Order.db.insertRow(
        session,
        Order(
          userId: userId,
          restaurantId: restaurantId,
          deliveryAddressId: deliveryAddressId,
          subtotal: subtotal,
          deliveryFee: deliveryFee,
          serviceFee: serviceFee,
          discount: discount,
          totalAmount: totalAmount,
          idempotencyKey: idempotencyKey,
          currentStatus: OrderStatus.pending,
          createdAt: DateTime.now(),
          isSplit: isSplit,
          deliveryInstructions: deliveryInstructions,
          estimatedDeliveryTime: estimatedDeliveryTime,
        ),
      );

      for (final itemData in items) {
        await OrderItem.db.insertRow(
          session,
          OrderItem(
            orderId: order.id!,
            foodItemId: itemData.foodItemId,
            quantity: itemData.quantity,
            unitPrice: itemData.unitPrice,
            specialInstructions: itemData.specialInstructions,
            foodItemName: itemData.foodItemName,
            foodItemDescription: itemData.foodItemDescription,
          ),
        );
      }

      return order;
    });
  }

  Future<Order?> getById(int orderId) async {
    try {
      return await Order.db.findById(session, orderId);
    } catch (e) {
      session.log('Error getting order by ID: $e');
      return null;
    }
  }

  /// Get order with all related data (items, status history)
  Future<OrderWithDetails?> getOrderWithDetails(int orderId) async {
    try {
      final order = await Order.db.findById(session, orderId);
      if (order == null) return null;

      // Load order items
      final items = await OrderItem.db.find(
        session,
        where: (t) => t.orderId.equals(orderId),
      );

      // Load status history
      final statusHistory = await OrderStatusHistory.db.find(
        session,
        where: (t) => t.orderId.equals(orderId),
        orderBy: (t) => t.timestamp,
      );

      // Load payment if exists
      final payment = await Payment.db.findFirstRow(
        session,
        where: (t) => t.orderId.equals(orderId),
      );

      // Load split participants if split order
      List<SplitPaymentParticipant>? splitParticipants;
      if (order.isSplit) {
        splitParticipants = await SplitPaymentParticipant.db.find(
          session,
          where: (t) => t.orderId.equals(orderId),
        );
      }

      return OrderWithDetails(
        order: order,
        items: items,
        statusHistory: statusHistory,
        payment: payment,
        splitParticipants: splitParticipants,
      );
    } catch (e) {
      session.log('Error getting order with details: $e');
      return null;
    }
  }

  /// Update order status
  Future<bool> updateStatus(int orderId, OrderStatus newStatus) async {
    try {
      final order = await Order.db.findById(session, orderId);
      if (order == null) return false;

      order.currentStatus = newStatus;
      order.updatedAt = DateTime.now();

      await Order.db.updateRow(session, order);
      return true;
    } catch (e) {
      session.log('Error updating order status: $e');
      return false;
    }
  }

  Future<void> addStatusHistory({
    required int orderId,
    required OrderStatus status,
    DateTime? timestamp,
    String? note,
  }) async {
    try {
      await OrderStatusHistory.db.insertRow(
        session,
        OrderStatusHistory(
          orderId: orderId,
          status: status,
          timestamp: timestamp ?? DateTime.now(),
          note: note,
        ),
      );
    } catch (e) {
      session.log('Error adding status history: $e');
      rethrow;
    }
  }

  Future<List<Order>> getUserOrders(
    int userId, {
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      return await Order.db.find(
        session,
        where: (t) => t.userId.equals(userId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      session.log('Error getting user orders: $e');
      return [];
    }
  }

  Future<List<Order>> getOrdersByStatus(
    OrderStatus status, {
    int limit = 50,
  }) async {
    try {
      return await Order.db.find(
        session,
        where: (t) => t.currentStatus.equals(status),
        orderBy: (t) => t.createdAt,
        limit: limit,
      );
    } catch (e) {
      session.log('Error getting orders by status: $e');
      return [];
    }
  }

  /// Update courier assignment
  Future<bool> assignCourier(int orderId, int courierId) async {
    try {
      final order = await Order.db.findById(session, orderId);
      if (order == null) return false;

      order.courierId = courierId;
      order.updatedAt = DateTime.now();

      await Order.db.updateRow(session, order);
      return true;
    } catch (e) {
      session.log('Error assigning courier: $e');
      return false;
    }
  }

  /// Update courier location (for tracking)
  Future<bool> updateCourierLocation(
    int orderId,
    double latitude,
    double longitude,
  ) async {
    try {
      final order = await Order.db.findById(session, orderId);
      if (order == null) return false;

      order.courierLatitude = latitude;
      order.courierLongitude = longitude;
      order.updatedAt = DateTime.now();

      await Order.db.updateRow(session, order);
      return true;
    } catch (e) {
      session.log('Error updating courier location: $e');
      return false;
    }
  }

  /// Mark order as delivered
  Future<bool> markAsDelivered(int orderId) async {
    try {
      final order = await Order.db.findById(session, orderId);
      if (order == null) return false;

      order.currentStatus = OrderStatus.delivered;
      order.actualDeliveryTime = DateTime.now();
      order.updatedAt = DateTime.now();

      await Order.db.updateRow(session, order);

      await addStatusHistory(
        orderId: orderId,
        status: OrderStatus.delivered,
        note: 'Order successfully delivered',
      );

      return true;
    } catch (e) {
      session.log('Error marking order as delivered: $e');
      return false;
    }
  }

  Future<Payment> recordPayment({
    required int orderId,
    required int userId,
    required double amount,
    required String paymentMethod,
    required String providerName,
    String? transactionId,
    String? providerMetadata,
  }) async {
    try {
      return await Payment.db.insertRow(
        session,
        Payment(
          orderId: orderId,
          userId: userId,
          amount: amount,
          currency: 'GBP',
          paymentMethod: paymentMethod,
          transactionId: transactionId,
          providerName: providerName,
          providerMetadata: providerMetadata,
          status: 'pending',
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      session.log('Error recording payment: $e');
      rethrow;
    }
  }

  Future<bool> updatePaymentStatus(
    int paymentId,
    String status, {
    DateTime? processedAt,
  }) async {
    try {
      final payment = await Payment.db.findById(session, paymentId);
      if (payment == null) return false;

      payment.status = status;
      payment.processedAt = processedAt ?? DateTime.now();

      await Payment.db.updateRow(session, payment);
      return true;
    } catch (e) {
      session.log('Error updating payment status: $e');
      return false;
    }
  }

  Future<void> createSplitParticipants({
    required int orderId,
    required List<int> participantUserIds,
    required double amountPerPerson,
  }) async {
    try {
      for (final userId in participantUserIds) {
        await SplitPaymentParticipant.db.insertRow(
          session,
          SplitPaymentParticipant(
            orderId: orderId,
            userId: userId,
            amountDue: amountPerPerson,
            hasPaid: false,
            invitedAt: DateTime.now(),
          ),
        );
      }
    } catch (e) {
      session.log('Error creating split participants: $e');
      rethrow;
    }
  }

  Future<bool> markSplitParticipantPaid(
    int orderId,
    int userId,
    int paymentId,
  ) async {
    try {
      final participant = await SplitPaymentParticipant.db.findFirstRow(
        session,
        where: (t) => t.orderId.equals(orderId) & t.userId.equals(userId),
      );

      if (participant == null) return false;

      participant.hasPaid = true;
      participant.paidAt = DateTime.now();
      participant.paymentId = paymentId;

      await SplitPaymentParticipant.db.updateRow(session, participant);
      return true;
    } catch (e) {
      session.log('Error marking split participant as paid: $e');
      return false;
    }
  }

  Future<bool> allSplitParticipantsPaid(int orderId) async {
    try {
      final participants = await SplitPaymentParticipant.db.find(
        session,
        where: (t) => t.orderId.equals(orderId),
      );

      return participants.every((p) => p.hasPaid);
    } catch (e) {
      session.log('Error checking split payment status: $e');
      return false;
    }
  }
}

/// Helper class to pass order item data
class OrderItemData {
  final int foodItemId;
  final int quantity;
  final double unitPrice;
  final String? specialInstructions;
  final String foodItemName;
  final String? foodItemDescription;

  OrderItemData({
    required this.foodItemId,
    required this.quantity,
    required this.unitPrice,
    this.specialInstructions,
    required this.foodItemName,
    this.foodItemDescription,
  });
}

/// Helper class to return order with all details
class OrderWithDetails {
  final Order order;
  final List<OrderItem> items;
  final List<OrderStatusHistory> statusHistory;
  final Payment? payment;
  final List<SplitPaymentParticipant>? splitParticipants;

  OrderWithDetails({
    required this.order,
    required this.items,
    required this.statusHistory,
    this.payment,
    this.splitParticipants,
  });
}
