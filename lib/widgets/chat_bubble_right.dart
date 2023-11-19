import 'package:chatapp_new/constants.dart';
import 'package:flutter/material.dart';

import '../models/chat_model.dart';

class ChatBubbleRight extends StatelessWidget {
  const ChatBubbleRight({
    super.key,
    required this.chatMessage,
  });
  final Message chatMessage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: const BoxDecoration(
          color: kSecColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Text(
          chatMessage.message,
          style: TextStyle(
              fontFamily: kTextChatStyle.fontFamily, color: kWhiteColor),
        ),
      ),
    );
  }
}
