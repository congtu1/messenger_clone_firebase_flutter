import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_clone/business_logic/view_models/homescreen_viewmodel.dart';
import 'package:messenger_clone/services/auth/auth_service.dart';
import 'package:messenger_clone/services/service_locator.dart';

import '../splash.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthService authService = serviceLocator<AuthService>();
  HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
         child: Column(
           children: [
             TextButton(
                 onPressed: () async {
               User? user = await authService.signInWithGoogle(context: context);
               if (user != null) {
                 homeViewModel.loadOnLaunch();
                 Navigator.push(context, MaterialPageRoute(builder: (_)=> Splash()));
               }
             },
                 child: Text("Login")
             ),
             TextButton(
                 onPressed: () async {
                   await authService.signOut(context: context);
                 },
                 child: Text("LogOut")
             )
           ],
         ),
        ),
      ),
    );
  }
}
