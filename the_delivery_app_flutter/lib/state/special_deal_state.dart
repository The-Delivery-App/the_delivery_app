import '../models/food.dart';

class SpecialDealState {
  final List<Food> deals;
  final bool isLoading;

  const SpecialDealState({
    required this.deals,
    required this.isLoading,
  });
}
