import 'package:serverpod/serverpod.dart';
import '../../generated/protocol.dart';
import '../../auth/auth_hooks.dart';
import 'dart:convert';

class UserProfileController extends Endpoint {

  Future<String> getCurrentUser(Session session) async {
    try {
      final user = await AuthHooks.getAppUser(session);
      if (user == null) {
        return jsonEncode({'success': false, 'errorMessage': 'Not authenticated'});
      }
      return jsonEncode({
        'success': true,
        'userId': user.id,
        'name': user.name,
        'email': user.email,
      });
    } catch (e) {
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }

  Future<String> getProfile(
    Session session,
    int userId,
  ) async {
    try {
      final user = await User.db.findById(session, userId);

      if (user == null) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'User not found',
          'errorCode': 'NOT_FOUND',
        });
      }

      final addresses = await Address.db.find(
        session,
        where: (t) => t.userId.equals(userId),
      );

      return jsonEncode({
        'success': true,
        'user': {
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'phone': user.phone,
          'avatarUrl': user.avatarUrl,
          'createdAt': user.createdAt.toIso8601String(),
          'addresses': addresses.map((a) => {
            'id': a.id,
            'isDefault': a.isDefault,
            'addressLine1': a.addressLine1,
            'addressLine2': a.addressLine2,
            'city': a.city,
            'postcode': a.postcode,
            'country': a.country,
          }).toList(),
        },
      });
    } catch (e) {
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }

  Future<String> updateProfile(
    Session session,
    String requestJson,
  ) async {
    try {
      final data = jsonDecode(requestJson) as Map<String, dynamic>;
      final userId = data['userId'] as int;

      final user = await User.db.findById(session, userId);

      if (user == null) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'User not found',
          'errorCode': 'NOT_FOUND',
        });
      }

      // Update fields if provided
      if (data['name'] != null) user.name = data['name'] as String;
      if (data['phone'] != null) user.phone = data['phone'] as String;
      if (data['avatarUrl'] != null) user.avatarUrl = data['avatarUrl'] as String;
      user.updatedAt = DateTime.now();

      await User.db.updateRow(session, user);

      return jsonEncode({
        'success': true,
        'message': 'Profile updated',
      });
    } catch (e) {
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }

  Future<String> addAddress(
    Session session,
    String requestJson,
  ) async {
    try {
      final data = jsonDecode(requestJson) as Map<String, dynamic>;
      final userId = data['userId'] as int;
      final isDefault = data['isDefault'] as bool? ?? false;

      // If setting as default, unset other defaults
      if (isDefault) {
        final existingAddresses = await Address.db.find(
          session,
          where: (t) => t.userId.equals(userId),
        );
        for (final addr in existingAddresses) {
          if (addr.isDefault) {
            addr.isDefault = false;
            await Address.db.updateRow(session, addr);
          }
        }
      }

      final address = await Address.db.insertRow(
        session,
        Address(
          userId: userId,
          isDefault: isDefault,
          country: data['country'] as String,
          city: data['city'] as String,
          postcode: data['postcode'] as String,
          addressLine1: data['addressLine1'] as String,
          addressLine2: data['addressLine2'] as String?,
        ),
      );

      return jsonEncode({
        'success': true,
        'message': 'Address added',
        'addressId': address.id,
      });
    } catch (e) {
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }

  Future<String> deleteAddress(
    Session session,
    int addressId,
  ) async {
    try {
      final address = await Address.db.findById(session, addressId);

      if (address == null) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Address not found',
          'errorCode': 'NOT_FOUND',
        });
      }

      await Address.db.deleteRow(session, address);

      return jsonEncode({
        'success': true,
        'message': 'Address deleted',
      });
    } catch (e) {
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }
}
