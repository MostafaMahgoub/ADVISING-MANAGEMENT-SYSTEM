import 'package:gradproject/screens/privileges/doctor_privileges/show_fq.dart';
import 'package:gradproject/screens/privileges/doctor_privileges/showstudentmtdtest.dart';
import 'package:gradproject/screens/privileges/student_privileges/advise_sem.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/screens/privileges/student_privileges/attendance_student.dart';
import 'package:gradproject/screens/privileges/student_privileges/chat_student/chat_students.dart';
import 'package:gradproject/screens/privileges/student_privileges/course_reg.dart';
import 'package:gradproject/screens/privileges/student_privileges/studentafstest.dart';
import 'package:gradproject/screens/profile/components/profile_menu.dart';
import 'package:gradproject/screens/privileges/doctor_privileges/show_student_mtd.dart';
import 'package:gradproject/screens/privileges/doctor_privileges/show_student_ar.dart';
import '../../constants.dart';

class privilegesstudent extends StatelessWidget {
  static String routeName = "/privilegesstudent";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          "Student privileges",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            ProfileMenu(
              text: "Advise for semester",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => intelege(),
                    ));
              },
            ),
            ProfileMenu(
              text: "Most frequently question",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.pushNamed(context, showfq.routeName);
              },
            ),
            ProfileMenu(
              text: "Course registration",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.pushNamed(context, RegistPage.routeName);
              },
            ),
            ProfileMenu(
              text: "My academic record",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.pushNamed(context, showstudentar.routeName);
              },
            ),
            ProfileMenu(
              text: "My midterm degrees",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.pushNamed(context, showstudentmtd.routeName);
              },
            ),
            ProfileMenu(
              text: "Chat",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.pushNamed(context, chatstudent.routeName);
              },
            ),
            ProfileMenu(
              text: "Attendance",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.pushNamed(context, attendancestudent.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
