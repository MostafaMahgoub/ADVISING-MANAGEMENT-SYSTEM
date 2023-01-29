import 'package:flutter/material.dart';
import 'package:gradproject/components/default_button.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/screens/privileges/student_privileges/NOStudents.dart';
import 'package:gradproject/screens/profile/components/profile_menu.dart';

class RegistPage extends StatefulWidget {
  static String routeName = "/regist_page";

  @override
  _RegistPageState createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  var constant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          "Registration page",
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
              text: "Add or remove courses",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                constant = 1;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NOStudents(constant: constant),
                    ));
              },
            ),
            ProfileMenu(
              text: "Course registration",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                constant = 2;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NOStudents(constant: constant),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
