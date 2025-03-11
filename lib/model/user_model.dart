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
  ChatUserModel(
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
/*
bio
"i love chai"
created_at
9 March 2025 at 00:00:00 UTC+5:30
dob
"24-06-2002"
email
"hehe.shibam@gmail.com"

full_name
"Shivam Jaiswal"
(string)


gender
"male"
(string)


is_online
false
(Boolean)


last_active
""
(string)


profile_url
""
(string)


push_token
""
(string)


user_id
"U6gWKZoZ2Bq4BUwQILfK"
(string)


username
"shivam"
 */