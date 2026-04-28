import 'package:serverpod/serverpod.dart';

class ReviewsController extends Endpoint {
  Future<String> hello(Session session) async {
    return 'Reviews controller working';
  }
}