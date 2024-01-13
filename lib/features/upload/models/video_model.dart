// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:youtube_clone/features/auth/data/model/user.dart';

class VideoModel {
  final String videoUrl;
  final String tumbnail;
  final String title;
  final DateTime datePublished;
  final int views;
  final String videoId;
  final UserModel user;
  final List likes;
  VideoModel({
    required this.videoUrl,
    required this.tumbnail,
    required this.title,
    required this.datePublished,
    required this.views,
    required this.videoId,
    required this.user,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'videoUrl': videoUrl,
      'tumbnail': tumbnail,
      'title': title,
      'datePublished': datePublished.millisecondsSinceEpoch,
      'views': views,
      'videoId': videoId,
      'user': user.toMap(),
      'likes': likes,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      videoUrl: map['videoUrl'] as String,
      tumbnail: map['tumbnail'] as String,
      title: map['title'] as String,
      datePublished:
          DateTime.fromMillisecondsSinceEpoch(map['datePublished'] as int),
      views: map['views'] as int,
      videoId: map['videoId'] as String,
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      likes: List.from(
        (map['likes'] as List),
      ),
    );
  }
}
