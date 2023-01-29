import 'package:gradproject/screens/profile/components/body_admin.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/screens/profile/components/bodyadmintest.dart';

class adminProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<adminProfileScreen> {
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
      body: Bodyadmin(),
    );
  }
}
