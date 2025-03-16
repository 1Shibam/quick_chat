import 'package:quick_chat/Exports/common_exports.dart';

@immutable
class MessageModel {
  final String senderID;
  final String receiverID;
  final String sentTime;
  final String readTime;
  final String message;
  final MessageType messageType; // Use MessageType instead of Type

  const MessageModel({
    required this.senderID,
    required this.receiverID,
    required this.sentTime,
    required this.readTime,
    required this.message,
    required this.messageType,
  });

  MessageModel copyWith({
    String? senderID,
    String? receiverID,
    String? sentTime,
    String? readTime,
    String? message,
    MessageType? messageType, // Fix: Use MessageType instead of String
  }) {
    return MessageModel(
      senderID: senderID ?? this.senderID,
      receiverID: receiverID ?? this.receiverID,
      sentTime: sentTime ?? this.sentTime,
      readTime: readTime ?? this.readTime,
      message: message ?? this.message,
      messageType: messageType ?? this.messageType,
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderID: json['senderID'],
      receiverID: json['receiverID'],
      sentTime: json['sentTime'],
      readTime: json['readTime'],
      message: json['message'],
      messageType: MessageTypeExtension.fromString(json['messageType']), // Convert String to Enum
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderID': senderID,
      'receiverID': receiverID,
      'sentTime': sentTime,
      'readTime': readTime,
      'message': message,
      'messageType': messageType.name, // Convert Enum to String
    };
  }
}

// Define an Enum for message type
enum MessageType { text, image, audio }

// Extension for converting String to Enum safely
extension MessageTypeExtension on MessageType {
  static MessageType fromString(String? type) {
    switch (type) {
      case 'image':
        return MessageType.image;
      case 'audio':
        return MessageType.audio;
      default:
        return MessageType.text; // Default case is 'text'
    }
  }
}
