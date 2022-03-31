import 'package:flutter/material.dart';
import 'package:messenger_clone/presentation/chat_detail/chat_detail.dart';
import 'package:messenger_clone/presentation/chat_detail/chatdetail_viewmodel/chatdetail_viewmodel.dart';



import 'package:provider/provider.dart';


import '../home/home_viewmodel/home_viewmodel.dart';

class People extends StatelessWidget {
  const People({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<HomeViewModel>(builder: (context, value, child) {
          late Widget widget;
          if (value.getListFriend != []) {
            widget = Column(
              children: List.generate(value.getListFriend.length, (index) {
                return InkWell(
                  onTap: () async {
                    context.read<ChatDetailViewModel>().setUserChat(value.getListFriend[index]);
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> const ChatDetail()));

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            ClipOval(
                              child: Image.network(
                                value.getListFriend[index].photo.toString(),
                                height: 50,
                                width: 50,
                              ),
                              clipBehavior: Clip.antiAlias,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 13,
                                height: 13,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          value.getListFriend[index].name.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ))
                      ],
                    ),
                  ),
                );
              }),
            );
          } else {
            widget = const CircularProgressIndicator();
          }
          return widget;
        }),
      ),
    );
  }
}
