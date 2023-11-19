// ignore_for_file: must_be_immutable

import 'package:chatapp_new/constants.dart';
import 'package:chatapp_new/models/chat_model.dart';
import 'package:chatapp_new/widgets/chat_bubble_left.dart';
import 'package:chatapp_new/widgets/chat_bubble_right.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  static String id = 'ChatScreen';
  final _controllor = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kCollection);
  TextEditingController controller = TextEditingController();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPriColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(kLogo, scale: 1.8),
                    const Text('Chat')
                  ],
                ),
              ),
              backgroundColor: kWhiteColor,
              body: Column(children: [
                Expanded(
                    child: ListView.builder(
                  controller: _controllor,
                  reverse: true,
                  itemCount: messageList.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return messageList[index].id == email
                        ? ChatBubbleLeft(chatMessage: messageList[index])
                        : ChatBubbleRight(chatMessage: messageList[index]);
                  },
                )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      {
                        messages.add({
                          kMessage: data,
                          kCreatedAt: DateTime.now(),
                          'id': email
                        });
                        controller.clear();
                        _controllor.animateTo(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      }
                    },
                    textInputAction: TextInputAction.done,
                    style: kTextChatStyle,
                    minLines: 1,
                    maxLines: 4,
                    decoration: InputDecoration(
                      suffixIconColor: kPriColor,
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.send_rounded)),
                      labelText: "Message",
                      labelStyle: const TextStyle(
                          fontFamily: 'pacifico', color: kPriColor),
                      hintText: "Write a Message",
                      hintStyle: const TextStyle(
                          fontFamily: 'pacifico', color: kPriColor),
                      focusedBorder: borderStylePriColor(),
                      enabledBorder: borderStylePriColor(),
                      border: borderStylePriColor(),
                    ),
                  ),
                )
              ]),
            );
          }
          return const Scaffold(
              body: Center(
                  child: Text(
            'Loading...',
            style: kMainTitleStyle,
          )));
        });
  }

  OutlineInputBorder borderStylePriColor() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: kPriColor));
  }
}
