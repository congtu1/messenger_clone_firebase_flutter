
import 'package:flutter/material.dart';
import 'package:messenger_clone/business_logic/model/message.dart';
import 'package:messenger_clone/business_logic/view_models/homescreen_viewmodel.dart';
import 'package:messenger_clone/services/service_locator.dart';
import 'package:provider/provider.dart';


class TextMessage extends StatelessWidget {
  TextMessage({
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
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20 * 0.75,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(whoSend(message) ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),

      ),
      child: Text(
        message.messageText.toString(),
        style: TextStyle(
          color: whoSend(message)
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1!.color,
        ),
      ),
    );
  }
}