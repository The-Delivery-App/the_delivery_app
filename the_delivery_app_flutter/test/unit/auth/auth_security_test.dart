import 'package:flutter_test/flutter_test.dart';
import 'package:the_delivery_app_flutter/repositories/account_repository.dart';

void main() {
  group('Auth security (TC-065, TC-066)', () {
    test(
      'TC-065 Password hashing: registered password not stored in plain text',
      () async {
        // This test is skipped because the current AccountRepository is a demo stub
        // and there is no backend/local DB to verify stored password hashing.
      },
      skip: 'Requires backend/user storage to verify password hashing',
    );

    test(
      'TC-066 JWT token: login returns a signed JWT token',
      () async {
        // Skipped: production code does not return JWT tokens yet.
      },
      skip: 'Requires auth backend returning JWT tokens',
    );
  });
}
