import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserDetailEntity extends Equatable{
  String uid;
  String name;
  String username;
  String imgUrl;
  String email;
  List<dynamic> friends;
  List<dynamic> conversations;

  UserDetailEntity(this.uid, this.name, this.username, this.imgUrl, this.email,
      this.friends, this.conversations);

  @override
  List<Object?> get props => [uid,name,username,imgUrl,email,friends,conversations];
  
  @override
  bool? get stringify => true;
}