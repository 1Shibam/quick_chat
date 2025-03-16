import 'package:quick_chat/Exports/common_exports.dart';

@immutable
class ChatUserModel {
  final String userID;
  final String username;
  final String email;
  final String bio;
  final String dob;
  final String fullName;
  final bool isOnline;
  final String lastActive;
  final String gender;
  final String pushToken;
  final String createdAt;
  final String profileUrl;
  const ChatUserModel(
      {required this.userID,
      required this.username,
      required this.email,
      required this.bio,
      required this.dob,
      required this.fullName,
      required this.isOnline,
      required this.lastActive,
      required this.gender,
      required this.pushToken,
      required this.createdAt,
      required this.profileUrl});
  ChatUserModel copyWith(
      {String? userID,
      String? username,
      String? email,
      String? bio,
      String? dob,
      String? fullName,
      bool? isOnline,
      String? lastActive,
      String? gender,
      String? pushToken,
      String? createdAt,
      String? profileUrl}) {
    return ChatUserModel(
        userID: userID ?? this.userID,
        username: username ?? this.username,
        email: email ?? this.email,
        bio: bio ?? this.bio,
        dob: dob ?? this.dob,
        fullName: fullName ?? this.fullName,
        isOnline: isOnline ?? this.isOnline,
        lastActive: lastActive ?? this.lastActive,
        gender: gender ?? this.gender,
        pushToken: pushToken ?? this.pushToken,
        createdAt: createdAt ?? this.createdAt,
        profileUrl: profileUrl ?? this.profileUrl);
  }

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    return ChatUserModel(
        userID: json['user_id'],
        username: json['username'] ?? '',
        email: json['email'] ?? '',
        bio: json['bio'] ?? '',
        dob: json['dob'] ?? '',
        fullName: json['full_name'] ?? '',
        isOnline: json['is_online'] ?? false,
        lastActive: json['last_active'] ?? '',
        gender: json['gender'] ?? '',
        pushToken: json['push_token'] ?? '',
        createdAt: json['created_at'] ?? '',
        profileUrl: json['profile_url'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'bio': bio,
      'username': username,
      'user_id': userID,
      'created_at': createdAt,
      'email': email,
      'full_name': fullName,
      'gender': gender,
      'last_active': lastActive,
      'profile_url': profileUrl,
      'push_token': pushToken,
      'dob': dob,
      'is_online': isOnline
    };
  }
}
