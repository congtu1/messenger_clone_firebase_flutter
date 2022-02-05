import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger_clone/business_logic/model/conversation.dart';
import 'package:messenger_clone/business_logic/model/message.dart';
import 'package:messenger_clone/business_logic/view_models/chatscreen_viewmodel.dart';
import 'package:messenger_clone/business_logic/view_models/homescreen_viewmodel.dart';
import 'package:messenger_clone/helper/string_helper.dart';
import 'package:messenger_clone/services/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

class ChatInputField extends StatefulWidget {
  ChatInputField({Key? key}) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  TextEditingController _editingController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool hasText = false;

  @override
  Widget build(BuildContext context) {
    final chatViewModel = Provider.of<ChatViewModel>(context);
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            IconButton(
              color: const Color(0xFF00BF6D),
              onPressed: () async {
                final XFile? pickFile = await _picker.pickImage(source: ImageSource.gallery);
                final String fileName = path.basename(pickFile!.path);
                File imageFile = File(pickFile.path);
                chatViewModel.sendImage(context, imageFile, fileName);
              },
              icon: Icon(Icons.attach_file),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20 * 0.75,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF00BF6D).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                    SizedBox(width: 20 / 4),
                    Expanded(
                      child: TextField(
                        controller: _editingController,
                        onTap: () async {
                          if (chatViewModel.getHasConversation) {
                            toMax(chatViewModel);
                            setState(() {});
                          }
                        },
                        onChanged: (value) {
                          if (value != "") {
                            hasText = true;
                            setState(() {});
                          } else {
                            hasText = false;
                            setState(() {});
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(
                Icons.send,
                size: 30,
              ),
              color: hasText ? Colors.green.withOpacity(0.64) : Colors.grey,
              onPressed: () async {
                if (hasText) {
                  var messageData = Message(
                          messageText: _editingController.text,
                          sentAt: DateTime.now(),
                          sentBy: homeViewModel.getCurrentUserInformation.uid
                              .toString(),
                          status: 0,
                          category: 0)
                      .toJson();
                  if (chatViewModel.getHasConversation) {
                    chatViewModel.addMessage(messageData);
                  } else {
                    var conversation = Conversation(
                            id: StringHelper().compareStringForID(
                                homeViewModel.getCurrentUserInformation.uid
                                    .toString(),
                                chatViewModel.getUserReceive.uid.toString()),
                            members: [
                              homeViewModel.getCurrentUserInformation.uid
                                  .toString(),
                              chatViewModel.getUserReceive.uid.toString()
                            ],
                            recentMessage: messageData,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                            createBy: homeViewModel
                                .getCurrentUserInformation.uid
                                .toString())
                        .toJson();
                    chatViewModel.firstMessage(conversation, messageData);
                  }
                }
                clearInput();
                toMax(chatViewModel);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  void clearInput() {
    _editingController.clear();
    hasText = false;
  }

  void toMax(chatViewModel) async {
    await Future.delayed(const Duration(milliseconds: 300));
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      chatViewModel.getScrollController.animateTo(
          chatViewModel.getScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn);
    });
  }
}
