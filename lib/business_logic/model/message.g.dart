// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      messageText: json['messageText'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String),
      sentBy: json['sentBy'] as String,
      status: json['status'] as int,
      category: json['category'] as int,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'messageText': instance.messageText,
      'sentAt': instance.sentAt.toIso8601String(),
      'sentBy': instance.sentBy,
      'status': instance.status,
      'category': instance.category,
    };
