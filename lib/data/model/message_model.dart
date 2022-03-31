import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:messenger_clone/domain/entities/message.dart';
part 'message_model.g.dart';

@JsonSerializable()
class MessageModel extends MessageEntity {
  const MessageModel(
      {required String messageText,
      required DateTime sentAt,
      required String sentBy,
      required String sentByName,
      required int status,
      required int category})
      : super(messageText, sentAt, sentBy, sentByName, status, category);

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  factory MessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    final newProfile =
        MessageModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return newProfile;
  }
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
