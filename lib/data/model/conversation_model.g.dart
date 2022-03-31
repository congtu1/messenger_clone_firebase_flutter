// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    ConversationModel(
      id: json['id'] as String,
      members: json['members'] as List<dynamic>,
      recentMessage: json['recentMessage'] as Map<String, dynamic>,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      createBy: json['createBy'] as String,
    );

Map<String, dynamic> _$ConversationModelToJson(ConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'members': instance.members,
      'recentMessage': instance.recentMessage,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'createBy': instance.createBy,
    };
