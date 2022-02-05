

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class FirebaseQuery {

  Future<void> addUserInfoToDB (String userId, Map<String, dynamic> userInfoMap);
  Future<QuerySnapshot> getUserInfo(String id);
  Future<QuerySnapshot> getUserByUserUID(String uid);
  Future<Stream<QuerySnapshot>> getConversationMessages(idConversation);
  Future<Stream<QuerySnapshot>> getMyConversation();
  Future<QuerySnapshot> getConversationById(idConversation);
  Future<QuerySnapshot> getAllUser();
  Future<DocumentReference> createNewConversation(conversation);
  Future<void> updateConversation(idConversation);
  Future<void> addNewMessage(idConversation,data);
  Future<void> updateConversationRecentMessage(idConversation,recentMessage);
  Future<UploadTask> storageImage(File image,conversation,fileName);
}