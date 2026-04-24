import '../../models/settings.dart';

abstract class ISettingsRepository {
  Future<Settings> getSettings();
  Future<void> saveSettings(Settings settings);
}
