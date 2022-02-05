import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:messenger_clone/business_logic/view_models/homescreen_viewmodel.dart';
import 'package:messenger_clone/services/notification/local_notification.dart';
import 'package:messenger_clone/ui/chat/chat.dart';
import 'package:messenger_clone/ui/people/people.dart';
import 'package:messenger_clone/ui/stories/stories.dart';
import 'package:provider/provider.dart';

import 'constant/size.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static List<Widget> pages = <Widget>[
    const Chat(),
    People(),
    const Stories(),
  ];
  static List<String> titles = ["Chat", "People", "Stories"];

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String notificationMsg = " Waiting message ";
  @override
  void initState() {
    // LocalNotificationService.initialise();
    // FirebaseMessaging.instance.getInitialMessage().then((event) {
    //   LocalNotificationService.showNotificationOnForeground(event!);
    //   setState(() {
    //     notificationMsg = "${event.notification!.title} ${event.notification!.body} I am coming from terminated state";
    //   });
    //
    // });
    // FirebaseMessaging.onMessage.listen((event) {
    //   setState(() {
    //     notificationMsg = "${event.notification!.title} ${event.notification!.body} I am coming from forground";
    //
    //   });
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   setState(() {
    //     notificationMsg = "${event.notification!.title} ${event.notification!.body} I am coming from background";
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<HomeViewModel>(
      builder: (context, homeModel, child) {

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: Padding(
              child: ClipOval(child: Image.network(homeModel.getCurrentUserInformation!.imgUrl.toString(),fit: BoxFit.cover,),clipBehavior: Clip.antiAlias,),
              padding: EdgeInsets.all(5),
            ),
            title: Text(
              Home.titles[homeModel.selectedTab],
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: IndexedStack(
            index: homeModel.selectedTab,
            children: Home.pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.message), label: "Chat"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), label: "People"),
              // BottomNavigationBarItem(icon: Icon(Icons.book), label: "Story")
            ],
            onTap: (index) {
              homeModel.goToTab(index);
            },
          ),
        );
      },
    );
  }
}
