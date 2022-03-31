import 'package:flutter/widgets.dart';
import 'package:messenger_clone/common/injector/injector.dart';
import 'package:messenger_clone/data/repositories/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final authRepository = getIt.get<AuthenticationRepository>();

  login() {
    authRepository.logInWithGoogle();
  }
}
