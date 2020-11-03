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

  @override
  void initState() {
    super.initState();
    // The app group must be set up first
    SharedPreferenceAppGroup.setAppGroup(appGroupID);
  }

  void setParams() {
    SharedPreferenceAppGroup.setBool('MY_BOOL_KEY', true);
    SharedPreferenceAppGroup.setString('MY_STRING_KEY', 'STRING_VALUE');
    SharedPreferenceAppGroup.setInt('MY_INT_KEY', 42);
    SharedPreferenceAppGroup.setDouble('MY_DOUBLE_KEY', 9.9);
  }

  Future<Map<String, dynamic>> getParams() async {
    bool boolValue = await SharedPreferenceAppGroup.get('MY_BOOL_KEY');
    String stringValue = await SharedPreferenceAppGroup.get('MY_STRING_KEY');
    int intValue = await SharedPreferenceAppGroup.get('MY_INT_KEY');
    double doubleValue = await SharedPreferenceAppGroup.get('MY_DOUBLE_KEY');

    Map<String, dynamic> map = {
      'MY_BOOL_KEY': boolValue,
      'MY_STRING_KEY': stringValue,
      'MY_INT_KEY': intValue,
      'MY_DOUBLE_KEY': doubleValue
    };

    return map;
  }

  Future<void> getAllAndPrint() async {
    Map<String, dynamic> allPreferences = await SharedPreferenceAppGroup.getAll();
    for (String key in allPreferences.keys) {
      print('Key: $key, Value: ${allPreferences[key]}');
    }
  }

  Future<void> removeParams() async {
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
            child: Column(
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
                    onPressed: setParams,
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
                    onPressed: removeParams,
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
                    color: Color(0xff0e88eb),
                  ),
                  width: 240.0,
                  height: 50.0,
                  child: CupertinoButton(
                    child: Text('GetAllAndPrint',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onPressed: getAllAndPrint,
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
                    child: Text('GetParams',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        getParams().then((value) => this.myParams = value);
                      });
                    },
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 10.0)),
                Text('MY_BOOL_KEY: ${this.myParams['MY_BOOL_KEY']}\n'
                     'MY_STRING_KEY: ${this.myParams['MY_STRING_KEY']}\n'
                     'MY_INT_KEY: ${this.myParams['MY_INT_KEY']}\n'
                     'MY_DOUBLE_KEY: ${this.myParams['MY_DOUBLE_KEY']}',
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
