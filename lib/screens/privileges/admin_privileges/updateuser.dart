import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradproject/components/custom_surfix_icon.dart';
import 'package:gradproject/components/default_button.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:gradproject/constants.dart';
import 'package:gradproject/screens/profile/components/profile_menu.dart';

import '../../../size_config.dart';

class updateuser extends StatefulWidget {
  static String routeName = "/updateuser";

  @override
  _updateuser createState() => _updateuser();
}

class _updateuser extends State<updateuser> {
  String title = 'DropDownButton';
  String _CoursesNO;
  List _CoursesNOName = ['   NAME', '   PHONE', '   EMAIL', '   TYPE'];
  int constant = 1;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _idController = TextEditingController();
  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  var status;
  var data;
  var id, fname, lname, email, phone,typ;
  Future updateuser1({id, fname, var lname,}) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl = "https://extra-hint.herokuapp.com/api/98/update_user";
    final response = await http.post(
      ServerUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${value}'
      },
      body: {
        'id': id,
        'first_name': fname,
        'last_name': lname,

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

  Future updateuser2({id, phone, var advid, var dep_id, var sec_id}) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl = "https://extra-hint.herokuapp.com/api/98/update_user";
    final response = await http.post(
      ServerUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${value}'
      },
      body: {
        'id': id,
        'phone': phone,
      },
    );
    status = response.body.contains("err");
    data = jsonDecode(response.body);

    if (status) {
      Fluttertoast.showToast(
        msg: '${data}',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      print("data :${data}");
    } else {
      Fluttertoast.showToast(
        msg: '${data}',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      print("intelege: ${data}");
    }
    return data;
  }

  Future updatestudent3({id, email,}) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl = "https://extra-hint.herokuapp.com/api/98/update_user";
    final response = await http.post(
      ServerUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${value}'
      },
      body: {
        'id': id,
        'email': email,
      },
    );
    status = response.body.contains("err");
    print("intelege: ${response.body}");
    data = jsonDecode(response.body);

    if (status) {
      Fluttertoast.showToast(
        msg: '${data}',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      print("data :${data}");
    } else {
      Fluttertoast.showToast(
        msg: '${data}',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      print("intelege: ${data}");
    }
    return data;
  
  }




Future updatestudent4({id, typ,}) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl = "https://extra-hint.herokuapp.com/api/98/update_user";
    final response = await http.post(
      ServerUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${value}'
      },
      body: {
        'id': id,
        'type': typ,
      },
    );
    status = response.body.contains("err");
    data = jsonDecode(response.body);

    if (status) {
      Fluttertoast.showToast(
        msg: '${data}',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      print("data :${data}");
    } else {
      Fluttertoast.showToast(
        msg: '${data}',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
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
          "Update user",
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
                  "Update user",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(28),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Please enter user id and the information \n u want to update ",
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
                        (constant == 1)
                            ? Visibility(
                                visible: true,
                                child: buildFirstNameFormField(),
                              )
                            : Visibility(
                                visible: false,
                                child: buildFirstNameFormField(),
                              ),
                        (constant == 1)
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
                            ? buildlastNameFormField()
                            : (constant == 1)
                                ? SizedBox(
                                    height: getProportionateScreenHeight(30))
                                : (constant == 4)
                                    ? buildEmailFormField()
                                    : (constant == 4)
                                        ? SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    30))
                                        : (constant == 3)
                                            ? buildPhoneFormField()
                                            : (constant == 3)
                                                ? SizedBox(
                                                    height:
                                                        getProportionateScreenHeight(
                                                            30))
                                                : (constant == 5)
                                                    ? buildTYPEFormField()
                                                    : (constant == 5)
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
                                if (_CoursesNO == '   NAME') {
                                  constant = 1;
                                } else if (_CoursesNO == '   PHONE') {
                                  constant = 3;
                                } else if (_CoursesNO == '   EMAIL') {
                                  constant = 4;
                                } else if (_CoursesNO == '   TYPE') {
                                  constant = 5;
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

                            if (_CoursesNO == '   NAME') {
                                    updateuser1(id:_idController.text,fname:_fnameController.text,lname:_lnameController.text );
                                } else if (_CoursesNO == '   PHONE') {
                                  updateuser2(id:_idController.text,phone:_phoneController.text,);
                                } else if (_CoursesNO == '   EMAIL') {
                              updatestudent3(id:_idController.text,email:_emailController.text, );
                                } else if (_CoursesNO == '   TYPE') {
                              updatestudent4(id:_idController.text,typ:_typeController.text,);
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

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller:_fnameController,
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter new user Fname",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildlastNameFormField() {
    return TextFormField(
      controller:_lnameController,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter user Lname",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10),
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildIDFormField() {
    return TextFormField(
      controller:_idController,
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller:_emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter new user email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      controller:_phoneController,
      decoration: InputDecoration(
        labelText: "User's phone",
        hintText: "Enter new phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildTYPEFormField() {
    return TextFormField(
      controller:_typeController,
      decoration: InputDecoration(
        labelText: "User's type",
        hintText: "Enter new type",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
