import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger_clone/business_logic/model/message.dart';
import 'package:messenger_clone/business_logic/view_models/chatscreen_viewmodel.dart';
import 'package:messenger_clone/business_logic/view_models/homescreen_viewmodel.dart';
import 'package:messenger_clone/services/service_locator.dart';
import 'package:messenger_clone/ui/chat_detail/components/chat_input_field.dart';
import 'package:messenger_clone/ui/chat_detail/components/message.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {


  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final chatViewModel = Provider.of<ChatViewModel>(context);
    return Column(
      children: [
        Expanded(
            child: chatViewModel.getMessageStream != null ? StreamBuilder(
                    stream: chatViewModel.getMessageStream,
                    builder: (context,dynamic snapshot) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        if (chatViewModel.getScrollController.hasClients) {
                          chatViewModel.getScrollController.jumpTo(chatViewModel.getScrollController.position.maxScrollExtent);
                        } else {
                          setState(() => null);
                        }
                      });
                        return snapshot.hasData
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ListView.builder(
                                itemCount: snapshot.data.docs.length,
                              controller: chatViewModel.getScrollController,
                              itemBuilder: (context, index) {
                                DocumentSnapshot ds = snapshot.data.docs[index];
                                Message message = Message.fromSnapshot(ds);
                                  return ChatMessage(message: message);
                    },
                  ),
                )
                          : Center(child: CircularProgressIndicator(),);
                        },
                  )
                :Container()
              ),
        ChatInputField()
      ],
    );
  }
}
