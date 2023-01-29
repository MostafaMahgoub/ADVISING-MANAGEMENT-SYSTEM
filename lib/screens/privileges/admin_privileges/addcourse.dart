import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/components/custom_surfix_icon.dart';
import 'package:gradproject/components/default_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gradproject/constants.dart';
import 'package:gradproject/screens/profile/components/profile_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../size_config.dart';

class addcourse extends StatefulWidget {
  static String routeName = "/addcourse";

  @override
  _addcourse createState() => _addcourse();
}

class _addcourse extends State<addcourse> {
  final _formKey = GlobalKey<FormState>();
  var status;
  var data;

  TextEditingController _codeController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _hoursController = TextEditingController();
  TextEditingController _miController = TextEditingController();
  TextEditingController _laController = TextEditingController();
  TextEditingController _orController = TextEditingController();
  TextEditingController _clasController = TextEditingController();
  TextEditingController _fnalController = TextEditingController();
  TextEditingController _totController = TextEditingController();
  TextEditingController _instController = TextEditingController();

  Future addcourse(var code, var name, var hour, var mid, var lab, var oral,
      var classs, var ffinal, var total, var inst) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl = "https://extra-hint.herokuapp.com/api/private/course98";
    final response = await http.post(
      ServerUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${value}'
      },
      body: {
        'ccode': code,
        'cname': name,
        'cch': hour,
        'dmidterm': mid,
        'dlab': lab,
        'doral': oral,
        'dclass_work': classs,
        'dfinal': ffinal,
        'dtotal': total,
        'instructor': inst,
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
          "Add course",
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
                  "Add course",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(28),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Please enter course information",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildCCodeFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildCnameFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildCchFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildDmidtermFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildDlabFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildDoralFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildDclassworkFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildDfinalFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildDtotalFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildinstructorFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        DefaultButton(
                          text: "Add",
                          press: () {
                            addcourse(
                              _codeController.text,
                              _nameController.text,
                              _hoursController.text,
                              _miController.text,
                              _laController.text,
                              _orController.text,
                              _clasController.text,
                              _fnalController.text,
                              _totController.text,
                              _instController.text,
                            );
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

  TextFormField buildCCodeFormField() {
    return TextFormField(
      controller: _codeController,
      decoration: InputDecoration(
        labelText: "CCode",
        hintText: "Enter course code",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildCnameFormField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: "CName",
        hintText: "Enter course name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildCchFormField() {
    return TextFormField(
      controller: _hoursController,
      decoration: InputDecoration(
        labelText: "CourseCH",
        hintText: "Enter course credit hours",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildDmidtermFormField() {
    return TextFormField(
      controller: _miController,
      decoration: InputDecoration(
        labelText: "MT Degree",
        hintText: "Enter midterm degree",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildDlabFormField() {
    return TextFormField(
      controller: _laController,
      decoration: InputDecoration(
        labelText: "Lab Degree",
        hintText: "Enter lab degree",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildDoralFormField() {
    return TextFormField(
      controller: _orController,
      decoration: InputDecoration(
        labelText: "Oral degree",
        hintText: "Enter oral degree",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildDclassworkFormField() {
    return TextFormField(
      controller: _clasController,
      decoration: InputDecoration(
        labelText: "Classwork degree",
        hintText: "Enter classwork degree",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildDfinalFormField() {
    return TextFormField(
      controller: _fnalController,
      decoration: InputDecoration(
        labelText: "Final degree",
        hintText: "Enter final degree",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildDtotalFormField() {
    return TextFormField(
      controller: _totController,
      decoration: InputDecoration(
        labelText: "Total degree",
        hintText: "Enter total degree",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildinstructorFormField() {
    return TextFormField(
      controller: _instController,
      decoration: InputDecoration(
        labelText: "Instructor",
        hintText: "Enter course instructor",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }
}
