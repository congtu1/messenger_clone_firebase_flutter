import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_detail.g.dart';
@JsonSerializable()
class UserDetail {
  UserDetail(
      {required this.uid, required this.name, required this.username, required this.imgUrl, required this.email,
        required this.friends,required this.conversations});

  factory UserDetail.fromJson(Map<String, dynamic> json) =>
      _$UserDetailFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailToJson(this);
  @JsonKey(name: 'uid')
  String uid;
  String name;
  String username;
  String imgUrl;
  String email;
  List<dynamic> friends;
  List<dynamic> conversations;

  factory UserDetail.fromSnapshot(DocumentSnapshot snapshot) {
    final newProfile = UserDetail.fromJson(snapshot.data() as Map<String, dynamic>);
    return newProfile;
  }

}
  //   return Profile(
  //     uid: json['udi'],
  //     name: json['name'],
  //     username: json['username'],
  //     imgUrl: json['imgUrl'],
  //     email: json['email'],
  //     friends: json['friends']
  //   );
  // }
