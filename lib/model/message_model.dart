import 'package:quick_chat/Exports/common_exports.dart';

@immutable
class MessageModel {
  final String senderID;
  final String receiverID;
  final String sentTime;
  final String readTime;
  final String message;
  final String messageType;

  const MessageModel(
      {required this.senderID,
      required this.receiverID,
      required this.sentTime,
      required this.readTime,
      required this.message,
      required this.messageType});

  MessageModel copyWith(
      {String? senderID,
      String? receiverID,
      String? sentTime,
      String? readTime,
      String? message,
      String? messageType}) {
    return MessageModel(
        senderID: senderID ?? this.senderID,
        receiverID: receiverID ?? this.receiverID,
        sentTime: sentTime ?? this.sentTime,
        readTime: readTime ?? this.readTime,
        message: message ?? this.message,
        messageType: messageType ?? this.messageType);
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        senderID: json['senderID'],
        receiverID: json['receiverID'],
        sentTime: json['sentTime'],
        readTime: json['readTime'],
        message: json['message'],
        messageType: json['messageType']);
  }
  Map<String, dynamic> toJson() {
    return {
      'senderID': senderID,
      'receiverID': receiverID,
      'sentTime': sentTime,
      'readTime': readTime,
      'message': message,
      'messageType': messageType
    };
  }
}
