import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/body_admin.dart';
import 'components/body_student.dart';
import 'components/body_doctor.dart';
import 'package:gradproject/constants.dart';

import 'components/bodyadmintest.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";
  String email;
  String password;

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  String email;
  String password;
  var usertype;
  _read() async {
    final pref = await SharedPreferences.getInstance();
    final key = 'usertype';
    setState(() {
      usertype = pref.get(key);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (usertype == '3') {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ),
        body: Bodyadmin(),
      );
    } else if (usertype == '2') {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text("Profile"),
        ),
        body: Bodydoctor(),
      );
    } else if (usertype == '1') {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text("Profile"),
        ),
        body: Bodystudent(),
      );
    }
  }
}
