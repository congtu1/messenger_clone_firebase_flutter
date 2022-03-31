// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailModel _$UserDetailModelFromJson(Map<String, dynamic> json) =>
    UserDetailModel(
      id: json['uid'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      photo: json['imgUrl'] as String?,
      username: json['username'] as String,
      friends: json['friends'] as List<dynamic>,
      conversations: json['conversations'] as List<dynamic>,
    );

Map<String, dynamic> _$UserDetailModelToJson(UserDetailModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'uid': instance.id,
      'name': instance.name,
      'imgUrl': instance.photo,
      'username': instance.username,
      'friends': instance.friends,
      'conversations': instance.conversations,
    };
