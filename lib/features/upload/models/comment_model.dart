// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:youtube_clone/features/auth/data/model/user.dart';

class CommentModel {
  final UserModel user;
  final String commentId;
  final String videoId;
  String commentText = "";
  final DateTime date;
  CommentModel({
    required this.user,
    required this.commentId,
    required this.videoId,
    required this.commentText,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'commentId': commentId,
      'videoId': videoId,
      'commentText': commentText,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      commentId: map['commentId'] as String,
      videoId: map['videoId'] as String,
      commentText: map['commentText'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }
}
