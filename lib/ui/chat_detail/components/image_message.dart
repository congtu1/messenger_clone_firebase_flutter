import 'package:flutter/material.dart';
import 'package:messenger_clone/business_logic/model/message.dart';


class ImageMessage extends StatelessWidget {
  ImageMessage({required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4, // 45% of total width
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(message.messageText),
        ),
      ),
    );
  }
}