import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:messenger_clone/business_logic/view_models/homescreen_viewmodel.dart';
import 'package:messenger_clone/ui/splash.dart';
import 'package:provider/provider.dart';
import 'package:messenger_clone/services/service_locator.dart';

import 'business_logic/view_models/chatscreen_viewmodel.dart';


Future<void> backgroundHandler(RemoteMessage message) async {
  print("This is message from background");
  print(message.notification!.title.toString());
  print(message.notification!.body.toString());

}

void main() async {

  setUpServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeViewModel(),),
        ChangeNotifierProvider(create: (context) => ChatViewModel(),),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: Splash()
      )
    );
  }
}
