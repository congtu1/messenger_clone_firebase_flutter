import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:messenger_clone/common/injector/injector.dart';
import 'package:messenger_clone/presentation/app/view/app.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print("This is message from background");
  print(message.notification!.title.toString());
  print(message.notification!.body.toString());
}

void main() async {
  await setup();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(App());
}

