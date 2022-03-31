import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:messenger_clone/domain/entities/user.dart';
part 'user_model.g.dart';
@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({required String id, String? photo, String? email, String? name})
      : super(id: id, photo: photo, email: email, name: name);

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final profile = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return profile;
  }

  factory UserModel.toUserModel(User user) {
    return UserModel(id: user.uid,photo: user.photoURL,email: user.email,name: user.displayName);
  }

  Map<String, String> toJson() => {
   'id': id,
   'photo':photo!,
   'email':email!,
    'name':name!
  };

  /// Empty user which represents an unauthenticated user.
  static const empty  =   UserModel(id: '',name: "",email: "",photo: "");

  /// Convenience getter to determine whether the current user is empty.
  @override
  bool get isEmpty => this == UserModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  @override
  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object?> get props => [email, id, name, photo];

}
