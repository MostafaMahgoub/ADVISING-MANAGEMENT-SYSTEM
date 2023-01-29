import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gradproject/components/custom_surfix_icon.dart';
import 'package:gradproject/components/default_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class attendancestudent extends StatelessWidget {
  static String routeName = "/attendancestudent";
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
  var status, status2;
  var data;
  var data2;
  bool pressed = false;

  TextEditingController _pass = TextEditingController();
  String password;

  startse() async {
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
        'token': '${_pass.text.trim()}',
      },
    );
    status = response.body.contains("err");
    data = jsonDecode(response.body);
    if (status) {
      print("data :${data}");
    } else {
      print("data:${data}");
    }

    Fluttertoast.showToast(
      msg: status ? "there is no session with this pass" : 'attendance success',
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.black,
      textColor: Colors.white,
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
            SizedBox(height: 30),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: buildPasswordFormField(),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: DefaultButton(
                  text: "Submit",
                  press: () {
                    Fluttertoast.showToast(
                      msg: 'checking...',
                      toastLength: Toast.LENGTH_LONG,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                    startse();
                  }),
            ),
            SizedBox(height: 50),
            Spacer(),
          ],
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter session password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10),
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
      controller: _pass,
    );
  }
}
