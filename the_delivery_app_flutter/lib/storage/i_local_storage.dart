abstract class ILocalStorage {
  Future<void> save(String key, String value);
  Future<String?> load(String key);
}
