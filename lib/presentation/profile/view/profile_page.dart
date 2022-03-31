import 'package:flutter/material.dart';
import 'package:messenger_clone/presentation/home/home_viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';
class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: TextButton(
            onPressed: (){
              context.read<HomeViewModel>().logout();
            },
            child: const Text("Logout"),
          ),
        ),
      ),
    );
  }
}
