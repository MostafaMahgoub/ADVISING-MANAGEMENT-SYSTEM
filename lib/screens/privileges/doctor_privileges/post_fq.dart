import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gradproject/components/custom_surfix_icon.dart';
import 'package:gradproject/components/default_button.dart';
import 'package:http/http.dart' as http;
import 'package:gradproject/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../size_config.dart';

class postfq extends StatefulWidget {
  static String routeName = "/postfq";
  _postfq createState() => _postfq();
}

class _postfq extends State<postfq> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController question1 = TextEditingController();
  TextEditingController answer1 = TextEditingController();
  bool pressed = false;
  var status;
  var data;

  postfreq(String cname, String question, String answer) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl =
        "https://extra-hint.herokuapp.com/api/advisor/feedback98";
    final response = await http.post(ServerUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${value}'
    }, body: {
      'ccode': cname,
      'fheader': question,
      'fbody': answer,
    });
    status = response.body.contains("err");
    print("the orignal body  : ${response.body}");
    data = jsonDecode(response.body);
    if (status) {
      print("data :${data["err"]}");
    } else {
      print("data: SUCCESS");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Post a frequently question",
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Post new question",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(28),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Please enter your question & answer",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildQuestionFormField(),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        buildAnswerFormField(),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: DefaultButton(
                              text: "Submit",
                              press: () {
                                postfreq(
                                    "COMP207", question1.text, answer1.text);
                                setState(() {
                                  pressed = true;
                                });
                              }),
                        ),
                        pressed
                            ? Text(
                                'QUESTION POSTED SUCCESSFULLY',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildQuestionFormField() {
    return TextFormField(
      controller: question1,
      decoration: InputDecoration(
        labelText: "Question",
        hintText: "Enter question",
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
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Parcel.svg"),
      ),
    );
  }

  TextFormField buildAnswerFormField() {
    return TextFormField(
      controller: answer1,
      decoration: InputDecoration(
        labelText: "Answer",
        hintText: "Question answer",
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
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Parcel.svg"),
      ),
    );
  }
}
