import 'dart:convert';

import '../models/settings.dart';
import '../storage/i_local_storage.dart';
import 'interfaces/i_settings_repository.dart';

class SettingsRepository implements ISettingsRepository {
  final ILocalStorage _storage;
  static const _key = 'settings';

  SettingsRepository({required ILocalStorage storage}) : _storage = storage;

  @override
  Future<Settings> getSettings() async {
    final raw = await _storage.load(_key);
    if (raw == null) {
      return const Settings(language: 'en', notificationsEnabled: true);
    }
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return Settings(
      language: map['language'],
      notificationsEnabled: map['notificationsEnabled'],
    );
  }
}
