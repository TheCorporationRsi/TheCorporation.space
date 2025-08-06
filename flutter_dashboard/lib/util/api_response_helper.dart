/// Utility functions for safely accessing properties from dynamic API responses
class ApiResponseHelper {
  /// Safely get a property from a Map<String, dynamic> response
  static T? getProperty<T>(Map<String, dynamic>? data, String key) {
    if (data == null) return null;
    return data[key] as T?;
  }

  /// Safely get a string property
  static String getString(Map<String, dynamic>? data, String key, [String defaultValue = '']) {
    return getProperty<String>(data, key) ?? defaultValue;
  }

  /// Safely get an int property
  static int getInt(Map<String, dynamic>? data, String key, [int defaultValue = 0]) {
    return getProperty<int>(data, key) ?? defaultValue;
  }

  /// Safely get a double property
  static double getDouble(Map<String, dynamic>? data, String key, [double defaultValue = 0.0]) {
    return getProperty<double>(data, key) ?? defaultValue;
  }

  /// Safely get a bool property
  static bool getBool(Map<String, dynamic>? data, String key, [bool defaultValue = false]) {
    return getProperty<bool>(data, key) ?? defaultValue;
  }

  /// Safely get a list property
  static List<T> getList<T>(Map<String, dynamic>? data, String key, [List<T> defaultValue = const []]) {
    if (data == null || data[key] == null) return defaultValue;
    return List<T>.from(data[key] as List);
  }

  /// Convert a dynamic list to a list of maps
  static List<Map<String, dynamic>> getMapList(Map<String, dynamic>? data, String key) {
    if (data == null || data[key] == null) return [];
    final list = data[key] as List?;
    if (list == null) return [];
    return list.map((item) => Map<String, dynamic>.from(item)).toList();
  }

  /// Check if data has a specific property
  static bool hasProperty(Map<String, dynamic>? data, String key) {
    return data != null && data.containsKey(key);
  }

  /// Get nested property safely
  static T? getNestedProperty<T>(Map<String, dynamic>? data, List<String> keys) {
    if (data == null || keys.isEmpty) return null;
    
    dynamic current = data;
    for (String key in keys) {
      if (current is Map<String, dynamic> && current.containsKey(key)) {
        current = current[key];
      } else {
        return null;
      }
    }
    return current as T?;
  }
}
