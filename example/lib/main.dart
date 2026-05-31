import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:shared_preference_app_group/shared_preference_app_group.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Fill in the App Group identifier from the Xcode entitlements file.
  // On macOS, pass the full identifier exactly as listed there.
  String appGroupID = 'group.com.example.your_awesome_project';

  Map<String, dynamic> myParams = {
    'MY_BOOL_KEY': false,
    'MY_STRING_KEY': 'null',
    'MY_INT_KEY': 0,
    'MY_DOUBLE_KEY': 0.1,
  };

  String displayParamsText = '';

  @override
  void initState() {
    super.initState();
    // The app group must be set up first
    SharedPreferenceAppGroup.setAppGroup(appGroupID);
  }

  void setMyParams() {
    SharedPreferenceAppGroup.setBool('MY_BOOL_KEY', true);
    SharedPreferenceAppGroup.setString('MY_STRING_KEY', 'STRING_VALUE');
    SharedPreferenceAppGroup.setInt('MY_INT_KEY', 42);
    SharedPreferenceAppGroup.setDouble('MY_DOUBLE_KEY', 9.9);
    SharedPreferenceAppGroup.setStringList('MY_STRING_ARRAY', [
      "element1",
      "element2",
      "element3",
    ]);
  }

  Future<void> getMyParams() async {
    bool boolValue =
        await SharedPreferenceAppGroup.getBool('MY_BOOL_KEY') ?? false;
    String stringValue =
        await SharedPreferenceAppGroup.getString('MY_STRING_KEY') ?? 'null';
    int intValue = await SharedPreferenceAppGroup.getInt('MY_INT_KEY') ?? 0;
    double doubleValue =
        await SharedPreferenceAppGroup.getDouble('MY_DOUBLE_KEY') ?? 0.0;
    List<String> stringArrayValue =
        await SharedPreferenceAppGroup.getStringList('MY_STRING_ARRAY') ?? [];

    myParams = {
      'MY_BOOL_KEY': boolValue,
      'MY_STRING_KEY': stringValue,
      'MY_INT_KEY': intValue,
      'MY_DOUBLE_KEY': doubleValue,
      'MY_STRING_ARRAY': stringArrayValue,
    };

    String text = '';
    for (String key in myParams.keys) {
      text += '$key = ${myParams[key]}\n';
    }

    setState(() {
      displayParamsText = text;
    });
  }

  Future<void> getAllParams() async {
    Map<String, dynamic> allPreferences =
        await SharedPreferenceAppGroup.getAll();

    String text = '';
    for (String key in allPreferences.keys) {
      text += '$key = ${myParams[key]}\n';
    }

    setState(() {
      displayParamsText = text;
    });
  }

  Future<void> removeMyParams() async {
    await SharedPreferenceAppGroup.remove('MY_BOOL_KEY');
    await SharedPreferenceAppGroup.remove('MY_STRING_KEY');
    await SharedPreferenceAppGroup.remove('MY_INT_KEY');
    await SharedPreferenceAppGroup.remove('MY_DOUBLE_KEY');
  }

  Future<void> removeAll() async {
    await SharedPreferenceAppGroup.removeAll();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ListView(
              children: [
                Padding(padding: const EdgeInsets.only(top: 50.0)),
                Text('Supports iOS and macOS'),
                Padding(padding: const EdgeInsets.only(top: 10.0)),
                Text(
                  'You should first enable the App Group capability for the Runner target of your Xcode project, and then pass the same app group identifier to this plugin through the `setAppGroup` function.',
                  style: TextStyle(fontSize: 11.0),
                ),
                Padding(padding: const EdgeInsets.only(top: 10.0)),
                Container(
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color(0xff0e88eb),
                  ),
                  width: 240.0,
                  height: 50.0,
                  child: CupertinoButton(
                    onPressed: setMyParams,
                    child: Text(
                      'SetParams',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 10.0)),
                Container(
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color(0xff0e88eb),
                  ),
                  width: 240.0,
                  height: 50.0,
                  child: CupertinoButton(
                    onPressed: removeMyParams,
                    child: Text(
                      'RemoveParams',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 10.0)),
                Container(
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color(0xff0e88eb),
                  ),
                  width: 240.0,
                  height: 50.0,
                  child: CupertinoButton(
                    onPressed: removeAll,
                    child: Text(
                      'RemoveAll',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 10.0)),
                Container(
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color(0xff0b5eda),
                  ),
                  width: 240.0,
                  height: 50.0,
                  child: CupertinoButton(
                    onPressed: getAllParams,
                    child: Text(
                      'GetAllParams',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 10.0)),
                Container(
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color(0xff0b5eda),
                  ),
                  width: 240.0,
                  height: 50.0,
                  child: CupertinoButton(
                    onPressed: getMyParams,
                    child: Text(
                      'GetMyParams',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 10.0)),
                Text(displayParamsText, style: TextStyle(fontSize: 11.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
