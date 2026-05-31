import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';

void main() {
  const MethodChannel channel = MethodChannel('shared_preference_app_group');
  final List<MethodCall> calls = <MethodCall>[];

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    calls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          calls.add(methodCall);
          return switch (methodCall.method) {
            'getBool' => true,
            'getInt' => 42,
            'getDouble' => 4.2,
            'getString' => 'value',
            'getStringArray' => <String>['a', 'b'],
            'getAll' => <String, Object>{'key': 'value'},
            _ => null,
          };
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('setAppGroup forwards the app group identifier', () async {
    await SharedPreferenceAppGroup.setAppGroup('group.example');

    expect(calls, hasLength(1));
    expect(calls.single.method, 'setAppGroup');
    expect(calls.single.arguments, <String, Object>{
      'appGroup': 'group.example',
    });
  });

  test('setters forward values to the native method channel', () async {
    await SharedPreferenceAppGroup.setBool('boolKey', true);
    await SharedPreferenceAppGroup.setInt('intKey', 42);
    await SharedPreferenceAppGroup.setDouble('doubleKey', 4.2);
    await SharedPreferenceAppGroup.setString('stringKey', 'value');
    await SharedPreferenceAppGroup.setStringList('listKey', <String>['a', 'b']);

    expect(calls.map((MethodCall call) => call.method), <String>[
      'setBool',
      'setInt',
      'setDouble',
      'setString',
      'setStringArray',
    ]);
    expect(calls[0].arguments, <String, Object>{
      'key': 'boolKey',
      'value': true,
    });
    expect(calls[4].arguments, <String, Object>{
      'key': 'listKey',
      'value': <String>['a', 'b'],
    });
  });

  test('setting a null value removes the key', () async {
    await SharedPreferenceAppGroup.setString('stringKey', null);

    expect(calls, hasLength(1));
    expect(calls.single.method, 'remove');
    expect(calls.single.arguments, <String, Object>{'key': 'stringKey'});
  });

  test('getters convert native channel values', () async {
    expect(await SharedPreferenceAppGroup.getBool('boolKey'), isTrue);
    expect(await SharedPreferenceAppGroup.getInt('intKey'), 42);
    expect(await SharedPreferenceAppGroup.getDouble('doubleKey'), 4.2);
    expect(await SharedPreferenceAppGroup.getString('stringKey'), 'value');
    expect(await SharedPreferenceAppGroup.getStringList('listKey'), <String>[
      'a',
      'b',
    ]);
    expect(await SharedPreferenceAppGroup.getAll(), <String, Object>{
      'key': 'value',
    });
  });
}
