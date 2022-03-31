import 'package:flutter/material.dart';
import 'package:messenger_clone/presentation/chat_detail/chatdetail_viewmodel/chatdetail_viewmodel.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class ChatDetail extends StatefulWidget {
  const ChatDetail({Key? key}) : super(key: key);

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {

@override
  void initState() {
    context.read<ChatDetailViewModel>().setUpConversation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  final chatViewModel = Provider.of<ChatDetailViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.withOpacity(0.4),
        title: Row(
          children: [
            const BackButton(),
            ClipOval(child: Image.network(chatViewModel.getUserChat.photo.toString(),width: 30,height: 30,),clipBehavior: Clip.antiAlias,),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatViewModel.getUserChat.name.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                const Text(
                  "Active",
                  style: TextStyle(fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
      body: const Body(),
    );
  }
}
