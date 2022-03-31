
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: Login());
  @override
  State<Splash> createState() => _SlpashState();
}

class _SlpashState extends State<Splash> with SingleTickerProviderStateMixin {


  late Animation<double> opacity;
  late AnimationController controller;
  User? currentUser;

  @override
  void initState() {
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
