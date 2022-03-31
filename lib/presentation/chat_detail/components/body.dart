import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger_clone/data/model/message_model.dart';
import 'package:messenger_clone/presentation/chat_detail/chatdetail_viewmodel/chatdetail_viewmodel.dart';
import 'package:provider/provider.dart';

import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Consumer<ChatDetailViewModel>(
          builder: (context, value, child) {
            return StreamBuilder(
                stream: value.getMessageStream,
                builder: (context, dynamic snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        controller: value.getScrollController,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          MessageModel message = MessageModel.fromSnapshot(ds);
                          return ChatMessage(message: message);
                        });
                  } else {
                    return const SizedBox();
                  }
                });
          },
        )),
        ChatInputField()
      ],
    );
  }
}
