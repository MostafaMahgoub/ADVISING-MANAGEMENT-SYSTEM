import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gradproject/components/default_button.dart';

import '../../../constants.dart';

class attendanceadmin extends StatelessWidget {
  static String routeName = "/attendanceadmin";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  String m;
  _MyHomePageState() {
    m = getRandomString(5);
  }
  //int _counter = 10;
  int seconds = 0;
  int minutes = 10;
  int hours = 0;
  Timer _timer;

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (minutes == 0 && hours == 0 && seconds == 0) {
            timer.cancel();
          } else {
            seconds = seconds - 1;
            if (seconds < 0) {
              minutes -= 1;
              seconds = 59;
              if (minutes < 0) {
                hours -= 1;
                minutes = 59;
              }
            }
          }
        },
      ),
    );

    /* _counter = 10;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    }); */
  }

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20),
              child: DefaultButton(
                text: "Start session",
                press: () => {_startTimer()},
              ),
            ),
            SizedBox(height: 50),
            Spacer(),
            (seconds > 0)
                ? Text("Password:" + m)
                : (minutes > 0)
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
              '$hours : $minutes : $seconds',
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
