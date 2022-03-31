import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:messenger_clone/common/injector/injector.dart';
import 'package:messenger_clone/data/repositories/auth_repository.dart';
import 'package:messenger_clone/presentation/chat/viewmodel/conversationlist_viewmodel.dart';
import 'package:messenger_clone/presentation/chat_detail/chatdetail_viewmodel/chatdetail_viewmodel.dart';
import 'package:messenger_clone/presentation/home/home_viewmodel/home_viewmodel.dart';
import 'package:messenger_clone/presentation/home/view/home.dart';
import 'package:messenger_clone/presentation/app/app_viewmodel/app_viewmodel.dart';
import 'package:messenger_clone/presentation/login/login.dart';
import 'package:messenger_clone/presentation/login/login_viewmodel/login_viewmodel.dart';
import 'package:messenger_clone/presentation/splash.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final authRepo = getIt.get<AuthenticationRepository>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppViewModel(authRepo)),
          ChangeNotifierProvider(create: (context) => HomeViewModel()),
          ChangeNotifierProvider(create: (context) => LoginViewModel()),
          ChangeNotifierProvider(create: (context) => ChatDetailViewModel()),
          ChangeNotifierProvider(create: (context) => ConversationListViewModel(),)

        ],
        child: const MaterialApp(
          home: AppCustomBuilder(),
        ));
  }
}

class AppCustomBuilder extends StatelessWidget {
  const AppCustomBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<AuthenticationStatus>(
      state: context.watch<AppViewModel>().status,
      onGeneratePages: onGenerateAppViewPages,
    );
  }

  List<Page> onGenerateAppViewPages(
      AuthenticationStatus state, List<Page<dynamic>> pages) {
    print(state.toString());
    switch (state) {
      case AuthenticationStatus.auth:
        return [Home.page()];
      case AuthenticationStatus.unAuth:
        return [Login.page()];
      case AuthenticationStatus.unknown:
        return [Splash.page()];
    }
  }
}
