# Shared preferences with App Group

[![pub package](https://img.shields.io/pub/v/shared_preference_app_group.svg)](https://pub.dev/packages/shared_preference_app_group)

Shared preferences for iOS and macOS App Groups (using `-[NSUserDefaults initWithSuiteName:]`)

> Note: Supports iOS and macOS

## Compatibility

This plugin currently supports:

- Flutter `>=3.41.0`
- Dart `>=3.11.0`
- iOS `>=13.0`
- macOS `>=10.15`

The iOS and macOS implementations support both CocoaPods and Swift Package Manager. Swift Package Manager is the default dependency manager for newer Flutter projects, while CocoaPods remains supported for existing projects.

> On macOS, App Groups require the app to use the App Sandbox capability and to list the group identifier under `com.apple.security.application-groups` in its `.entitlements` file. The value passed to `setAppGroup` must exactly match an identifier in the entitlements file; this plugin does not add a team identifier automatically.

## Usage

To use this plugin, add `shared_preference_app_group` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example

```dart
// The app group must be set up first
await SharedPreferenceAppGroup.setAppGroup(appGroupID);
```

```dart
// Set values using [[NSUserDefaults alloc] initWithSuiteName:appGroupID]
await SharedPreferenceAppGroup.setBool('MY_BOOL_KEY', true);
await SharedPreferenceAppGroup.setString('MY_STRING_KEY', 'STRING_VALUE');
await SharedPreferenceAppGroup.setInt('MY_INT_KEY', 42);
await SharedPreferenceAppGroup.setDouble('MY_DOUBLE_KEY', 9.9);
await SharedPreferenceAppGroup.setStringList('MY_STRING_ARRAY', ["element1", "element2", "element3"]);
```

```dart
// Get values
bool boolValue = await SharedPreferenceAppGroup.getBool('MY_BOOL_KEY') ?? false;
String stringValue = await SharedPreferenceAppGroup.getString('MY_STRING_KEY') ?? 'null';
int intValue = await SharedPreferenceAppGroup.getInt('MY_INT_KEY') ?? 0;
double doubleValue = await SharedPreferenceAppGroup.getDouble('MY_DOUBLE_KEY') ?? 0.0;
List<String> stringArrayValue = await SharedPreferenceAppGroup.getStringList('MY_STRING_ARRAY') ?? [];
```

Please see the example app of this plugin for a full example.

## Related projects

If you need to implement screen capture, I have developed some helpful plugins:

### iOS

**[ReplayKit Launcher](https://pub.dev/packages/replay_kit_launcher)**: A flutter plugin of the launcher used to open `RPSystemBroadcastPickerView` for iOS

### Android

**[MediaProjection Creator](https://pub.dev/packages/media_projection_creator)**: A flutter plugin of the creator used to create `MediaProjection` instance (with requesting permission) for Android

### Another practical demo

**[https://github.com/zegoim/zego-express-example-screen-capture-flutter](https://github.com/zegoim/zego-express-example-screen-capture-flutter)**

This demo implements screen live broadcast on iOS/Android by using the **[ZEGO Express Audio and Video Flutter SDK](https://pub.dev/packages/zego_express_engine)**

## Contributing

Everyone is welcome to contribute code via pull requests, to help people asking for help, to add to our documentation, or to help out in any other way.
