import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../main.dart';
import '../view_models/settings_view_model.dart';
import 'addresses_view.dart';
import 'favourites_view.dart';
import 'order_history_view.dart';
import 'settings_view.dart';

class AccountView extends StatefulWidget {
  final SettingsViewModel settingsViewModel;

  const AccountView({super.key, required this.settingsViewModel});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  bool _isSignedIn = false;
  String? _displayName;
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_updateSignedInState);
    _isSignedIn = client.auth.isAuthenticated;
    if (_isSignedIn) _loadUserProfile();
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_updateSignedInState);
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    try {
      final profile = await client.modules.serverpod_auth_core.userProfileInfo.get();
      if (!mounted) return;
      setState(() {
        _displayName = profile.fullName ?? profile.userName;
        _userEmail = profile.email;
      });
    } catch (_) {}
  }

  void _updateSignedInState() {
    setState(() {
      _isSignedIn = client.auth.isAuthenticated;
      if (_isSignedIn) {
        _loadUserProfile();
      } else {
        _displayName = null;
        _userEmail = null;
      }
    });
  }

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SettingsView(viewModel: widget.settingsViewModel),
      ),
    );
  }

  Widget _buildSignedIn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 40),
        const Icon(Icons.account_circle, size: 80, color: Colors.deepOrange),
        const SizedBox(height: 12),
        Text(
          _displayName ?? 'My Account',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          _userEmail ?? 'Signed in',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(height: 32),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.favorite, color: Colors.deepOrange),
          title: const Text('Favourites'),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FavouritesView()),
          ),
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
        ListTile(
          leading: const Icon(Icons.receipt_long, color: Colors.deepOrange),
          title: const Text('Order History'),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const OrderHistoryView()),
          ),
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
        ListTile(
          leading: const Icon(Icons.location_on, color: Colors.deepOrange),
          title: const Text('My Addresses'),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddressesView()),
          ),
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
        ListTile(
          leading: const Icon(Icons.settings, color: Colors.deepOrange),
          title: const Text('Settings'),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () => _openSettings(context),
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.grey),
          title: const Text('Sign Out'),
          onTap: () async {
            await client.auth.signOutDevice();
          },
        ),
        const Divider(height: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: const Color(0xFFFAF7F2),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: _isSignedIn
          ? _buildSignedIn(context)
          : Center(child: SignInWidget(client: client, onAuthenticated: () {})),
    );
  }
}
