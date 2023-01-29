import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/components/custom_surfix_icon.dart';
import 'package:gradproject/components/default_button.dart';

import 'package:gradproject/constants.dart';
import 'package:gradproject/screens/profile/components/profile_menu.dart';

import '../../../size_config.dart';
import 'attendance_doctor.dart';

class Attendancemain extends StatefulWidget {
  static String routeName = "/Attendancemain";

  @override
  _Attendancemain createState() => _Attendancemain();
}

class _Attendancemain extends State<Attendancemain> {
  TextEditingController _TimeTextController = TextEditingController();
  TextEditingController _codeTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(60)),
              buildCourseFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildTimeFormField(),
              SizedBox(height: getProportionateScreenHeight(100)),
              DefaultButton(
                text: "Continue",
                press: () {
                  _sendDataToSecondScreen(context);
                },
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildCourseFormField() {
    return TextFormField(
      controller: _codeTextController,
      decoration: InputDecoration(
        labelText: "Course code",
        hintText: "Enter course code",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildTimeFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Time",
        hintText: "Enter time in minutes",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,

        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Bell.svg"),
      ),
      keyboardType: TextInputType.number,
      controller: _TimeTextController,
    );
  }

  void _sendDataToSecondScreen(BuildContext context) {
    int time = int.parse(_TimeTextController.text);
    String code = _codeTextController.text.trim().toUpperCase();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => attendancedoctor(
            time: time,
            code: code,
          ),
        ));
  }
}
