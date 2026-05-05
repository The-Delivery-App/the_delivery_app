import 'package:flutter/foundation.dart';

import '../models/session.dart';
import '../models/user.dart';
import '../state/account_state.dart';

class AccountViewModel extends ChangeNotifier {
  AccountState _state = const AccountState(isLoggedIn: false);

  AccountViewModel();

  AccountState getState() => _state;

  void login() {
    // No backend connected yet — sets a mock logged-in user locally.
    _state = AccountState(
      isLoggedIn: true,
      user: const User(userId: 'user-1', name: 'Demo User', email: 'demo@example.com'),
      session: const Session(sessionId: 'session-1', userId: 'user-1', isGuest: false),
    );
    notifyListeners();
  }

  void register() {
    // No backend connected yet — behaves same as login locally.
    login();
  }

  void logout() {
    _state = const AccountState(isLoggedIn: false);
    notifyListeners();
  }

  void getGuestSession() {
    _state = AccountState(
      isLoggedIn: false,
      session: const Session(sessionId: 'guest-1', userId: 'guest', isGuest: true),
    );
    notifyListeners();
  }
}
