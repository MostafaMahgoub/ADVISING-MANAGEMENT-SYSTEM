import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:gradproject/components/default_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../../size_config.dart';

class attendancedoctor extends StatelessWidget {
  static String routeName = "/attendancedoctor";
  int time;
  String code;
  attendancedoctor({this.time, this.code});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(time, code),
    );
  }
}

class MyHomePage extends StatefulWidget {
  int time;
  String code;
  MyHomePage(this.time, this.code);

  @override
  _MyHomePageState createState() => _MyHomePageState(time);
}

class _MyHomePageState extends State<MyHomePage> {

  int time;
  var status, status2;
  var data;
  var data2;
  _MyHomePageState(this.time) {
    m = getRandomString(5);
  }
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  String m;
  //int _counter = 10;
  int seconds = 0;
  //int minutes = time;
  int hours = 0;
  Timer _timer;
  bool isEnabled = true;

  startse(int st) async {
    isEnabled = false;

    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl = "https://extra-hint.herokuapp.com/api/advisor/Layer_f";
    final response = await http.post(
      ServerUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${value}'
      },
      body: {
        'value': '${st}',
        'ccode': "${widget.code}",
        'token': '${m}',
        'is_lec': '1',
      },
    );
    status = response.body.contains("err");
    data = jsonDecode(response.body);
    if (status) {
      print("data :${data}");
      Fluttertoast.showToast(
        msg: '${data['errors']['ccode'][0]}',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {
      if (st==1)
        {
          isEnabled = false;
       _startTimer();}
      Fluttertoast.showToast(
        msg: '${data}',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  void _startTimer() {
    isEnabled = false;

    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (time == 0 && hours == 0 && seconds == 0) {
            startse(0);
            timer.cancel();
          } else {
            seconds = seconds - 1;
            if (seconds < 0) {
              time -= 1;
              seconds = 59;
              if (time < 0) {
                hours -= 1;
                time = 59;
              }
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          "Attendance",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: getProportionateScreenHeight(60)),
            Padding(
              padding: const EdgeInsets.all(40),
              child: DefaultButton(
                text: "Start session",
                press: () => isEnabled ? startse(1) : null,//isEnabled ? ()=> startse(1) :null,
              ),
            ),
            SizedBox(height: 50),
            Spacer(),
            (seconds > 0)
                ? Text("Password:" + m)
                : (time > 0)
                    ? Text("Password:" + m)
                    : (hours > 0)
                        ? Text("Password:" + m)
                        : Text(
                            "Session is over!",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
            Text(
              '$hours : $time : $seconds',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 48,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
