import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:shared_preference_app_group/shared_preference_app_group.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // Fill in the app group id set in the Xcode project
  String appGroupID = 'group.com.example.your_awesome_project';

  Map<String, dynamic> myParams = {
    'MY_BOOL_KEY': false,
    'MY_STRING_KEY': 'null',
    'MY_INT_KEY': 0,
    'MY_DOUBLE_KEY': 0.1
  };

  String displayParamsText = '';

  @override
  void initState() {
    super.initState();
    // The app group must be set up first
    SharedPreferenceAppGroup.setAppGroup(appGroupAndroid: 'com.example.test1', appGroupIOS: appGroupID);
  }

  void setMyParams() {
    SharedPreferenceAppGroup.setBool('MY_BOOL_KEY', true);
    SharedPreferenceAppGroup.setString('MY_STRING_KEY', 'STRING_VALUE');
    SharedPreferenceAppGroup.setInt('MY_INT_KEY', 42);
    SharedPreferenceAppGroup.setDouble('MY_DOUBLE_KEY', 9.9);
  }

  Future<void> getMyParams() async {
    bool boolValue = await SharedPreferenceAppGroup.get('MY_BOOL_KEY');
    String stringValue = await SharedPreferenceAppGroup.get('MY_STRING_KEY');
    int intValue = await SharedPreferenceAppGroup.get('MY_INT_KEY');
    double doubleValue = await SharedPreferenceAppGroup.get('MY_DOUBLE_KEY');

    this.myParams = {
      'MY_BOOL_KEY': boolValue,
      'MY_STRING_KEY': stringValue,
      'MY_INT_KEY': intValue,
      'MY_DOUBLE_KEY': doubleValue
    };

    String text = '';
    for (String key in this.myParams.keys) {
      text += '$key = ${this.myParams[key]}\n';
    }

    setState(() {
      this.displayParamsText = text;
    });
  }

  Future<void> getAllParams() async {
    Map<String, dynamic> allPreferences = await SharedPreferenceAppGroup.getAll();

    String text = '';
    for (String key in allPreferences.keys) {
      text += '$key = ${this.myParams[key]}\n';
    }

    setState(() {
      this.displayParamsText = text;
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
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ListView(
              children: [
                Padding(padding: const EdgeInsets.only(top: 50.0)),
                Text('Only support iOS'),
                Padding(padding: const EdgeInsets.only(top: 10.0)),
                Text('You should first enable the AppGroup capability for the Runner Target of your Xcode project, and then set the app group id to this plugin through `setAppGroup` function',
                  style: TextStyle(
                    fontSize: 11.0,
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
                    child: Text('SetParams',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onPressed: setMyParams,
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
                    child: Text('RemoveParams',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: removeMyParams,
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
                    child: Text('RemoveAll',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onPressed: removeAll,
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
                    child: Text('GetAllParams',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onPressed: getAllParams,
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
                    child: Text('GetMyParams',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onPressed: getMyParams,
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 10.0)),
                Text(displayParamsText,
                  style: TextStyle(
                    fontSize: 11.0,
                  ),
                ),
              ],
            )
          )
        ),
      ),
    );
  }
}
