import 'package:flutter/material.dart';

import '../models/settings.dart';
import '../view_models/settings_view_model.dart';

class SettingsView extends StatefulWidget {
  final SettingsViewModel viewModel;

  const SettingsView({super.key, required this.viewModel});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadSettings();
  }

  Widget _buildNotificationsRow(Settings settings) {
    return SwitchListTile(
      title: const Text('Notifications'),
      value: settings.notificationsEnabled,
      onChanged: (value) {
        widget.viewModel.updateSettings(
          Settings(language: settings.language, notificationsEnabled: value),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
