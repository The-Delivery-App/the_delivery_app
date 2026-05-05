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

  Widget _buildLanguageRow(Settings settings) {
    const languages = {
      'en': 'English',
      'tr': 'Türkçe',
      'de': 'Deutsch',
      'fr': 'Français',
    };
    return ListTile(
      title: const Text('Language'),
      trailing: DropdownButton<String>(
        value: settings.language,
        items: languages.entries
            .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
            .toList(),
        onChanged: (value) {
          if (value == null) return;
          widget.viewModel.updateSettings(
            Settings(language: value, notificationsEnabled: settings.notificationsEnabled),
          );
        },
      ),
    );
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
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final settings = widget.viewModel.getState().settings;
        return Scaffold(
          appBar: AppBar(title: const Text('Settings')),
          body: ListView(
            children: [
              _buildLanguageRow(settings),
              const Divider(height: 1),
              _buildNotificationsRow(settings),
            ],
          ),
        );
      },
    );
  }
}
