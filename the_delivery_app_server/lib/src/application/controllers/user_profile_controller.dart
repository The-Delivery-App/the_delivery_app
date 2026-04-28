import 'package:serverpod/serverpod.dart';

class UserProfileController extends Endpoint {
  Future<String> hello(Session session) async {
    return 'Hello from UserProfile';
  }
}