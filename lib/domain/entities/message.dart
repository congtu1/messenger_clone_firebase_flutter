import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable{
  final String messageText;
  final DateTime sentAt;
  final String sentBy;
  final String sentByName;
  final int status;
  final int category;

  const MessageEntity(
      this.messageText, this.sentAt, this.sentBy,this.sentByName, this.status, this.category, );

  @override
  // TODO: implement props
  List<Object?> get props => throw [messageText,sentAt,sentBy,status,category];
}