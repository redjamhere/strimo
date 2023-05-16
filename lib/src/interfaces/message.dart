import 'package:equatable/equatable.dart';
import 'package:joyvee/src/utils/utils.dart';

abstract class MessageInterface extends Equatable{
  const MessageInterface({
    this.id,
    this.chatId,
    this.senderId,
    required this.type,
    this.receiverId,
    this.date,
    this.content
  });

  final int? id;
  final int? chatId;
  final int? senderId;
  final MessageType type;
  final int? receiverId;
  final DateTime? date;
  final dynamic content;

  List<Object?> get props => [
    id, chatId, senderId, type, receiverId, date, content];
}