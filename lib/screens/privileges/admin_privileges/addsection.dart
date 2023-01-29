import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/components/custom_surfix_icon.dart';
import 'package:gradproject/components/default_button.dart';

import 'package:gradproject/constants.dart';
import 'package:gradproject/screens/profile/components/profile_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class addsection extends StatefulWidget {
  static String routeName = "/addsection";

  @override
  _addsection createState() => _addsection();
}

class _addsection extends State<addsection> {
  var status;
  var data;

  TextEditingController _snameController = TextEditingController();
  TextEditingController _sidController = TextEditingController();
  TextEditingController _didController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future add_sec(var did, var secid, var name) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl = "https://extra-hint.herokuapp.com/api/private/section98";
    final response = await http.post(
      ServerUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${value}'
      },
      body: {
        'sec_name': name,
        'dep_id': did,
        'Sec_id': secid,
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
          "Add section",
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
                  "Add section",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(28),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Please enter department id , Section name & id",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildSNameFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildDidFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildSidFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        DefaultButton(
                          text: "Add",
                          press: () {
                            add_sec(_didController.text, _sidController.text,
                                _snameController.text);
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

  TextFormField buildSNameFormField() {
    return TextFormField(
      controller: _snameController,
      decoration: InputDecoration(
        labelText: "SName",
        hintText: "Enter section name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildDidFormField() {
    return TextFormField(
      controller: _didController,
      decoration: InputDecoration(
        labelText: "DepID",
        hintText: "Enter department ID",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildSidFormField() {
    return TextFormField(
      controller: _sidController,
      decoration: InputDecoration(
        labelText: "SectionID",
        hintText: "Enter section ID",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }
}
