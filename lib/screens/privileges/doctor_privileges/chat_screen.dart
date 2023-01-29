import 'package:gradproject/constants.dart';
import 'package:flutter/material.dart';

import 'package:gradproject/screens/privileges/doctor_privileges/body.dart';

class chatdoctor extends StatefulWidget {
  static String routeName = "/chatdoctor";
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<chatdoctor> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(), body: Body());
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false,
      title: Text("Chats"),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }
}
