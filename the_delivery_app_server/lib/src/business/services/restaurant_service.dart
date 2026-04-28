import 'package:serverpod/serverpod.dart';
import '../../data_access/daos/restaurant_dao.dart';

class RestaurantService {
  final Session session;
  late final RestaurantDAO dao;

  RestaurantService(this.session) {
    dao = RestaurantDAO(session);
  }
}