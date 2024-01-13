// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String? displayName;
  final String? username;
  final String? email;
  final String? profilePic;
  final List? subscriptions;
  final int? videos;
  String? userId;
  final String? description;
  final String? type;

  UserModel({
    this.displayName,
    this.username,
    this.email,
    this.profilePic,
    this.subscriptions,
    this.videos,
    this.userId,
    this.description,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'username': username,
      'email': email,
      'profilePic': profilePic,
      'subscriptions': subscriptions,
      'videos': videos,
      'userId': userId,
      'description': description,
      'type': type,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      profilePic:
          map['profilePic'] != null ? map['profilePic'] as String : null,
      subscriptions: List<String>.from(
        (map["subscriptions"] ?? []),
      ),
      videos: map['videos'] != null ? map['videos'] as int : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
    );
  }
}
