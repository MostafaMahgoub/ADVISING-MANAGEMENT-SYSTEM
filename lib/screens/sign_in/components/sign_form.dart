import 'package:gradproject/screens/forgot_password/forgot_password_screen.dart';
import 'package:gradproject/screens/privileges/admin_privileges/admin_profile.dart';
import 'package:gradproject/screens/privileges/doctor_privileges/doctor_profile.dart';
import 'package:gradproject/screens/privileges/student_privileges/student_profile.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/components/custom_surfix_icon.dart';
import 'package:gradproject/components/form_error.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:gradproject/screens/splash/splash_screen.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  var status;
  var data;
  var isloading;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  _save2(String leve, String id) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('level', leve);
    pref.setString('uid', id);
  }

  _save(String name, String id, String email, String token, var type,
      {leve}) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('uname', name);
    pref.setString('uid', id);
    pref.setString('uemail', email);
    pref.setString('token', token);
    pref.setString('usertype', type);
    pref.setString('login', isloading);
    pref.setString('level', leve);
  }

  _read() async {
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);
    print('shared token ${value}');
  }

  logindata(String email, String password) async {
    String ServerUrl = "https://extra-hint.herokuapp.com/api/auth/login";
    final response = await http.post(ServerUrl, headers: {
      'Accept': 'application/json',
    }, body: {
      "email": "$email",
      "password": "$password"
    });
    status = response.body.contains("err");
    data = jsonDecode(response.body);
    if (status) {
      print("data :${data["error"]}");
    } else {
      print("data :${data}");
    }

    _save(
      '${data['first_name']} ${data['last_name']}',
      '${data['id']}',
      '${data['email']}',
      data['token'],
      data["type"].toString().trim(),
    );
    //_read();
  }

  _login() {
    setState(() {
      if (_emailTextController.text.trim().toLowerCase().isNotEmpty &&
          _passwordTextController.text.trim().toLowerCase().isNotEmpty) {
        Fluttertoast.showToast(
          msg: 'loading....',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );

        logindata(_emailTextController.text.trim().toLowerCase(),
                _passwordTextController.text.trim().toLowerCase())
            .whenComplete(() async {
          if (status) {
            _showDialog("Error", "Try a valid E-mail or password");
            setState(() {
              isloading = "0";
            });
          } else {
            if (remember) {
              setState(() {
                isloading = "1";
              });
            }
            if (data["type"] == 1) {
              _save2(data['S_data']['lvl'].toString().trim(),
                  data['S_data']['Student_id'].toString().trim());
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => studentProfileScreen()));
            } else if (data["type"] == 2) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => doctorProfileScreen()));
            } else if (data["type"] == 3) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => adminProfileScreen()));
            }
          }
          final pref1 = await SharedPreferences.getInstance();
          pref1.setString('login', isloading);
        });
      } else {
        FormError(errors: errors);
        Fluttertoast.showToast(
          msg: 'Check Empty Input',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    });
  }

  void _showDialog(String head, String body) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(head),
            content: Text(body),
            actions: [
              RaisedButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(children: [
            Checkbox(
              value: remember,
              activeColor: kPrimaryColor,
              onChanged: (value) {
                setState(() {
                  remember = value;
                });
              },
            ),
            Text("Remember me",
                style: TextStyle(fontSize: getProportionateScreenWidth(10))),
            Spacer(),
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
              child: Text(
                "Forgot Password",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: getProportionateScreenWidth(10)),
              ),
            )
          ]),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(text: "Continue", press: () => _login()),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Back",
            press: () {
              {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SplashScreen()));
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
      controller: _passwordTextController,
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
      controller: _emailTextController,
    );
  }
}
