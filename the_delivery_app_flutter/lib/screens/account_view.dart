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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.account_circle, size: 80, color: Colors.deepOrange),
          const SizedBox(height: 16),
          const Text('You are signed in.', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              await client.auth.signOutDevice();
            },
            child: const Text('Sign Out'),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: () => _openSettings(context),
            icon: const Icon(Icons.settings),
            label: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: _isSignedIn
          ? _buildSignedIn(context)
          : Center(
              child: SignInWidget(
                client: client,
                onAuthenticated: () {},
              ),
            ),
    );
  }
}
