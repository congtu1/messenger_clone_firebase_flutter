
import 'package:flutter/widgets.dart';
import 'package:messenger_clone/common/injector/injector.dart';
import 'package:messenger_clone/data/model/user_detail_model.dart';
import 'package:messenger_clone/data/repositories/auth_repository.dart';
import 'package:messenger_clone/data/repositories/chat_repository_impl.dart';

class MessengerTab {
  static const chat = 0;
  static const people = 1;
}

class HomeViewModel with ChangeNotifier {

final chatRepository = getIt.get<ChatRepositoryImpl>();
final authRepository = getIt.get<AuthenticationRepository>();
Stream homeListConversationStream =  const Stream.empty();
  int selectedTab = MessengerTab.chat;
  List<UserDetailModel> listFriend = [];
  UserDetailModel currentUserDetail = UserDetailModel.empty;



//fetch home list conversation stream
  void fetchListConversationStream() async {
    await chatRepository.fetchHomeListConversation(authRepository.currentU!.id).then((value) {
      homeListConversationStream = value;
      notifyListeners();
    });

  }
  get getHomeListConversationStream => homeListConversationStream;
// fetch user friend
  Future<void> fetchFriendList() async {
    listFriend = await chatRepository.getFriendList();
    notifyListeners();
  }
  get getListFriend => listFriend;


Future<void> fetchCurrentUser() async {
  currentUserDetail = authRepository.getCurrentUserDetail;
  notifyListeners();
}
  /// tab
void goToTab(index) {
  selectedTab = index;
  notifyListeners();
  // if(index == 1) {
  //   authRepository.logOut();
  // }
}
get getSelectTab => selectedTab;
}