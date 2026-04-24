import 'dart:convert';

import '../models/settings.dart';
import '../storage/i_local_storage.dart';
import 'interfaces/i_settings_repository.dart';

class SettingsRepository implements ISettingsRepository {
  final ILocalStorage _storage;
  static const _key = 'settings';

  SettingsRepository({required ILocalStorage storage}) : _storage = storage;
}
