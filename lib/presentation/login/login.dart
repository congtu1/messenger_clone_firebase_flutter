import 'package:flutter/material.dart';
import 'package:messenger_clone/presentation/login/login_viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: Login());

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextButton(
                  onPressed: () async {
                    loginViewModel.login();
                  },
                  child: const Text("Login")),
              TextButton(onPressed: () async {}, child: const Text("LogOut"))
            ],
          ),
        ),
      ),
    );
  }
}
