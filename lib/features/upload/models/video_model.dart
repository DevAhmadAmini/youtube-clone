// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  final String videoUrl;
  final String tumbnail;
  final String title;
  final DateTime datePublished;
  final int views;
  final String videoId;
  final String userId;
  final List likes;
  final String type;
  VideoModel({
    required this.videoUrl,
    required this.tumbnail,
    required this.title,
    required this.datePublished,
    required this.views,
    required this.videoId,
    required this.userId,
    required this.likes,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'videoUrl': videoUrl,
      'tumbnail': tumbnail,
      "type": type,
      'title': title,
      'datePublished': datePublished.millisecondsSinceEpoch,
      'views': views,
      'videoId': videoId,
      'user': userId,
      'likes': likes,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      videoUrl: map['videoUrl'] as String,
      tumbnail: map['tumbnail'] as String,
      type: map["type"] as String,
      title: map['title'] as String,
      datePublished: map['datePublished'] is Timestamp
          ? (map['datePublished'] as Timestamp).toDate()
          : DateTime.fromMillisecondsSinceEpoch(map['datePublished'] as int),
      views: map['views'] as int,
      videoId: map['videoId'] as String,
      userId: map["userId"] as String,
      likes: List.from(
        (map['likes'] as List),
      ),
    );
  }
}
  // datePublished:
  //         DateTime.fromMillisecondsSinceEpoch(map['datePublished'] as int),