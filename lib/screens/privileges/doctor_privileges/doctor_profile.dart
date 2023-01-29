import 'package:gradproject/screens/profile/components/body_doctor.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/constants.dart';

class doctorProfileScreen extends StatefulWidget {
  static String routeName = "/profile";
  String email;
  String password;

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<doctorProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: Bodydoctor(),
    );
  }
}
