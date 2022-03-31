import 'package:flutter/material.dart';
import 'package:messenger_clone/constant/size.dart';
import 'components/list_conversation.dart';
import 'components/searchbox.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        primary: true,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          const SearchBox(),
          SizedBox(height: 0.02*SizeConfig.sHeight,),
          // SizedBox(
          //   height: 0.15*SizeConfig.sHeight,
          //   child: buildListAcivityHorizontal(),
          // ),
          const ListConversation()

        ],
      ),
    );
  }
}




