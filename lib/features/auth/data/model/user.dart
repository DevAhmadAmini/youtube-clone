// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String? displayName;
  final String? username;
  final String? email;
  final String? profilePic;
  final List? suberscribers;
  final int? videos;
  final int? views;
  String? userId;
  final String? description;

  UserModel({
    this.displayName,
    this.username,
    this.email,
    this.profilePic,
    this.suberscribers,
    this.videos,
    this.views,
    this.userId,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'username': username,
      'email': email,
      'profilePic': profilePic,
      'suberscribers':
          suberscribers?.map((subscriber) => subscriber.toMap()).toList(),
      'videos': videos,
      'views': views,
      'userId': userId,
      'description': description,
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
      suberscribers: map['suberscribers'] != null
          ? List<Map<String, dynamic>>.from(
                  map['suberscribers'] as List<dynamic>)
              .map((subscriber) => Map<String, dynamic>.from(subscriber))
              .toList() // Deserialize each subscriber
          : null,
      videos: map['videos'] != null ? map['videos'] as int : null,
      views: map['views'] != null ? map['views'] as int : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }
}
