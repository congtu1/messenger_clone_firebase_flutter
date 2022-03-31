import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:messenger_clone/data/model/conversation_model.dart';
import 'package:messenger_clone/data/model/user_detail_model.dart';


class ChatDataProvider {

  // add user info when first login
  Future<void> addUserInfoToDB(String userId, Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  // fetch user information
  Future<UserDetailModel> fetchUserByUserUID(String uid) async {
    final QuerySnapshot data = await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: uid)
        .get();
    final user  = data.docs.isEmpty ? UserDetailModel.empty : UserDetailModel.fromSnapshot(data.docs[0]);
    return user;

  }

  // get all message in conversation
  Future<Stream<QuerySnapshot<Object?>>> fetchConversationMessages(
      idConversation) async {
    return FirebaseFirestore.instance
        .collection("messages")
        .doc(idConversation)
        .collection("messages")
        .orderBy("sentAt", descending: false)
        .snapshots();
  }

  // get my conversation
  Future<Stream<QuerySnapshot<Object?>>> fetchMyConversation(String id) async {
    print("ID"+id);
    return FirebaseFirestore.instance
        .collection("conversations")
        .where("members", arrayContainsAny: [id]).snapshots();
  }

  Future<UserDetailModel> fetchUserInfo(String id) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: id)
        .get();
    final UserDetailModel user = querySnapshot.docs.isEmpty ? UserDetailModel.empty : UserDetailModel.fromSnapshot(querySnapshot.docs.first);
    return user;
  }

  Future<QuerySnapshot<Object?>> fetchAllUser() async {
    return await FirebaseFirestore.instance.collection("users").get();
  }

  Future<void> createConversation(conversation) async {
     await FirebaseFirestore.instance
        .collection("conversations")
        .add(conversation);
  }

  Future<void> updateConversationId(idConversation) {
    return FirebaseFirestore.instance
        .collection("conversations")
        .doc(idConversation)
        .update({'id': idConversation})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> newMessage(idConversation, data) async {
    await FirebaseFirestore.instance
        .collection("messages")
        .doc(idConversation)
        .collection("messages")
        .add(data);
  }

  Future<void> updateConversationRecentMessage(
      idConversation, recentMessage) async {
    return await FirebaseFirestore.instance
        .collection("conversations")
        .where('id', isEqualTo: idConversation)
        .get()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection("conversations")
          .doc(value.docs.first.id)
          .update({'recentMessage': recentMessage}).then(
              (value) => print("Updated RecentMessage"));
    });
  }

  Future<void> updateUserConversation(String idUser,String idCon) async {
     await FirebaseFirestore.instance
        .collection("users")
        .doc(idUser)
         .update({
       "conversations" : FieldValue.arrayUnion([idCon]),
     });

  }

  Future<ConversationModel> fetchConversation(String idConversation) async {
    final QuerySnapshot data = await FirebaseFirestore.instance
        .collection('conversations')
        .where('id', isEqualTo: idConversation)
        .get();
    final conversation = data.docs.isEmpty ? ConversationModel.empty : ConversationModel.fromSnapshot(data.docs[0]);
    return conversation;

  }

  Future<UploadTask> storageImage(File image, conversation, fileName) async {
    return FirebaseStorage.instance
        .ref('conversation')
        .child('${conversation.toString()}/${fileName.toString()}')
        .putFile(image);
  }
}
