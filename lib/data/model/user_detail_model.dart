import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:messenger_clone/domain/entities/user.dart';
part 'user_detail_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class UserDetailModel extends UserEntity {
  const UserDetailModel(
      {required String id,
      required String? name,
      required String? email,
      required String? photo,
      required this.username,
      required this.friends,
      required this.conversations})
      : super(id: id, name: name, email: email, photo: photo);

  final String username;
  final List friends;
  final List conversations;

  factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailModelFromJson(json);

  factory UserDetailModel.fromSnapshot(DocumentSnapshot snapshot) {
    final newProfile =
        UserDetailModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return newProfile;
  }

  static const empty = UserDetailModel(id: "", name: "", email: "", photo: "", username: "", friends: [], conversations: []);

  @override
  bool get isEmpty => this == UserDetailModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  @override
  bool get isNotEmpty => this != UserDetailModel.empty;

}
