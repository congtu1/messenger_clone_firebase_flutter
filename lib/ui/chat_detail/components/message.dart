import 'package:flutter/material.dart';
import 'package:messenger_clone/business_logic/model/message.dart';
import 'package:messenger_clone/business_logic/view_models/homescreen_viewmodel.dart';
import 'package:messenger_clone/services/service_locator.dart';
import 'package:messenger_clone/ui/chat_detail/components/image_message.dart';
import 'package:messenger_clone/ui/chat_detail/components/text_message.dart';
import 'package:provider/provider.dart';



class ChatMessage extends StatelessWidget {
   ChatMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;



  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    bool whoSend(Message message) {
      return message.sentBy == homeViewModel.getCurrentUserInformation.uid ? true : false;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 4),
      child: Row(
        mainAxisAlignment:
        whoSend(message) ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if(message.category == 0 && message.messageText.length<45) messageContain(message),
          if(message.category == 0 && message.messageText.length>45) Expanded(child: messageContain(message)),
          // if message.isSender) MessageStatusDot(status: message.messageStatus)
          if(message.category == 1) messageContain(message)
        ],
      ),
    );
  }
   Widget messageContain(Message message) {
     switch (message.category) {
       case 0:
         return TextMessage(message: message);
     // case "audio":
     //   return AudioMessage(message: message);
       case 1:
         return ImageMessage(message: message,);
       default:
         return SizedBox();
     }
   }
}