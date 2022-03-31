import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:messenger_clone/data/model/user_model.dart';
import 'package:messenger_clone/data/repositories/auth_repository.dart';

enum AuthenticationStatus {unknown, auth, unAuth}

class AppViewModel with ChangeNotifier {

  AppViewModel(this._authenticationRepository,) {
    _authStream = _authenticationRepository.user.listen((event) {
      if(event == UserModel.empty) {
        _status = AuthenticationStatus.unAuth;
      }
      else {
        _status = AuthenticationStatus.auth;
      }

      notifyListeners();
    });
  }

  AuthenticationStatus _status = AuthenticationStatus.unknown;

  AuthenticationStatus get status => _status;

  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<UserModel> _authStream;
  late UserModel currentUser;


}