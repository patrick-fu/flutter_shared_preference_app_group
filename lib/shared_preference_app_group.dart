import 'dart:async';

import 'package:flutter/services.dart';

class SharedPreferenceAppGroup {
  static const MethodChannel _channel =
      const MethodChannel('shared_preference_app_group');

  /// Set app group ID for iOS
  ///
  /// Developers must invoke this function to set the [appGroup] before invoking other functions.
  static Future<void> setAppGroup(String appGroup) async {
    await _channel.invokeMethod('setAppGroup', {'appGroup': appGroup});
  }

  /// Saves a boolean [value] to persistent storage under the specified app group.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<void> setBool(String key, bool? value) async {
    await _setValue('Bool', key, value);
  }

  /// Saves an integer [value] to persistent storage under the specified app group.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<void> setInt(String key, int? value) async {
    await _setValue('Int', key, value);
  }

  /// Saves a double [value] to persistent storage under the specified app group.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<void> setDouble(String key, double? value) async {
    await _setValue('Double', key, value);
  }

  /// Saves a string [value] to persistent storage under the specified app group.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<void> setString(String key, String? value) async {
    await _setValue('String', key, value);
  }

  /// Saves a string list [value] to persistent storage under the specified app group.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<void> setStringList(String key, List<String>? value) async {
    await _setValue('StringArray', key, value);
  }

  /// Reads a boolean value from persistent storage under the specified app group.
  ///
  /// If the persistent storage does not contains [key], then [null] will be returned
  static Future<bool?> getBool(String key) async {
    return await _channel.invokeMethod('getBool', {'key': key});
  }

  /// Reads a integer value from persistent storage under the specified app group.
  ///
  /// If the persistent storage does not contains [key], then [null] will be returned
  static Future<int?> getInt(String key) async {
    return await _channel.invokeMethod('getInt', {'key': key});
  }

  /// Reads a double value from persistent storage under the specified app group.
  ///
  /// If the persistent storage does not contains [key], then [null] will be returned
  static Future<double?> getDouble(String key) async {
    return await _channel.invokeMethod('getDouble', {'key': key});
  }

  /// Reads a string value from persistent storage under the specified app group.
  ///
  /// If the persistent storage does not contains [key], then [null] will be returned
  static Future<String?> getString(String key) async {
    return await _channel.invokeMethod('getString', {'key': key});
  }

  /// Reads a string array value from persistent storage under the specified app group.
  ///
  /// If the persistent storage does not contains [key], then [null] will be returned
  static Future<List<String>?> getStringList(String key) async {
    final List? receivedArray = await _channel.invokeMethod('getStringArray', {'key': key});
    if (receivedArray != null) {
      return receivedArray.cast<String>();
    }
    return null;
  }

  /// Reads all key-value pairs from persistent storage under the specified app group.
  static Future<Map<String, dynamic>> getAll() async {
    Map<dynamic, dynamic> allPrefs = await _channel.invokeMethod('getAll');
    return Map<String, dynamic>.from(allPrefs);
  }

  /// Removes an entry from persistent storage under the specified app group.
  static Future<void> remove(String key) async {
    await _channel.invokeMethod('remove', {'key': key});
  }

  /// Removes all entry from persistent storage under the specified app group.
  static Future<void> removeAll() async {
    await _channel.invokeMethod('removeAll');
  }

  static Future<void> _setValue(
      String valueType, String key, Object? value) async {
    if (value == null) {
      remove(key);
    } else {
      await _channel.invokeMethod('set$valueType', {
        'key': key,
        'value': value,
      });
    }
  }
}
