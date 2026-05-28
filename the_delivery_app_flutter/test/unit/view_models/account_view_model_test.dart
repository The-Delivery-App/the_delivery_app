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

    test('TC-061 login provides valid email and user fields', () {
      final vm = AccountViewModel();
      vm.login();
      final state = vm.getState();
      expect(state.user, isNotNull);
      expect(state.user!.email.contains('@'), isTrue);
      expect(state.user!.name.isNotEmpty, isTrue);
    });

    test('TC-062 register creates same logged-in state as login', () {
      final vm1 = AccountViewModel();
      vm1.register();
      final s1 = vm1.getState();

      final vm2 = AccountViewModel();
      vm2.login();
      final s2 = vm2.getState();

      expect(s1.isLoggedIn, equals(s2.isLoggedIn));
      expect(s1.user!.email, equals(s2.user!.email));
    });

    test('TC-063 guest session has userId guest', () {
      final vm = AccountViewModel();
      vm.getGuestSession();
      final state = vm.getState();
      expect(state.session!.userId, equals('guest'));
    });
  });
}
