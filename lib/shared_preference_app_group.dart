
import 'dart:async';

import 'package:flutter/services.dart';

class SharedPreferenceAppGroup {
  static const MethodChannel _channel =
      const MethodChannel('shared_preference_app_group');

  /// Set app group ID for iOS
  static Future<void> setAppGroup(String appGroup) async {
    await _channel.invokeMethod('setAppGroup', {
      'appGroup': appGroup
    });
  }

  /// Saves a boolean [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<void> setBool(String key, bool value) async {
    await _setValue('Bool', key, value);
  }

  /// Saves an integer [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<void> setInt(String key, int value) async {
    await _setValue('Int', key, value);
  }

  /// Saves a double [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<void> setDouble(String key, double value) async {
    await _setValue('Double', key, value);
  }

  /// Saves a string [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<void> setString(String key, String value) async {
    await _setValue('String', key, value);
  }

  /// Reads a value of any type from persistent storage.
  static Future<dynamic> get(String key) async {
    await _channel.invokeMethod('get', {
      'key': key
    });
  }

  /// Removes an entry from persistent storage.
  static Future<void> remove(String key) async {
    await _channel.invokeMethod('remove', {
      'key': key
    });
  }

  static Future<void> _setValue(String valueType, String key, Object value) async {
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
