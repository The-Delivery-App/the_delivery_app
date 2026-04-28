import 'package:serverpod/serverpod.dart';

class FavouritesController extends Endpoint {
  Future<String> hello(Session session) async {
    return 'Favourites controller working';
  }
}