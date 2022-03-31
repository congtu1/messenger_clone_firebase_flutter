import 'package:flutter/widgets.dart';
import 'package:messenger_clone/common/injector/injector.dart';
import 'package:messenger_clone/data/model/conversation_model.dart';
import 'package:messenger_clone/data/model/user_detail_model.dart';
import 'package:messenger_clone/data/repositories/auth_repository.dart';
import 'package:messenger_clone/data/repositories/chat_repository_impl.dart';

class ConversationListViewModel with ChangeNotifier {
  final chatRepository = getIt.get<ChatRepositoryImpl>();
  final authRepository = getIt.get<AuthenticationRepository>();


  Future<UserDetailModel> fetchUserInformation(ConversationModel conversation) async  {
    return chatRepository.fetchUserInformation(fetchIdAnotherUser(conversation.members));
  }

  String fetchIdAnotherUser(List<dynamic> list) {
    String myId = authRepository.currentU!.id;
    list.remove(myId);
    return list.first;
  }

  String nameSend(String id, String senByName) {
    String name = id == authRepository.currentU!.id ? "Bạn" : senByName;
    return name;
  }
}