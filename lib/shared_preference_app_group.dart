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

  /// Reads a value of any type from persistent storage under the specified app group.
  ///
  /// If the persistent storage does not contains [key], then [null] will be returned
  static Future<dynamic?> get(String key) async {
    return await _channel.invokeMethod('get', {'key': key});
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
