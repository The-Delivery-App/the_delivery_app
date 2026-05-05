import 'package:flutter/foundation.dart';

import '../models/session.dart';
import '../models/user.dart';
import '../state/account_state.dart';

class AccountViewModel extends ChangeNotifier {
  AccountState _state = const AccountState(isLoggedIn: false);

  AccountViewModel();

  AccountState getState() => _state;
}
