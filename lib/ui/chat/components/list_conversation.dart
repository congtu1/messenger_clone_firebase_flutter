import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger_clone/business_logic/model/conversation.dart';
import 'package:messenger_clone/business_logic/model/message.dart';
import 'package:messenger_clone/business_logic/model/user_detail.dart';
import 'package:messenger_clone/business_logic/view_models/chatscreen_viewmodel.dart';
import 'package:messenger_clone/business_logic/view_models/homescreen_viewmodel.dart';
import 'package:messenger_clone/helper/shared_pre_helper.dart';
import 'package:messenger_clone/services/firebase_query/firebase_query.dart';
import 'package:messenger_clone/services/service_locator.dart';
import 'package:messenger_clone/ui/chat_detail/chat_detail.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class ListConversation extends StatefulWidget {
  const ListConversation({Key? key}) : super(key: key);

  @override
  State<ListConversation> createState() => _ListConversationState();
}

class _ListConversationState extends State<ListConversation> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return StreamBuilder(
      stream: homeViewModel.getConversationStream,
      builder: (context,dynamic snapshot) {
        //print(snapshot.data.docs[0].toString());
        return snapshot.hasData  ?
              snapshot.data.docs.length >0 ?
              ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  Conversation conversation = Conversation.fromSnapshot(ds);
                    return ListConversationItem(conversation: conversation,);
                },
              )
              : CircularProgressIndicator()
            : CircularProgressIndicator();
      },
    );
  }
}

class ListConversationItem extends StatefulWidget {
    ListConversationItem({
    Key? key,this.conversation
  }) : super(key: key);

  final Conversation? conversation;

  @override
  State<ListConversationItem> createState() => _ListConversationItemState();
}

class _ListConversationItemState extends State<ListConversationItem> {
   UserDetail? friend;
   String? myid;
   FirebaseQuery firebaseQuery = serviceLocator<FirebaseQuery>();
   bool isLoading = false;

  void getInformation() async {
    String friendId = "";
    myid = await SharedPreferenceHelper().getUserId();
    widget.conversation!.members.forEach((element) {
     if(element != myid) {
        friendId = element;
     }
   });
    await firebaseQuery.getUserInfo(friendId).then((value) {
      friend = UserDetail.fromSnapshot(value.docs[0]);
      isLoading = true;
    });
    setState(() {});

}
bool checkRecent(Message recentMessage) {
    if(recentMessage.status == 0) {
      if(recentMessage.sentBy != myid) {
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
}
 @override
  void initState() {
    getInformation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final chatViewModel = Provider.of<ChatViewModel>(context);

    Message recentMessage =  Message.fromJson(widget.conversation!.recentMessage);
    return isLoading ? InkWell(
      onTap: () async{
        await chatViewModel.setUpConversation(widget.conversation!.id.toString(), friend!).then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (_)=> ChatDetail()));
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          children: [
            CircleAvatar(),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend!.name.toString(),
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    recentMessage.category == 0 ?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(recentMessage.messageText.toString(),style: TextStyle(
                          fontWeight: checkRecent(recentMessage) ? FontWeight.bold : null
                      ),),
                    )
                    : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text("Đã gửi một ảnh",style: TextStyle(
                          fontWeight: checkRecent(recentMessage) ? FontWeight.bold : null
                      ),),
                    ),
                    Icon(FontAwesomeIcons.centos,size: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(recentMessage.sentAt.hour.toString()+":"+recentMessage.sentAt.minute.toString()),
                    )
                  ],
                )

              ],
            )
          ],
        ),
      ),
    )
    : CircularProgressIndicator();
  }
}
