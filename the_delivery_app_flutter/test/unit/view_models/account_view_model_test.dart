import 'package:flutter_test/flutter_test.dart';
import 'package:the_delivery_app_flutter/view_models/account_view_model.dart';
import 'package:the_delivery_app_flutter/models/session.dart';
import 'package:the_delivery_app_flutter/models/user.dart';

void main() {
  group('AccountViewModel TC-060..TC-064', () {
    test('login sets logged-in user and session', () {
      final vm = AccountViewModel();

      vm.login();
      final state = vm.getState();

      expect(state.isLoggedIn, isTrue);
      expect(state.user, isNotNull);
      expect(state.user!.email, equals('demo@example.com'));
      expect(state.session, isNotNull);
    });

    test('register behaves like login', () {
      final vm = AccountViewModel();
      vm.register();
      final state = vm.getState();
      expect(state.isLoggedIn, isTrue);
    });

    test('logout clears login state', () {
      final vm = AccountViewModel();
      vm.login();
      vm.logout();
      final state = vm.getState();
      expect(state.isLoggedIn, isFalse);
      expect(state.user, isNull);
    });

    test('getGuestSession sets guest session', () {
      final vm = AccountViewModel();
      vm.getGuestSession();
      final state = vm.getState();
      expect(state.isLoggedIn, isFalse);
      expect(state.session, isNotNull);
      expect(state.session!.isGuest, isTrue);
    });
  });
}
