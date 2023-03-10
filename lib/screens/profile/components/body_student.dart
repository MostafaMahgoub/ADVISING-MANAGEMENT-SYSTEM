import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradproject/screens/privileges/privileges_student.dart';
import 'package:gradproject/screens/sign_in/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../size_config.dart';
import 'profile_menu.dart';

class Bodystudent extends StatefulWidget {
  @override
  _BodystudentState createState() => _BodystudentState();
}

class _BodystudentState extends State<Bodystudent> {
  String sname = "", email = "", id = "", level = "";
  _clear() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  _read() async {
    final pref = await SharedPreferences.getInstance();

    sname = await pref.get('uname');
    email = await pref.get('uemail');
    id = await pref.get('uid');
    level = await pref.get('level');

    print("name:$sname");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _read();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _read(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 115,
                    width: 115,
                    child: Stack(
                      fit: StackFit.expand,
                      // ignore: deprecated_member_use
                      overflow: Overflow.visible,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/ASLOGO.png"),
                        ),
                        Positioned(
                          right: -16,
                          bottom: 0,
                          child: SizedBox(
                            height: 46,
                            width: 46,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(color: Colors.white),
                              ),
                              color: Color(0xFFF5F6F9),
                              onPressed: () {},
                              child: SvgPicture.asset(
                                  "assets/icons/Camera Icon.svg"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Text(
                    "Hello, Student",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(25),
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Student Name: ${sname}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Student Email: ${email}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Student ID: ${id}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Student Level: ${level}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 150),
                  ProfileMenu(
                    text: "My privileges",
                    icon: "assets/icons/Question mark.svg",
                    press: () {
                      Navigator.pushNamed(context, privilegesstudent.routeName);
                    },
                  ),
                  ProfileMenu(
                    text: "Log Out",
                    icon: "assets/icons/Log out.svg",
                    press: () {
                      _clear();
                      Navigator.pushReplacementNamed(
                          context, SignInScreen.routeName);
                    },
                  ),
                ],
              ),
            );
          }
        });
  }
}
