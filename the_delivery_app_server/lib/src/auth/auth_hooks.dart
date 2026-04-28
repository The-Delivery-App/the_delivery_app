import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class AuthHooks {
  /// Called when a new user is created via email authentication
  /// Automatically creates an app-level user profile
  static Future<void> onUserCreated(
    Session session,
    UserInfo userInfo,
  ) async {
    try {
      // Check if user already exists (shouldn't happen, but just in case)
      final existing = await User.db.findFirstRow(
        session,
        where: (t) => t.authUserId.equals(userInfo.id!),
      );

      if (existing != null) {
        session.log('User profile already exists for auth user ${userInfo.id}');
        return;
      }

      // Create app-level user profile
      await User.db.insertRow(
        session,
        User(
          authUserId: userInfo.id!,
          email: userInfo.email ?? '',
          name: userInfo.userName ?? 'User',
          createdAt: DateTime.now(),
        ),
      );

      session.log('Created user profile for auth user ${userInfo.id}');
    } catch (e) {
      session.log('Error creating user profile: $e', level: LogLevel.error);
      rethrow;
    }
  }

  static Future<User?> getAppUser(Session session) async {
    try {
      final authUserId = await session.auth.authenticatedUserId;
      if (authUserId == null) return null;

      return await User.db.findFirstRow(
        session,
        where: (t) => t.authUserId.equals(authUserId),
      );
    } catch (e) {
      session.log('Error getting app user: $e');
      return null;
    }
  }

  static Future<User?> requireAuth(Session session) async {
    final user = await getAppUser(session);
    if (user == null) {
      throw Exception('Authentication required');
    }
    return user;
  }
}