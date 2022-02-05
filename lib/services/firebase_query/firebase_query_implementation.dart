import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:messenger_clone/helper/shared_pre_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger_clone/services/firebase_query/firebase_query.dart';

class FirebaseQueryIlm implements FirebaseQuery {
  @override
  Future<void> addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  @override
  Future<QuerySnapshot<Object?>> getUserByUserUID(String uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: uid)
        .get();
  }

  @override
  Future<Stream<QuerySnapshot<Object?>>> getConversationMessages(
      idConversation) async {
    return FirebaseFirestore.instance
        .collection("messages")
        .doc(idConversation)
        .collection("messages")
        .orderBy("sentAt", descending: false)
        .snapshots();
  }

  @override
  Future<Stream<QuerySnapshot<Object?>>> getMyConversation() async {
    String myId = await SharedPreferenceHelper().getUserId();
    return FirebaseFirestore.instance
        .collection("conversations")
        .where("members", arrayContainsAny: [myId]).snapshots();
  }

  @override
  Future<QuerySnapshot<Object?>> getUserInfo(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: id)
        .get();
  }

  @override
  Future<QuerySnapshot<Object?>> getAllUser() async {
    return await FirebaseFirestore.instance.collection("users").get();
  }

  @override
  Future<DocumentReference<Object?>> createNewConversation(conversation) async {
    return await FirebaseFirestore.instance
        .collection("conversations")
        .add(conversation);
  }

  @override
  Future<void> updateConversation(idConversation) {
    return FirebaseFirestore.instance
        .collection("conversations")
        .doc(idConversation)
        .update({'id': idConversation})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Future<void> addNewMessage(idConversation, data) async {
    await FirebaseFirestore.instance
        .collection("messages")
        .doc(idConversation)
        .collection("messages")
        .add(data);
  }

  @override
  Future<void> updateConversationRecentMessage(
      idConversation, recentMessage) async {
    return await FirebaseFirestore.instance
        .collection("conversations")
        .where('id', isEqualTo: idConversation)
        .get()
        .then((value) {
      FirebaseFirestore.instance
          .collection("conversations")
          .doc(value.docs[0].id)
          .update({'recentMessage': recentMessage}).then(
              (value) => print("Updated RecentMessage"));
    });
  }

  @override
  Future<QuerySnapshot<Object?>> getConversationById(idConversation) {
    return FirebaseFirestore.instance
        .collection('conversations')
        .where('id', isEqualTo: idConversation)
        .get();
  }

  @override
  Future<UploadTask> storageImage(File image, conversation, fileName) async {
    return FirebaseStorage.instance
        .ref('conversation')
        .child('${conversation.toString()}/${fileName.toString()}')
        .putFile(image);
  }
}
