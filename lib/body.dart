import 'package:gradproject/constants.dart';
import 'package:gradproject/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'chat_input_field.dart';
import 'package:gradproject/Message.dart';
import '';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class Body extends StatelessWidget {
  mss() async {
    var channel = IOWebSocketChannel.connect(
        'https://extra-hint.herokuapp.com/api/general/messages');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: FutureBuilder(
                future: null,
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: demeChatMessages.length,
                    itemBuilder: (context, index) =>
                        Message(message: demeChatMessages[index]),
                  );
                }),
          ),
        ),
        ChatInputField(),
      ],
    );
  }
}
