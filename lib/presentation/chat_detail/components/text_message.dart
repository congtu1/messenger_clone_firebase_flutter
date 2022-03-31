
import 'package:flutter/material.dart';
import 'package:messenger_clone/data/model/message_model.dart';
import 'package:messenger_clone/presentation/chat_detail/chatdetail_viewmodel/chatdetail_viewmodel.dart';
import 'package:provider/provider.dart';


class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageModel message;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20 * 0.75,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(context.read<ChatDetailViewModel>().whoSend(message) ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),

      ),
      child: Text(
        message.messageText.toString(),
        style: TextStyle(
          color: context.read<ChatDetailViewModel>().whoSend(message)
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1!.color,
        ),
      ),
    );
  }
}