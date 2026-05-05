import '../models/food.dart';
import '../models/location.dart';
import 'interfaces/i_special_deal_repository.dart';

class SpecialDealRepository implements ISpecialDealRepository {
  @override
  Future<List<Food>> getSpecialDeals(Location location) async {
    // No backend connected yet — returns empty list until wired up.
    return [];
  }
}
