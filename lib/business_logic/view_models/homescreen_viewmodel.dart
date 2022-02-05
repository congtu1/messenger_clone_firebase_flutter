

import 'package:flutter/widgets.dart';
import 'package:messenger_clone/business_logic/model/user_detail.dart';
import 'package:messenger_clone/helper/shared_pre_helper.dart';
import 'package:messenger_clone/services/auth/auth_service.dart';
import 'package:messenger_clone/services/firebase_query/firebase_query.dart';
import 'package:messenger_clone/services/service_locator.dart';

class MessengerTab {
  static const chat = 0;
  static const people = 1;
}

class HomeViewModel extends ChangeNotifier {
  bool _loggedIn = false;
  AuthService authService = serviceLocator<AuthService>();
  FirebaseQuery firebaseQuery = serviceLocator<FirebaseQuery>();
  UserDetail? currentUser;
  Stream? chatStream;
  int selectedTab = MessengerTab.chat;
  List<UserDetail>  listFriends = [];
  Stream? conversationStream;

  Future<void> loadOnLaunch() async {
    await getCurrentUserInf();
    await getFriends();
    await getMyConversation();
    signed();
  }
  Future<int> getMyConversation() async {
    await firebaseQuery.getMyConversation().then((value) {
      conversationStream = value;
    });
    return 0;
  }
  Future<int> getCurrentUserInf() async {
    String id = await SharedPreferenceHelper().getUserId();
    await firebaseQuery.getUserByUserUID(id).then((value) {
      var user = UserDetail.fromSnapshot(value.docs[0]);
      setCurrentUser(user);
      notifyListeners();
    });
    return 0;
  }
  Future<int> getFriends() async {
    await firebaseQuery.getAllUser().then((value) {
      List<UserDetail> list = [];
      value.docs.forEach((e) {
        var profile = UserDetail.fromSnapshot(e);
        list.add(profile);
      });
      listFriends = list;
    });
    return 0;
  }



  void setListFriend(List<UserDetail> list)  {
    listFriends = list;
    notifyListeners();
  }

  void setCurrentUser(UserDetail profile) {
    currentUser = profile;
    notifyListeners();
  }

  void goToTab(index) {
    selectedTab = index;
    notifyListeners();
  }
  void signed() {
    _loggedIn = true;
    notifyListeners();
  }
  void logout() {
    _loggedIn = false;
    selectedTab = 0;
    notifyListeners();
  }
  get getSelectTab => selectedTab;
  get getCurrentUserInformation => currentUser;
  get getListFriends => listFriends;
  get getConversationStream => conversationStream;
  bool get isLoggedIn => _loggedIn;
}