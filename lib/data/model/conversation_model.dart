import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:messenger_clone/domain/entities/conversation.dart';
part 'conversation_model.g.dart';
@JsonSerializable()
class ConversationModel extends ConversationEntity {
  const ConversationModel(
      {required String id,
      required List members,
      required Map<String, dynamic> recentMessage,
      required String createdAt,
      required String updatedAt,
      required String createBy})
      : super(id, members, recentMessage, createdAt, updatedAt, createBy);

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);

  factory ConversationModel.fromSnapshot(DocumentSnapshot snapshot) {
    final conv = ConversationModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return conv;
  }

  static const empty =   ConversationModel(id: "", members: [], recentMessage: {}, createdAt: "", updatedAt:"", createBy: "");

  bool get isEmpty => this == ConversationModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != ConversationModel.empty;
}
