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
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
