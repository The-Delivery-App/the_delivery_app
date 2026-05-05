import '../../models/session.dart';
import '../../models/user.dart';

abstract class IAccountRepository {
  Future<User> login(String email, String password);
  Future<void> logout();
  Future<User> register(String name, String email, String password);
  Future<Session?> getStoredSession();
  Future<Session> createAnonymousSession();
  Future<void> storeSession(String sessionId);
}
