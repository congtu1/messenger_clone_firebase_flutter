import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:messenger_clone/common/helper/string_helper.dart';
import 'package:messenger_clone/common/injector/injector.dart';
import 'package:messenger_clone/data/model/conversation_model.dart';
import 'package:messenger_clone/data/model/message_model.dart';
import 'package:messenger_clone/data/model/user_detail_model.dart';
import 'package:messenger_clone/data/repositories/auth_repository.dart';
import 'package:messenger_clone/data/repositories/chat_repository_impl.dart';

class ChatDetailViewModel with ChangeNotifier {
  final chatRepository = getIt.get<ChatRepositoryImpl>();
  final authRepository = getIt.get<AuthenticationRepository>();
  Stream messageStream = const Stream.empty();
  String idConversation = "";
  String messageText = "";
  UserDetailModel userChat = UserDetailModel.empty;
  final ScrollController scrollController = ScrollController();


  void sendMessage() async {
    if(messageText.isNotEmpty) {
      var messageData = MessageModel(
          messageText: messageText,
          sentAt: DateTime.now(),
          sentBy: authRepository.getCurrentUser.id,
          sentByName: authRepository.currentU!.name!.split(" ").last.toString(),
          status: 0,
          category: 0)
          .toJson();

      if (messageStream != const Stream.empty()) {
        chatRepository.newMessage(fetchIdConversation(), messageData);
        chatRepository.updateConversationRecentMessage(fetchIdConversation(), messageData);

      }
      else {
            var conversation = ConversationModel(
                    id: fetchIdConversation(),
                    members: [
                      authRepository.currentU!.id,
                      userChat.id
                    ],
                    recentMessage: messageData,
                    createdAt: DateTime.now().toString(),
                    updatedAt: DateTime.now().toString(),
                    createBy: authRepository.currentU!.id)
                .toJson();
           await chatRepository.newConversation(conversation);
           await chatRepository.updateUserConversation(authRepository.currentU!.id, fetchIdConversation());
           await chatRepository.newMessage(idConversation, messageData);
            await chatRepository.updateConversationRecentMessage(fetchIdConversation(), messageData);

           setUpConversation();

      }
      messageText = "";
    }
  }

  void setUpConversation() async {
    fetchIdConversation();
    setIdConversation();
    ConversationModel conv =
        await chatRepository.fetchConversationInformation(idConversation);
    if (conv != ConversationModel.empty) {
      await chatRepository
          .fetchConversationMessage(idConversation)
          .then((value) {
        messageStream = value;
        notifyListeners();
      });
    } else {
      idConversation = fetchIdConversation();
    }
  }

  String fetchIdConversation() {
    String idCurrentUser = authRepository.getCurrentUser.id;
    String idUserChat = userChat.id;
    String idConversation =
        StringHelper().compareStringForID(idCurrentUser, idUserChat);
    return idConversation;
  }

  void setIdConversation() {
    idConversation = fetchIdConversation();
  }

  /// Check usersent
  bool whoSend(MessageModel ms) {
    String idCurrentUser = authRepository.getCurrentUser.id;
    return idCurrentUser == ms.sentBy;
  }

  /// set scroll controller to max
  void scrollToMax() async {
    await Future.delayed(const Duration(milliseconds: 300));
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn);
    });
    notifyListeners();
  }

  void chatFieldInputChange(String text) {
    messageText = text;
    notifyListeners();
  }

  String get getMessageText => messageText;

  ScrollController get getScrollController => scrollController;
  void setUserChat(UserDetailModel user) => userChat = user;
  UserDetailModel get getUserChat => userChat;
  Stream get getMessageStream => messageStream;
}
