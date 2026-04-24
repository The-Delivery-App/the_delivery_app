import 'i_local_storage.dart';

class LocalStorage implements ILocalStorage {
  final Map<String, String> _store = {};

  @override
  Future<void> save(String key, String value) async {
    _store[key] = value;
  }

  @override
  Future<String?> load(String key) async {
    return _store[key];
  }
}
