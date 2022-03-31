import 'package:flutter/material.dart';
import 'package:messenger_clone/common/injector/injector.dart';
import 'package:messenger_clone/data/repositories/auth_repository.dart';
import 'package:messenger_clone/presentation/profile/view/profile_page.dart';

import 'package:provider/provider.dart';

import '../../../constant/size.dart';
import '../../chat/chat.dart';
import '../../people/people.dart';
import '../../stories/stories.dart';
import '../home_viewmodel/home_viewmodel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: Home());

  static List<Widget> pages = <Widget>[
    const Chat(),
    const People(),
    const Stories(),
  ];
  static List<String> titles = ["Chat", "People", "Stories"];

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String notificationMsg = " Waiting message ";

  final authRepo = getIt.get<AuthenticationRepository>();
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
    context.read<HomeViewModel>().fetchFriendList();
    context.read<HomeViewModel>().fetchListConversationStream();
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
              child: ClipOval(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => Profile()));
                  },
                  child: Image.network(
                    authRepo.currentU!.photo.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
              ),
              padding: const EdgeInsets.all(5),
            ),
            title: Text(
              Home.titles[homeModel.selectedTab],
              style: const TextStyle(color: Colors.black),
            ),
          ),
          body: IndexedStack(
            index: homeModel.selectedTab,
            children: Home.pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.message), label: "Chat"),
              BottomNavigationBarItem(icon: Icon(Icons.people), label: "People",),
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
