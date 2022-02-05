import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';
@JsonSerializable()
class Message {
  final String messageText;
  final DateTime sentAt;
  final String sentBy;
  final int status;
  final int category;

  Message({required this.messageText, required this.sentAt, required this.sentBy,required this.status,required this.category});
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    final newProfile = Message.fromJson(snapshot.data() as Map<String, dynamic>);
    return newProfile;
  }


}