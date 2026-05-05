import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../main.dart';
import '../view_models/settings_view_model.dart';
import 'settings_view.dart';

class AccountView extends StatefulWidget {
  final SettingsViewModel settingsViewModel;

  const AccountView({super.key, required this.settingsViewModel});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_updateSignedInState);
    _isSignedIn = client.auth.isAuthenticated;
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_updateSignedInState);
    super.dispose();
  }

  void _updateSignedInState() {
    setState(() {
      _isSignedIn = client.auth.isAuthenticated;
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
        const Text(
          'My Account',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          'Signed in',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(height: 32),
        const Divider(height: 1),
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
      appBar: AppBar(title: const Text('Account')),
      body: _isSignedIn
          ? _buildSignedIn(context)
          : Center(child: SignInWidget(client: client, onAuthenticated: () {})),
    );
  }
}
