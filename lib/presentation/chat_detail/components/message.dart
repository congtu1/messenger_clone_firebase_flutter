import 'package:flutter/material.dart';
import 'package:messenger_clone/data/model/message_model.dart';
import 'package:messenger_clone/presentation/chat_detail/chatdetail_viewmodel/chatdetail_viewmodel.dart';
import 'package:messenger_clone/presentation/chat_detail/components/text_message.dart';
import 'package:provider/provider.dart';

import 'image_message.dart';



class ChatMessage extends StatelessWidget {
   const ChatMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageModel message;



  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 4),
      child: Row(
        mainAxisAlignment:
        context.read<ChatDetailViewModel>().whoSend(message) ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if(message.category == 0 && message.messageText.length<45) messageContain(message),
          if(message.category == 0 && message.messageText.length>45) Expanded(child: messageContain(message)),
          // if message.isSender) MessageStatusDot(status: message.messageStatus)
          if(message.category == 1) messageContain(message)
        ],
      ),
    );
  }
   Widget messageContain(MessageModel message) {
     switch (message.category) {
       case 0:
         return TextMessage(message: message);
     // case "audio":
     //   return AudioMessage(message: message);
       case 1:
         return ImageMessage(message: message,);
       default:
         return const SizedBox();
     }
   }
}