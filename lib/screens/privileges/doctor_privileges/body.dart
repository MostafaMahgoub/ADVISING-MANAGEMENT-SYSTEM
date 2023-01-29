import 'package:gradproject/filled_outline_button.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/Chat.dart';
import 'package:gradproject/message_screen.dart';
import 'package:flutter/material.dart';

import 'package:gradproject/screens/privileges/doctor_privileges/chat_doctor.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chatsData[index],
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagesScreen(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
