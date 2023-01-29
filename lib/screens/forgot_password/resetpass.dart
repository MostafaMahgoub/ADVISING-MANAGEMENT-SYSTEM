import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/body.dart';
import 'package:gradproject/components/custom_surfix_icon.dart';
import 'package:gradproject/components/default_button.dart';

import 'package:gradproject/constants.dart';
import 'package:gradproject/screens/profile/components/profile_menu.dart';

import 'package:gradproject/size_config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class resetpw extends StatefulWidget {
  static String routeName = "/resetpw";
  String email;
  resetpw({this.email});

  @override
  _resetpw createState() => _resetpw(email);
}

class _resetpw extends State<resetpw> {
  final _formKey = GlobalKey<FormState>();
  String email;
  _resetpw(this.email);
  TextEditingController _pinController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var status;
  var data;

  Future reset2(var email, var bin, var pass) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl = "https://extra-hint.herokuapp.com/api/auth/reset_pass";
    final response = await http.post(
      ServerUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${value}'
      },
      body: {
        'token': bin,
        'email': email,
        'password': pass,
      },
    );
    status = response.body.contains("error");
    data = jsonDecode(response.body);

    if (status) {
      Fluttertoast.showToast(
        msg: '${data}',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );

      print("data :${data["err"]}");
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
          "Reset password",
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
                  "Password reset",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(28),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Please enter the token and password",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildTokenFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildPasswordFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        DefaultButton(
                          text: "Submit",
                          press: () {
                            reset2(email, _pinController.text,
                                _passwordController.text);
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

      /*SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20 , horizontal: 30),
          child : Form(
            key: _formKey,
            child: Column(
              children: [
                buildTokenFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),

                DefaultButton(
                  text: "Submit",
                  press: () {

                  },

                ),
                SizedBox(height: getProportionateScreenHeight(30)),

              ],
            ),
          ),
        ),*/
    );
  }

  TextFormField buildTokenFormField() {
    return TextFormField(
      controller: _pinController,
      decoration: InputDecoration(
        labelText: "Token",
        hintText: "Enter token code",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter new password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/lock.svg"),
      ),
    );
  }
}
