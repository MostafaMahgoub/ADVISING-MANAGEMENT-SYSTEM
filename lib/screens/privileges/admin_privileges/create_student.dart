import 'package:flutter/material.dart';
import 'package:gradproject/components/custom_surfix_icon.dart';
import 'package:gradproject/components/default_button.dart';
import 'package:gradproject/components/form_error.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gradproject/constants.dart';
import 'package:gradproject/size_config.dart';

class CreateStudent extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<CreateStudent> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String phone;
  String fname;
  String lname;
  String department;
  String section;
  String ID;
  bool remember = false;
  var loading;
  var status;
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

  createdata(String email, String password, String firname, String lasname,
      String id, var type, var phone) async {
    String ServerUrl = "https://extra-hint.herokuapp.com/api/auth/add_user";
    final response = await http.post(ServerUrl, headers: {
      'Accept': 'application/json',
    }, body: {
      "first_name": "$firname",
      "last_name": "$lasname",
      "id": "$id",
      "type": "1",
      "phone": "$phone",
      "email": "$email",
      "password": "$password",
      "dep_id": "$department",
      'sec_id': '$section',
    });
    print("original body:${response.body}");
    status = response.body.contains("error");
    var data = jsonDecode(response.body);
    if (status) {
      print("data :${data["error"]}");
    } else {
      print("data :${data["access_token"]}");
    }
  }

  _regist() {
    setState(() {
      loading = true;
      if (email.trim().toLowerCase().isNotEmpty &&
          password.trim().toLowerCase().isNotEmpty &&
          fname.trim().toLowerCase().isNotEmpty &&
          ID.toString().trim().toLowerCase().isNotEmpty &&
          department.toString().trim().toLowerCase().isNotEmpty &&
          phone.toString().trim().toLowerCase().isNotEmpty) {
        Fluttertoast.showToast(
          msg: 'Pleast wait....',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        createdata(
                email.trim().toLowerCase(),
                password.trim().toLowerCase(),
                fname.trim().toLowerCase(),
                lname.trim().toLowerCase(),
                ID.toString().trim().toLowerCase(),
                department.toString().trim().toLowerCase(),
                phone.toString().trim().toLowerCase())
            .whenComplete(() {
          setState(() {
            loading = false;
          });
          if (status) {
            _showDialog("Failed", "Check input data");
          } else {
            _showDialog("Succeed", "Successfully registered");
          }
        });
      } else {
        Fluttertoast.showToast(
          msg: 'Failed : Check empty fields',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
      ;
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign Up Student"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                  Text(
                    "Register",
                    style: headingStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Complete student details",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildEmailFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildfNameFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildlNameFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildIDFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildPasswordFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildTypeFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildSectionFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildConformPassFormField(),
                        FormError(errors: errors),
                        SizedBox(height: getProportionateScreenHeight(40)),
                        DefaultButton(
                          text: "Continue",
                          press: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              _regist();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  SizedBox(height: getProportionateScreenHeight(20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildfNameFormField() {
    return TextFormField(
      onSaved: (newValue) => fname = newValue,
      decoration: InputDecoration(
        labelText: "FName",
        hintText: "Enter student fname",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildlNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lname = newValue,
      decoration: InputDecoration(
        labelText: "LName",
        hintText: "Enter student lname",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildTypeFormField() {
    return TextFormField(
      onSaved: (newValue) => department = newValue,
      decoration: InputDecoration(
        labelText: "Department",
        hintText: "Enter Student department ",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildSectionFormField() {
    return TextFormField(
      onSaved: (newValue) => section = newValue,
      decoration: InputDecoration(
        labelText: "Section",
        hintText: "Enter Student section ",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(

      decoration: InputDecoration(
        labelText: "Phone",
        hintText: "Enter student phone",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
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
        password = value;
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
        hintText: "Enter student password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildIDFormField() {
    return TextFormField(
      onSaved: (newValue) => ID = newValue,
      decoration: InputDecoration(
        labelText: "Student ID",
        hintText: "Enter student academic ID",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
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
        hintText: "Enter student email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
