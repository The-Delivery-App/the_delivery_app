import 'package:serverpod/serverpod.dart';

class FeedController extends Endpoint {
  Future<String> hello(Session session) async {
    return 'Feed controller working';
  }
}
