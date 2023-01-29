import 'package:flutter/material.dart';
import 'package:gradproject/components/custom_surfix_icon.dart';
import 'package:gradproject/components/default_button.dart';
import 'package:gradproject/screens/privileges/admin_privileges/update_mtd.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/screens/privileges/doctor_privileges/show_student_ar.dart';
import 'package:gradproject/screens/privileges/doctor_privileges/show_student_mtd.dart';
import 'admin_privileges/update_fd.dart';
import 'doctor_privileges/showstudentmtdtest.dart';

class studentname extends StatefulWidget {
  static String routeName = "/studentname";

  var constant;
  studentname({this.constant});

  @override
  _MyHomePageState createState() => _MyHomePageState(constant);
}

class _MyHomePageState extends State<studentname> {
  String password;
  var constant;
  _MyHomePageState(this.constant) {}

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController semes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (constant == 1) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Student information",
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            buildFormField("ID", "Enter student id", fname),
            SizedBox(
              height: 100,
            ),
            DefaultButton(
                text: "Continue",
                press: () {
                  if (fname != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => updatefd(fname.text.trim())));
                  }
                }),
            SizedBox(height: 50),
          ],
        ),
      );
    } else if (constant == 2) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Student information",
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            buildFormField("ID", "Enter student id", fname),
            SizedBox(
              height: 100,
            ),
            DefaultButton(
                text: "Continue",
                press: () {
                  if (fname != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                updatemtd(fname.text.trim())));
                  }
                }),
            SizedBox(height: 50),
            Spacer(),
          ],
        ),
      );
    } else if (constant == 3) {
      final _formKey = GlobalKey<FormState>();
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Student information",
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            SizedBox(height: 100),
            buildFormField("ID", "Enter student id", fname),
            SizedBox(height: 100),
            DefaultButton(
                text: "Continue",
                press: () {
                  if (fname != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => showstudentmtd(
                                  fname: fname.text.trim(),
                                )));
                  }
                }),
            SizedBox(height: 50),
          ],
        ),
      );
    } else if (constant == 4) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Student information",
          ),
        ),
        body: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                SizedBox(height: 100),
                buildFormField("ID", "Enter student id", fname),
                SizedBox(height: 100),
                DefaultButton(
                    text: "Continue",
                    press: () {
                      if (fname != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => showstudentar(
                                      fname: fname.text.trim(),
                                    )));
                      }
                    }),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      );
    }
  }

  TextField buildFormField(
      String label, String hint, TextEditingController cont) {
    return TextField(
      controller: cont,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
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
}
