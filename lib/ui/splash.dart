import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_clone/business_logic/model/user_detail.dart';
import 'package:messenger_clone/business_logic/view_models/homescreen_viewmodel.dart';
import 'package:messenger_clone/helper/shared_pre_helper.dart';
import 'package:messenger_clone/home.dart';
import 'package:messenger_clone/services/auth/auth_service.dart';
import 'package:messenger_clone/services/service_locator.dart';
import 'package:messenger_clone/ui/login/login.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SlpashState();
}

class _SlpashState extends State<Splash> with SingleTickerProviderStateMixin {

  AuthService authService = serviceLocator<AuthService>();
  late Animation<double> opacity;
  late AnimationController controller;
  User? curentUser;




  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) async{
      curentUser = await authService.getCurrentUserSignIn();
      if(curentUser !=null) {
        await Provider.of<HomeViewModel>(context,listen: false).loadOnLaunch();
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => Home()));
      }
      else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => Login()));
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Opacity(
          opacity: opacity.value,
          child: Container(),
        ),
      ),
    );
  }
}
