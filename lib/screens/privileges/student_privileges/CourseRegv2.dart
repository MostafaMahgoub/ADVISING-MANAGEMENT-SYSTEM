import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gradproject/components/custom_surfix_icon.dart';
import 'package:gradproject/components/default_button.dart';
import 'package:http/http.dart' as http;
import 'package:gradproject/constants.dart';
import 'package:gradproject/screens/profile/components/profile_menu.dart';

import '../../../size_config.dart';

class coursereg extends StatefulWidget {
  static String routeName = "/coursereg";

  String CoursesNO;
  coursereg({this.CoursesNO});
  @override
  _coursereg createState() => _coursereg(CoursesNO);
}

class _coursereg extends State<coursereg> {
  List<TextEditingController> codelist =
      List.generate(9, (index) => TextEditingController());
  int totalch = 0;
  var status;
  var data;

  enrollcourse(String cname) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl =
        "https://extra-hint.herokuapp.com/api/service/enroll_course";
    final response = await http.post(ServerUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${value}'
    }, body: {
      'ccode': cname,
    });
    status = response.body.contains("err");
    print("the orignal body  : ${response.body}");
    data = jsonDecode(response.body);
    if (status) {
      print("data :${data["errors"]}");
    } else {
      print("data: Succeed");
    }
  }

  loop(int x) {
    for (int i = 0; i < x; i++) {
      if (codelist[i].text != "") {
        enrollcourse(codelist[i].value.text.trim().toUpperCase());
        if (data["err"] != null) {
          Fluttertoast.showToast(
            msg: '${data["err"]}',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        } else {
          Fluttertoast.showToast(
            msg: '${data}',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        }
      } else {
        continue;
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  String CoursesNO;
  _coursereg(this.CoursesNO);
  @override
  Widget build(BuildContext context) {
    if (CoursesNO == '   1') {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            "Course registration",
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
                buildCourseFormField(codelist[0]),
                SizedBox(height: getProportionateScreenHeight(30)),
                DefaultButton(
                  text: "Register",
                  press: () {
                    loop(1);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else if (CoursesNO == '   2') {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            "Course registration",
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
                buildCourseFormField(codelist[0]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[1]),
                SizedBox(height: getProportionateScreenHeight(30)),
                DefaultButton(
                  text: "Register",
                  press: () {
                    loop(2);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else if (CoursesNO == '   3') {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            "Course registration",
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
                buildCourseFormField(codelist[0]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[1]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[2]),
                SizedBox(height: getProportionateScreenHeight(30)),
                DefaultButton(
                  text: "Register",
                  press: () {
                    loop(3);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else if (CoursesNO == '   4') {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            "Course registration",
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
                buildCourseFormField(codelist[0]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[1]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[2]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[3]),
                SizedBox(height: getProportionateScreenHeight(30)),
                DefaultButton(
                  text: "Register",
                  press: () {
                    loop(4);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else if (CoursesNO == '   5') {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            "Course registration",
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
                buildCourseFormField(codelist[0]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[1]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[2]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[3]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[4]),
                SizedBox(height: getProportionateScreenHeight(30)),
                DefaultButton(
                  text: "Register",
                  press: () {
                    loop(5);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else if (CoursesNO == '   6') {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            "Course registration",
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
                buildCourseFormField(codelist[0]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[1]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[2]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[3]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[4]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[5]),
                SizedBox(height: getProportionateScreenHeight(30)),
                DefaultButton(
                  text: "Register",
                  press: () {
                    loop(6);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else if (CoursesNO == '   7') {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            "Course registration",
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
                buildCourseFormField(codelist[0]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[1]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[2]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[3]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[4]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[5]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[6]),
                SizedBox(height: getProportionateScreenHeight(30)),
                DefaultButton(
                  text: "Register",
                  press: () {
                    loop(7);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else if (CoursesNO == '   8') {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            "Course registration",
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
                buildCourseFormField(codelist[0]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[1]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[2]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[3]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[4]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[5]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[6]),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCourseFormField(codelist[7]),
                SizedBox(height: getProportionateScreenHeight(30)),
                DefaultButton(
                  text: "Register",
                  press: () {
                    loop(8);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  TextFormField buildCourseFormField(TextEditingController x) {
    return TextFormField(
      controller: x,
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
}
