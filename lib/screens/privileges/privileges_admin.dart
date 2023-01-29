import 'package:gradproject/screens/privileges/admin_privileges/addcourse.dart';
import 'package:gradproject/screens/privileges/admin_privileges/adddepart.dart';
import 'package:gradproject/screens/privileges/admin_privileges/addsection.dart';
import 'package:gradproject/screens/privileges/admin_privileges/create_student.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/screens/privileges/admin_privileges/attendance_admin.dart';
import 'package:gradproject/screens/privileges/admin_privileges/deepsearch.dart';
import 'package:gradproject/screens/privileges/admin_privileges/updatestudent.dart';
import 'package:gradproject/screens/privileges/admin_privileges/updateuser.dart';
import 'package:gradproject/screens/profile/components/profile_menu.dart';
import 'package:gradproject/screens/sign_in/sign_up/sign_up_screen.dart';

import '../../constants.dart';
import 'StudentName.dart';

class privilegesadmin extends StatefulWidget {
  static String routeName = "/privilegesadmin";
  @override
  _privilegesadmin createState() => _privilegesadmin();
}

class _privilegesadmin extends State<privilegesadmin> {
  var constant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          "Admin privileges",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            ProfileMenu(
              text: "Add new user",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.pushNamed(context, SignUpScreen.routeName);
              },
            ),
            ProfileMenu(
              text: "Create New Student",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateStudent(),
                    ));
              },
            ),
            ProfileMenu(
              text: "Update student final degree",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                constant = 1;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => studentname(constant: constant),
                    ));
              },
            ),
            ProfileMenu(
              text: "Update student midterm degree",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                constant = 2;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => studentname(constant: constant),
                    ));
              },
            ),
            ProfileMenu(
              text: "Deep search",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.pushNamed(context, deepsearch.routeName);
              },
            ),
            ProfileMenu(
              text: "Update user",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.pushNamed(context, updateuser.routeName);
              },
            ),
            ProfileMenu(
              text: "Update student",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.pushNamed(context, updatestudent.routeName);
              },
            ),
            ProfileMenu(
              text: "Add department",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.pushNamed(context, adddepart.routeName);
              },
            ),
            ProfileMenu(
              text: "Add section",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.pushNamed(context, addsection.routeName);
              },
            ),
            ProfileMenu(
              text: "Add course",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.pushNamed(context, addcourse.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
