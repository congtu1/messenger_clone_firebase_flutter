// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetail _$UserDetailFromJson(Map<String, dynamic> json) => UserDetail(
      uid: json['uid'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
      imgUrl: json['imgUrl'] as String,
      email: json['email'] as String,
      friends: json['friends'] as List<dynamic>,
      conversations: json['conversations'] as List<dynamic>,
    );

Map<String, dynamic> _$UserDetailToJson(UserDetail instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'username': instance.username,
      'imgUrl': instance.imgUrl,
      'email': instance.email,
      'friends': instance.friends,
      'conversations': instance.conversations,
    };
