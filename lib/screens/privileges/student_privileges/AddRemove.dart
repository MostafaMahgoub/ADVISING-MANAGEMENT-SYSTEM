import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/components/custom_surfix_icon.dart';
import 'package:gradproject/components/default_button.dart';
import 'package:http/http.dart' as http;
import 'package:gradproject/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../size_config.dart';

class Addremove extends StatefulWidget {
  static String routeName = "/Addremove";
  String CoursesNO;

  Addremove({this.CoursesNO});

  @override
  _Addremove createState() => _Addremove(CoursesNO);
}

class _Addremove extends State<Addremove> {
  var status;
  var data;
  List<TextEditingController> codelist =
      List.generate(4, (index) => TextEditingController());

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
      print("data: succeed");
    }
  }

  cancelcourse(String cname) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl =
        "https://extra-hint.herokuapp.com/api/service/cancel_course";
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
      print("data: succeed");
    }
  }

  loopcancel(int x) {
    for (int i = 0; i < x; i++) {
      if (codelist[i].text != "") {
        cancelcourse(codelist[i].value.text.trim().toUpperCase());
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

  _Addremove(this.CoursesNO);

  @override
  Widget build(BuildContext context) {
    if (CoursesNO == '   1') {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            "Add or remove courses",
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
                  text: "Add",
                  press: () {
                    loop(1);
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                DefaultButton(
                  text: "Remove",
                  press: () {
                    loopcancel(1);
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
            "Add or remove courses",
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
                  text: "Add",
                  press: () {
                    loop(2);
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                DefaultButton(
                  text: "Remove",
                  press: () {
                    loopcancel(2);
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
            "Add or remove courses",
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
                  text: "Add",
                  press: () {
                    loop(3);
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                DefaultButton(
                  text: "Remove",
                  press: () {
                    loopcancel(3);
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
