import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pockettask/model/task_model.dart';






class SecureCache {
  SecureCache._();

  // Singleton instance
  static final SecureCache _instance = SecureCache._();

  // Getter to access the singleton instance
  static SecureCache get instance => _instance;

  static late Box _box;

  static late Box themeBox;

  // Initialize the storage (run once at app start)
  static Future<void> init() async {
    await Hive.initFlutter();
    // Register Model Adapter
    Hive.registerAdapter(TaskAdapter());
    // Open a Hive box/db named 'tasks' (stores tasks objects/data)
    _box = await Hive.openBox('tasks');
    // Open a Hive box/db named 'themeBox' (stores theme state)
    themeBox = await Hive.openBox('themeBox');
    log("hive boxes initialized");
  }

  static List<T> getAllItems<T>() {
    try {
      return _box.values.cast<T>().toList();
    } catch (e) {
      print('Error fetching items: $e');
      return [];
    }
  }

  // Retrieve data from cache (auto-detect type)
  static T? read<T>(String key) {
    return _box.get(key) as T?;
  }

  // Write data to cache
  static Future<void> write<T>(String key, T value) async {
    await _box.put(key, value);
  }

  // Update a specific data to cache
  static Future<void> update<T>(int index, T value) async {
    await _box.putAt(index, value);
  }

  // Remove data from cache
  static Future<void> remove(String key) async {
    await _box.delete(key);
  }
  static Future<void> removeAt(int index) async {
    await _box.deleteAt(index);
  }

  // Check if a key exists in cache
  static bool containsKey(String key) {
    return _box.containsKey(key);
  }

  // Clear all cache data
  static Future<void> clearCache() async {
    await _box.clear();
  }

  // Close the Hive box when done (optional)
  static Future<void> close() async {
    await _box.close();
  }
}
