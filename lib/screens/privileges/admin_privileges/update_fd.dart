import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gradproject/components/custom_surfix_icon.dart';
import 'package:gradproject/components/default_button.dart';
import 'package:gradproject/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../size_config.dart';

class updatefd extends StatefulWidget {
  static String routeName = "/updatefd";
  final stid;
  updatefd(this.stid);

  _updatefd createState() => _updatefd();
}

class _updatefd extends State<updatefd> {
  TextEditingController ccode = TextEditingController();
  TextEditingController degree = TextEditingController();
  bool pressed = false;
  var status;
  var data;
  var courses;
  updatefid() async {
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl =
        "https://extra-hint.herokuapp.com/api/private/enter_degree";
    final response = await http.post(
      ServerUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${value}'
      },
      body: {
        'Student_id': '${widget.stid}',
        'ccode': "${ccode.text}",
        'hfinal_d': '${degree.text}',
      },
    );
    status = response.body.contains("err");
    bool errors = response.body.contains("errors");
    data = jsonDecode(response.body);
    if (status) {
      print("data :${data}");
      if (errors) {
        Fluttertoast.showToast(
          msg: '${data['errors']['ccode'][0]}',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: '${data['err']}',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    } else {
      print("data:${data}");
      Fluttertoast.showToast(
        msg: 'DEGREE UPDATED',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          "Update final degree",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: getProportionateScreenHeight(20)),
              Padding(
                padding: const EdgeInsets.all(20),
                child: buildCourseFormField(),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Padding(
                padding: const EdgeInsets.all(20),
                child: buildDegreeFormField(),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Padding(
                padding: const EdgeInsets.all(20),
                child: DefaultButton(
                    text: "Continue",
                    press: () {
                      Fluttertoast.showToast(
                        msg: 'Checking...',
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                      );
                      updatefid();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => updatefd(widget.stid)));
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: DefaultButton(
                    text: "Submit",
                    press: () {
                      setState(() {
                        pressed = true;
                      });
                      Navigator.of(context).pop();
                    }),
              ),
              pressed
                  ? Text(
                      "DEGREES SUBMITTED",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildCourseFormField() {
    return TextFormField(
      controller: ccode,
      decoration: InputDecoration(
        labelText: "Course",
        hintText: "Enter course code",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10),
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Parcel.svg"),
      ),
    );
  }

  TextFormField buildDegreeFormField() {
    return TextFormField(
      controller: degree,
      decoration: InputDecoration(
        labelText: "Degree",
        hintText: "Enter student degree",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10),
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Parcel.svg"),
      ),
    );
  }
}
