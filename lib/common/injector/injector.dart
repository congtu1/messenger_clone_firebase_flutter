import 'package:get_it/get_it.dart';
import 'package:messenger_clone/data/datasource/remote/chat_data_provider.dart';
import 'package:messenger_clone/data/repositories/auth_repository.dart';
import 'package:messenger_clone/data/repositories/chat_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> setup() async{
  // service
  getIt.registerSingleton<ChatDataProvider>(ChatDataProvider());

  //repository
  getIt.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepository());
  getIt.registerLazySingleton<ChatRepositoryImpl>(() => ChatRepositoryImpl());

  // serviceLocator.registerLazySingleton<AuthService>(() => AuthServiceIml());
  // serviceLocator.registerLazySingleton<FirebaseQuery>(() => FirebaseQueryIlm());
  //
  // // serviceLocator.registerFactory<HomeViewModel>(() => HomeViewModel());
  // serviceLocator.registerFactory<ChatViewModel>(() => ChatViewModel());

}