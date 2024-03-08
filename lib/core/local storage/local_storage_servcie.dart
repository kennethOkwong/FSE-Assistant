import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageService {
  final storage = const FlutterSecureStorage();

  Future<void> storeItem({
    required String key,
    required String? value,
  }) async {
    await storage.write(key: key, value: value);
  }

  Future<dynamic> readItem(String key) async {
    return await storage.read(key: key);
  }

  Future<void> deleteItem(String key) async {
    await storage.delete(key: key);
  }

  Future<void> deleteAllItems() async {
    await storage.deleteAll();
  }
}
