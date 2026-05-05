import '../../models/food.dart';
import '../../models/location.dart';

abstract class ISpecialDealRepository {
  Future<List<Food>> getSpecialDeals(Location location);
}
