
import 'dart:async';

import 'package:flutter/services.dart';

class SharedPreferenceAppGroup {
  static const MethodChannel _channel =
      const MethodChannel('shared_preference_app_group');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

}
