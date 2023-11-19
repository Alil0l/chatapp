import 'package:chatapp_new/constants.dart';
import 'package:chatapp_new/models/chat_model.dart';
import 'package:flutter/material.dart';

class ChatBubbleLeft extends StatelessWidget {
  const ChatBubbleLeft({
    super.key,
    required this.chatMessage,
  });
  final Message chatMessage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: const BoxDecoration(
          color: kPriColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
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
