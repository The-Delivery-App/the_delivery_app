import '../../generated/protocol.dart';

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

  OrderResult.success(this.order)
      : success = true,
        errorMessage = null;

  OrderResult.fromExisting(this.order)
      : success = true,
        errorMessage = null;

  OrderResult.error(this.errorMessage)
      : success = false,
        order = null;
}

class PaymentResult {
  final bool success;
  final String? transactionId;
  final double? amount;
  final String? errorMessage;

  PaymentResult.success({
    required this.transactionId,
    required this.amount,
  })  : success = true,
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
