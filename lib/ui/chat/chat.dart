import 'package:flutter/material.dart';
import 'package:messenger_clone/constant/size.dart';
import 'package:messenger_clone/ui/chat/components/list_conversation.dart';
import 'components/list_activity_horizontal.dart';
import 'components/searchbox.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        primary: true,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          SearchBox(),
          SizedBox(height: 0.02*SizeConfig.sHeight,),
          // SizedBox(
          //   height: 0.15*SizeConfig.sHeight,
          //   child: buildListAcivityHorizontal(),
          // ),
          ListConversation()

        ],
      ),
    );
  }
}




