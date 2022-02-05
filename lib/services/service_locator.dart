

import 'package:get_it/get_it.dart';
import 'package:messenger_clone/business_logic/view_models/chatscreen_viewmodel.dart';
import 'package:messenger_clone/business_logic/view_models/homescreen_viewmodel.dart';
import 'package:messenger_clone/services/auth/auth_service.dart';
import 'package:messenger_clone/services/auth/auth_service_implementation.dart';
import 'package:messenger_clone/services/firebase_query/firebase_query.dart';
import 'package:messenger_clone/services/firebase_query/firebase_query_implementation.dart';

GetIt serviceLocator = GetIt.instance;

void setUpServiceLocator() {
  serviceLocator.registerLazySingleton<AuthService>(() => AuthServiceIml());
  serviceLocator.registerLazySingleton<FirebaseQuery>(() => FirebaseQueryIlm());

  serviceLocator.registerFactory<HomeViewModel>(() => HomeViewModel());
  serviceLocator.registerFactory<ChatViewModel>(() => ChatViewModel());
}
