import 'package:messenger_clone/common/injector/injector.dart';
import 'package:messenger_clone/data/datasource/remote/chat_data_provider.dart';
import 'package:messenger_clone/data/model/conversation_model.dart';
import 'package:messenger_clone/data/model/user_detail_model.dart';
import 'package:messenger_clone/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {

  final dataProvider = getIt.get<ChatDataProvider>();

  Future<List<UserDetailModel>> getFriendList() async {
    List<UserDetailModel> list = [];
    await dataProvider. fetchAllUser().then((value) {
      for (var element in value.docs) {
        var user = UserDetailModel.fromSnapshot(element);
        list.add(user);
      }
    });
    return list;
  }
  Future<Stream> fetchHomeListConversation(String id)  {
    return dataProvider.fetchMyConversation(id);
  }

  @override
  Future<ConversationModel> fetchConversationInformation(String id) {
    return dataProvider.fetchConversation(id);
  }

  @override
  Future<Stream> fetchConversationMessage(String id)  {
     return dataProvider.fetchConversationMessages(id);
  }

  @override
  Future<void> newMessage(String id, message) async {
    return dataProvider.newMessage(id, message);
  }
  @override
  Future<void> newConversation(dynamic conversation)  {
    return dataProvider.createConversation(conversation);
  }

  Future<void> updateUserConversation(String idUser, String idCon) {
    return dataProvider.updateUserConversation(idUser, idCon);
  }

  Future<UserDetailModel> fetchUserInformation(String id) {

    return dataProvider.fetchUserInfo(id);
  }

  @override
  Future<void> updateConversationRecentMessage(String idConversation, recentMessage) async {
   return dataProvider.updateConversationRecentMessage(idConversation, recentMessage);
  }


}