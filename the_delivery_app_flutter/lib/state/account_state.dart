import '../models/session.dart';
import '../models/user.dart';

class AccountState {
  final User? user;
  final Session? session;
  final bool isLoggedIn;

  const AccountState({
    this.user,
    this.session,
    required this.isLoggedIn,
  });
}
