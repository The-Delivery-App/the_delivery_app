import 'package:serverpod/serverpod.dart';

class OrderController extends Endpoint {
  Future<String> hello(Session session) async {
    return 'Hello from OrderController';
  }
}
