import 'package:flutter/foundation.dart';

import '../models/settings.dart';
import '../repositories/interfaces/i_settings_repository.dart';
import '../state/settings_state.dart';

class SettingsViewModel extends ChangeNotifier {
  final ISettingsRepository _repository;
  SettingsState _state = SettingsState(
    settings: const Settings(language: 'en', notificationsEnabled: true),
  );

  SettingsViewModel({required ISettingsRepository repository})
      : _repository = repository;
}
