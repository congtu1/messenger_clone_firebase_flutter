import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger_clone/data/model/conversation_model.dart';
import 'package:messenger_clone/data/model/message_model.dart';
import 'package:messenger_clone/data/model/user_detail_model.dart';
import 'package:messenger_clone/presentation/chat/viewmodel/conversationlist_viewmodel.dart';
import 'package:messenger_clone/presentation/home/home_viewmodel/home_viewmodel.dart';
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
    return Consumer<HomeViewModel>(
      builder: (context, value, child) {
        return StreamBuilder(
          stream: value.getHomeListConversationStream,
          builder: (context, dynamic snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  ConversationModel conversation =
                      ConversationModel.fromSnapshot(ds);
                  return ListConversationItem(
                    conversation: conversation,
                  );
                },
              );
            } else {
              print("Snapshot data:" + snapshot.error.toString());

              return const SizedBox();
            }
          },
        );
      },
    );
  }
}

class ListConversationItem extends StatefulWidget {
  const ListConversationItem({Key? key, this.conversation}) : super(key: key);

  final ConversationModel? conversation;

  @override
  State<ListConversationItem> createState() => _ListConversationItemState();
}

class _ListConversationItemState extends State<ListConversationItem> {
  // void getInformation() async {
  //   String friendId = "";
  //   myid = await SharedPreferenceHelper().getUserId();
  //   widget.conversation!.members.forEach((element) {
  //     if (element != myid) {
  //       friendId = element;
  //     }
  //   });
  //   await firebaseQuery.getUserInfo(friendId).then((value) {
  //     friend = UserDetail.fromSnapshot(value.docs[0]);
  //     isLoading = true;
  //   });
  //   setState(() {});
  // }
  //
  // bool checkRecent(Message recentMessage) {
  //   if (recentMessage.status == 0) {
  //     if (recentMessage.sentBy != myid) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     return false;
  //   }
  // }

  @override
  void initState() {
    // getInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MessageModel recentMessage =
        MessageModel.fromJson(widget.conversation!.recentMessage);
    return FutureBuilder(
      future: context.read<ConversationListViewModel>().fetchUserInformation(widget.conversation!),
      builder: (context,AsyncSnapshot<UserDetailModel> snapshot) {
      if(snapshot.hasData) {
        return InkWell(
          onTap: () async {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              children: [
                const CircleAvatar(),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data!.name.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  [
                        Text(context.read<ConversationListViewModel>().nameSend(recentMessage.sentBy, recentMessage.sentByName)+":"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: recentMessage.category == 0
                              ? Text(
                            recentMessage.messageText,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                              : const Text(
                            "Đã gửi một ảnh",
                            style:
                            TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(
                          FontAwesomeIcons.centos,
                          size: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(recentMessage.sentAt.hour.toString()+":" +recentMessage.sentAt.minute.toString()),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }
      else {
        return Container();
      }
    }
    ,);
  }
}
