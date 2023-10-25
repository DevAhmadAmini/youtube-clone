class UserModel {
  final String displayName;
  final String username;
  final String email;
  final String profilePic;
  final int suberscribers;
  final int videos;
  final int views;
  String userId;

  UserModel({
    required this.displayName,
    required this.username,
    required this.email,
    required this.profilePic,
    required this.suberscribers,
    required this.videos,
    required this.views,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'username': username,
      'email': email,
      'profilePic': profilePic,
      'suberscribers': suberscribers,
      'videos': videos,
      'views': views,
      'userId': userId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      displayName: map['displayName'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      profilePic: map['profilePic'] as String,
      suberscribers: map['suberscribers'] as int,
      videos: map['videos'] as int,
      views: map['views'] as int,
      userId: map['userId'] as String,
    );
  }
}
