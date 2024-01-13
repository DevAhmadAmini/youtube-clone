// ignore_for_file: public_member_api_docs, sort_constructors_first

class CommentModel {
  final String displayName;
  final String profilePic;
  final String commentId;
  final String videoId;
  String commentText = "";
  final DateTime date;
  CommentModel({
    required this.commentId,
    required this.videoId,
    required this.commentText,
    required this.date,
    required this.displayName,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'profilePic': profilePic,
      'commentId': commentId,
      'videoId': videoId,
      'commentText': commentText,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      displayName: map['displayName'] as String,
      profilePic: map['profilePic'] as String,
      commentId: map['commentId'] as String,
      videoId: map['videoId'] as String,
      commentText: map['commentText'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }
}
