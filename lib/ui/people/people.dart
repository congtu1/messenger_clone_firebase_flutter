import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_clone/business_logic/model/conversation.dart';
import 'package:messenger_clone/business_logic/model/user_detail.dart';
import 'package:messenger_clone/business_logic/view_models/chatscreen_viewmodel.dart';
import 'package:messenger_clone/business_logic/view_models/homescreen_viewmodel.dart';
import 'package:messenger_clone/constant/provider_data.dart';
import 'package:messenger_clone/helper/string_helper.dart';
import 'package:messenger_clone/services/firebase_query/firebase_query.dart';
import 'package:messenger_clone/services/service_locator.dart';

import 'package:messenger_clone/ui/chat_detail/chat_detail.dart';
import 'package:provider/provider.dart';

class People extends StatelessWidget {
   People({Key? key}) : super(key: key);
   FirebaseQuery firebaseQuery = serviceLocator<FirebaseQuery>();
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final chatViewModel = Provider.of<ChatViewModel>(context);
    List<UserDetail> data = homeViewModel.getListFriends;

    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
      children: List.generate(data.length, (index) {
        if(homeViewModel.getCurrentUserInformation.uid != data[index].uid) {
          return InkWell(
            onTap: () async {
              var myid= homeViewModel.getCurrentUserInformation.uid.toString();
              var uid = data[index].uid.toString();
              var id = StringHelper().compareStringForID(myid, uid);
              await chatViewModel.setUpConversation(id, data[index]).then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (_)=> ChatDetail()));
              });

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Stack(children: [
                    ClipOval(child: Image.network(data[index].imgUrl.toString(),height: 50,width: 50,),clipBehavior: Clip.antiAlias,),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green
                        ),
                      ),
                    )
                  ],),
                  SizedBox(width: 10,),
                  Expanded(child: Text(data[index].name.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),))
                ],
              ),
            ),
          );
        }
        else {
          return Container();
        }

      }),
    ),
        ));
  }
}
