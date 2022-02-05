import 'package:flutter/material.dart';
import 'package:messenger_clone/business_logic/view_models/chatscreen_viewmodel.dart';
import 'package:messenger_clone/services/service_locator.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class ChatDetail extends StatefulWidget {
  const ChatDetail({Key? key}) : super(key: key);

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {


  @override
  Widget build(BuildContext context) {
    final chatViewModel = Provider.of<ChatViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.withOpacity(0.4),
        title: Row(
          children: [
            BackButton(),
            ClipOval(child: Image.network(chatViewModel.getUserReceive.imgUrl.toString(),width: 30,height: 30,),clipBehavior: Clip.antiAlias,),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatViewModel.getUserReceive.name,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Active",
                  style: TextStyle(fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
      body: Body(),
    );
  }
}
