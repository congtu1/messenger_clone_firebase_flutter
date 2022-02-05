import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'conversation.g.dart';
@JsonSerializable()
class Conversation {
  final String id;
  final List<dynamic> members;
  final Map<String,dynamic> recentMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createBy;

  Conversation({required this.id, required this.members, required this.recentMessage, required this.createdAt,
      required this.updatedAt, required this.createBy});

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationToJson(this);

  factory Conversation.fromSnapshot(DocumentSnapshot snapshot) {
    final conv = Conversation.fromJson(snapshot.data() as Map<String, dynamic>);
    return conv;
  }

}

