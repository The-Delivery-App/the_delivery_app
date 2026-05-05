import '../models/session.dart';
import '../models/user.dart';
import 'interfaces/i_account_repository.dart';

class AccountRepository implements IAccountRepository {
  @override
  Future<User> login(String email, String password) async {
    // No backend connected yet — returns a mock user.
    return const User(userId: 'user-1', name: 'Demo User', email: 'demo@example.com');
  }

  @override
  Future<void> logout() async {
    // No backend connected yet — nothing to clear.
  }

  @override
  Future<User> register(String name, String email, String password) async {
    // No backend connected yet — behaves same as login.
    return User(userId: 'user-1', name: name, email: email);
  }

  @override
  Future<Session?> getStoredSession() async {
    // No local storage wired yet — returns null.
    return null;
  }

  @override
  Future<Session> createAnonymousSession() async {
    // No backend connected yet — returns a mock guest session.
    return const Session(sessionId: 'guest-1', userId: 'guest', isGuest: true);
  }

  @override
  Future<void> storeSession(String sessionId) async {
    // No local storage wired yet — nothing to store.
  }
}
