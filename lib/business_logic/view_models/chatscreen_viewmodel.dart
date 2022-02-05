import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:messenger_clone/business_logic/model/conversation.dart';
import 'package:messenger_clone/business_logic/model/message.dart';
import 'package:messenger_clone/business_logic/model/user_detail.dart';
import 'package:messenger_clone/business_logic/view_models/homescreen_viewmodel.dart';
import 'package:messenger_clone/services/firebase_query/firebase_query.dart';
import 'package:messenger_clone/services/service_locator.dart';
import 'package:provider/provider.dart';

class ChatViewModel extends ChangeNotifier {
  FirebaseQuery firebaseQuery = serviceLocator<FirebaseQuery>();
  Stream? messageStream;
  String? idConversation;
  UserDetail? userReceive;
  bool? hasConversation;
  ScrollController scrollController = ScrollController();



  Future<void> setUpConversation(String idCon,UserDetail userR) async {
    await firebaseQuery.getConversationById(idCon).then((value) async{
      if(value.size>0) {
        String id = Conversation.fromSnapshot(value.docs[0]).id;
        setIdConversation(id);
        setUserReceive(userR);
        await firebaseQuery.getConversationMessages(idCon).then((value) {
          messageStream = value;
          setHasConversation(true);
        });
      }
      else {
        clearMessageStream();
        setUserReceive(userR);
        setHasConversation(false);
      }
    });
  }

  Future<void> sendImage(BuildContext context,image,fileName) async {
    var homeViewModel = Provider.of<HomeViewModel>(context,listen: false);
    await firebaseQuery.storageImage(image, idConversation, fileName).then((value) async {
      value.whenComplete(() {
        value.snapshot.ref.getDownloadURL().then((value) {
          var messageData = Message(
              messageText: value.toString(),
              sentAt: DateTime.now(),
              sentBy: homeViewModel.getCurrentUserInformation.uid
                  .toString(),
              status: 0,
              category: 1)
              .toJson();
          addMessage(messageData);
        });
      });

    });
  }

  Future<void> addMessage(message) async {
    await firebaseQuery.addNewMessage(idConversation, message);
    await firebaseQuery.updateConversationRecentMessage(idConversation, message);
  }
  Future<void> firstMessage(conversation,message) async {
    await firebaseQuery.createNewConversation(conversation).then((value) {
      setHasConversation(true);
      setIdConversation(conversation['id'].toString());
      addMessage(message);
    });
    
  }

  void clearMessageStream() {
    messageStream = null;
  }

  void setHasConversation(bool hasC) {
    hasConversation = hasC;
  }

  void setIdConversation(String id){
    idConversation = id;
  }

  void setUserReceive(UserDetail user) {
    userReceive = user;
  }

  get getIdConversation => idConversation;
  get getUserReceive  =>  userReceive;
  get getHasConversation  =>  hasConversation;
  get getMessageStream  =>  messageStream;
  get getScrollController => scrollController;


}