# Shared preferences with App Group

[![pub package](https://img.shields.io/pub/v/shared_preference_app_group.svg)](https://pub.dev/packages/shared_preference_app_group)

Shared preference supporting iOS App Group capability (using `-[NSUserDefaults initWithSuiteName:]`)

> Note: Only support iOS

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
```

```dart
// Get values
bool boolValue = await SharedPreferenceAppGroup.get('MY_BOOL_KEY');
String stringValue = await SharedPreferenceAppGroup.get('MY_STRING_KEY');
int intValue = await SharedPreferenceAppGroup.get('MY_INT_KEY');
double doubleValue = await SharedPreferenceAppGroup.get('MY_DOUBLE_KEY');
```

Please see the example app of this plugin for a full example.

## Related projects

If you need to implement screen capture, I have developed some helpful plugins:

### iOS

**[ReplayKit Launcher](https://pub.dev/packages/replay_kit_launcher)**: A flutter plugin of the launcher used to open `RPSystemBroadcastPickerView` for iOS

### Android

**[MediaProjection Creator](https://pub.dev/packages/media_projection_creator)**: A flutter plugin of the creator used to create `MediaProjection` instance (with requesting permission) for Android

## Contributing

Everyone is welcome to contribute code via pull requests, to help people asking for help, to add to our documentation, or to help out in any other way.
