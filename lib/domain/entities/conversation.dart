import 'package:equatable/equatable.dart';

class ConversationEntity extends Equatable{
  final String id;
  final List<dynamic> members;
  final Map<String,dynamic> recentMessage;
  final String createdAt;
  final String updatedAt;
  final String createBy;

  const ConversationEntity(this.id, this.members, this.recentMessage, this.createdAt,
      this.updatedAt, this.createBy);

  @override
  List<Object?> get props => [id,members,recentMessage,createdAt,createBy,createBy];

  @override
  bool? get stringify => true;
}