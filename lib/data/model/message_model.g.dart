// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      messageText: json['messageText'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String),
      sentBy: json['sentBy'] as String,
      sentByName: json['sentByName'] as String,
      status: json['status'] as int,
      category: json['category'] as int,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'messageText': instance.messageText,
      'sentAt': instance.sentAt.toIso8601String(),
      'sentBy': instance.sentBy,
      'sentByName': instance.sentByName,
      'status': instance.status,
      'category': instance.category,
    };
