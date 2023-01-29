import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/components/custom_surfix_icon.dart';
import 'package:gradproject/components/default_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:gradproject/constants.dart';
import '../../../size_config.dart';

class updatestudent extends StatefulWidget {
  static String routeName = "/updatestudent";

  @override
  _updatestudent createState() => _updatestudent();
}

class _updatestudent extends State<updatestudent> {
  String title = 'DropDownButton';
  String _CoursesNO;
  List _CoursesNOName = ['   RoadMap', '   ADV ID', '   DEP&SEC ID'];
  int constant = 1;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _idController = TextEditingController();
  TextEditingController _roadController = TextEditingController();
  TextEditingController _advidController = TextEditingController();
  TextEditingController _deptidTextController = TextEditingController();
  TextEditingController _secidController = TextEditingController();
  var status;
  var data;
  var id, road, advid, dep_id, sec_id;
  Future updatestudent1({id, road, var advid, var dep_id, var sec_id}) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl = "https://extra-hint.herokuapp.com/api/98/update_student";
    final response = await http.post(
      ServerUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${value}'
      },
      body: {
        'Student_id': id,
        'roadmap': road,
      },
    );
    status = response.body.contains("err");
    data = jsonDecode(response.body);

    if (status) {
      print("data :${data}");
    } else {
      print("intelege: ${data}");
    }
    return data;
  }

  Future updatestudent2({id, road, var advid, var dep_id, var sec_id}) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl = "https://extra-hint.herokuapp.com/api/98/update_student";
    final response = await http.post(
      ServerUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${value}'
      },
      body: {
        'Student_id': id,
        'adv_id': advid,
      },
    );
    status = response.body.contains("err");
    data = jsonDecode(response.body);

    if (status) {
      print("data :${data}");
    } else {
      print("intelege: ${data}");
    }
    return data;
  }

  Future updatestudent3({id, road, var advid, var dep_id, var sec_id}) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl = "https://extra-hint.herokuapp.com/api/98/update_student";
    final response = await http.post(
      ServerUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${value}'
      },
      body: {
        'Student_id': id,
        'dep_id': dep_id,
        'sec_id': sec_id,
      },
    );
    status = response.body.contains("err");
    print("intelege: ${response.body}");
    data = jsonDecode(response.body);

    if (status) {
      print("data :${data}");
    } else {
      print("intelege: ${data}");
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Update student",
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Update student",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(28),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Please enter student id and the information \n u want to update ",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildIDFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        (constant == 3)
                            ? Visibility(
                                visible: true,
                                child: builddepidFormField(),
                              )
                            : Visibility(
                                visible: false,
                                child: builddepidFormField(),
                              ),
                        (constant == 3)
                            ? Visibility(
                                visible: true,
                                child: SizedBox(
                                    height: getProportionateScreenHeight(30)),
                              )
                            : Visibility(
                                visible: false,
                                child: SizedBox(
                                    height: getProportionateScreenHeight(30)),
                              ),
                        (constant == 1)
                            ? buildRoadMapFormField()
                            : (constant == 1)
                                ? SizedBox(
                                    height: getProportionateScreenHeight(30))
                                : (constant == 2)
                                    ? buildadvidFormField()
                                    : (constant == 2)
                                        ? SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    30))
                                        : (constant == 3)
                                            ? buildsecidFormField()
                                            : (constant == 3)
                                                ? SizedBox(
                                                    height:
                                                        getProportionateScreenHeight(
                                                            30))
                                                : null,
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.deepOrange),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(300)),
                            child: DropdownButton(
                              hint: Text('   Enter Info Type'),
                              dropdownColor: kPrimaryColor,
                              underline: SizedBox(),
                              elevation: 2,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36.0,
                              isExpanded: true,
                              value: _CoursesNO,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 22.0),
                              onChanged: (value) {
                                setState(() {
                                  _CoursesNO = value;
                                });
                                if (_CoursesNO == '   RoadMap') {
                                  constant = 1;
                                } else if (_CoursesNO == '   ADV ID') {
                                  constant = 2;
                                } else if (_CoursesNO == '   DEP&SEC ID') {
                                  constant = 3;
                                }
                              },
                              items: _CoursesNOName.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        DefaultButton(
                          text: "Update",
                          press: () {
                            if (_CoursesNO == '   RoadMap') {
                              updatestudent1(
                                  road: _roadController.text,
                                  id: _idController.text);
                            } else if (_CoursesNO == '   ADV ID') {
                              updatestudent2(
                                  advid: _advidController.text,
                                  id: _idController.text);
                            } else if (_CoursesNO == '   DEP&SEC ID') {
                              updatestudent3(
                                  dep_id: _deptidTextController.text,
                                  sec_id: _secidController.text,
                                  id: _idController.text);
                            }
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildRoadMapFormField() {
    return TextFormField(
      controller: _roadController,
      decoration: InputDecoration(
        labelText: "RoadMap",
        hintText: "Enter new student roadmap",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildIDFormField() {
    return TextFormField(
      controller: _idController,
      decoration: InputDecoration(
        labelText: "User acadmic ID",
        hintText: "Enter user ID",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField builddepidFormField() {
    return TextFormField(
      controller: _deptidTextController,
      decoration: InputDecoration(
        labelText: "User's department id",
        hintText: "Enter new student department id",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildsecidFormField() {
    return TextFormField(
      controller: _secidController,
      decoration: InputDecoration(
        labelText: "User's section id",
        hintText: "Enter new student section id",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildadvidFormField() {
    return TextFormField(
      controller: _advidController,
      decoration: InputDecoration(
        labelText: "User's adv id",
        hintText: "Enter new student adv id",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
