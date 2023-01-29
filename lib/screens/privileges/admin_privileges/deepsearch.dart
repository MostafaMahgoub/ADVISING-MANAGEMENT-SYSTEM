import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/components/custom_surfix_icon.dart';
import 'package:gradproject/components/default_button.dart';

import 'package:gradproject/constants.dart';
import 'package:gradproject/screens/profile/components/profile_menu.dart';

import '../../../size_config.dart';

class deepsearch extends StatefulWidget {
  static String routeName = "/deepsearch";

  @override
  _deepsearch createState() => _deepsearch();
}

class _deepsearch extends State<deepsearch> {
  String title = 'DropDownButton';
  String _CoursesNO;
  List _CoursesNOName = [
    '   NAME',
    '   ID',
    '   PHONE',
    '   EMAIL',
    '   SEC ID',
    '   DEP ID'
  ];
  int constant = 1;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Deep search",
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
                  "Deep search",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(28),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Please enter the type u want to search through",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                                : (constant == 2)
                                    ? buildIDFormField()
                                    : (constant == 2)
                                        ? SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    30))
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
                                                            ? builddepidFormField()
                                                            : (constant == 5)
                                                                ? SizedBox(
                                                                    height:
                                                                        getProportionateScreenHeight(
                                                                            30))
                                                                : (constant ==
                                                                        6)
                                                                    ? buildsecidFormField()
                                                                    : (constant ==
                                                                            6)
                                                                        ? SizedBox(
                                                                            height:
                                                                                getProportionateScreenHeight(30))
                                                                        : null,
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.deepOrange),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(300)),
                            child: DropdownButton(
                              hint: Text('   Enter Search Type'),
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
                                } else if (_CoursesNO == '   ID') {
                                  constant = 2;
                                } else if (_CoursesNO == '   PHONE') {
                                  constant = 3;
                                } else if (_CoursesNO == '   EMAIL') {
                                  constant = 4;
                                } else if (_CoursesNO == '   SEC ID') {
                                  constant = 5;
                                } else if (_CoursesNO == '   DEP ID') {
                                  constant = 6;
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
                          text: "Submit",
                          press: () {},
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
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter user name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildlastNameFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter user name",
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
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter user email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "User's phone",
        hintText: "Enter phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField builddepidFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "User's department id",
        hintText: "Enter department id",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildsecidFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "User's section id",
        hintText: "Enter section id",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
