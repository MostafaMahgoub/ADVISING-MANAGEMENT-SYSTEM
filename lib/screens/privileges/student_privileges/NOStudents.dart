import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/components/default_button.dart';

import 'package:gradproject/constants.dart';
import 'package:gradproject/screens/privileges/student_privileges/AddRemove.dart';
import 'package:gradproject/screens/privileges/student_privileges/CourseRegv2.dart';
import 'package:gradproject/screens/profile/components/profile_menu.dart';

class NOStudents extends StatefulWidget {
  static String routeName = "/NOStudents";
  var constant;
  NOStudents({this.constant});
  @override
  _NOStudents createState() => _NOStudents(constant);
}

class _NOStudents extends State<NOStudents> {
  var constant;
  String title = 'DropDownButton';
  String CoursesNO;
  List _CoursesNOName = [
    '   1',
    '   2',
    '   3',
    '   4',
    '   5',
    '   6',
    '   7',
    '   8'
  ];
  List _CoursesNOARName = [
    '   1',
    '   2',
    '   3',
  ];
  _NOStudents(this.constant);
  @override
  Widget build(BuildContext context) {
    if (constant == 1) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            centerTitle: true,
            title: Text(
              "Number of courses",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepOrange),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(300)),
                  child: DropdownButton(
                    hint: Text('   Enter courses number'),
                    dropdownColor: kPrimaryColor,
                    underline: SizedBox(),
                    elevation: 2,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36.0,
                    isExpanded: true,
                    value: CoursesNO,
                    style: TextStyle(color: Colors.black, fontSize: 22.0),
                    onChanged: (value) {
                      setState(() {
                        CoursesNO = value;
                      });
                    },
                    items: _CoursesNOARName.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: DefaultButton(
                    text: "Submit",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Addremove(CoursesNO: CoursesNO),
                          ));
                    }),
              ),
            ],
          ));
    } else if (constant == 2) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            centerTitle: true,
            title: Text(
              "Number of courses",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepOrange),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(300)),
                  child: DropdownButton(
                    hint: Text('   Enter courses number'),
                    dropdownColor: kPrimaryColor,
                    underline: SizedBox(),
                    elevation: 2,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36.0,
                    isExpanded: true,
                    value: CoursesNO,
                    style: TextStyle(color: Colors.black, fontSize: 22.0),
                    onChanged: (value) {
                      setState(() {
                        CoursesNO = value;
                      });
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
              Padding(
                padding: const EdgeInsets.all(20),
                child: DefaultButton(
                    text: "Submit",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                coursereg(CoursesNO: CoursesNO),
                          ));
                    }),
              ),
            ],
          ));
    }
  }
}
