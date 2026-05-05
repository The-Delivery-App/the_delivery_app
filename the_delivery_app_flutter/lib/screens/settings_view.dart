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

  Widget _buildSectionHeader(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildLanguageRow(Settings settings) {
    const languages = {
      'en': 'English',
      'tr': 'Türkçe',
      'de': 'Deutsch',
      'fr': 'Français',
    };
    return ListTile(
      leading: const Icon(Icons.language, color: Colors.deepOrange),
      title: const Text('Language'),
      subtitle: const Text('App display language'),
      trailing: DropdownButton<String>(
        value: settings.language,
        underline: const SizedBox.shrink(),
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
      secondary: const Icon(Icons.notifications_outlined, color: Colors.deepOrange),
      title: const Text('Notifications'),
      subtitle: const Text('Push notifications'),
      value: settings.notificationsEnabled,
      activeThumbColor: Colors.deepOrange,
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
              _buildSectionHeader('PREFERENCES'),
              _buildLanguageRow(settings),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _buildNotificationsRow(settings),
              const Divider(height: 1),
            ],
          ),
        );
      },
    );
  }
}
