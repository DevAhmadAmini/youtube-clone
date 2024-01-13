// ignore_for_file: public_member_api_docs, sort_constructors_first

class ShortVideoModel {
  final String caption;
  final String video;
  final DateTime datePublished;
  final String userId;

  ShortVideoModel({
    required this.caption,
    required this.video,
    required this.datePublished,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'caption': caption,
      'video': video,
      'datePublished': datePublished.millisecondsSinceEpoch,
      "userId": userId,
    };
  }

  factory ShortVideoModel.fromMap(Map<String, dynamic> map) {
    return ShortVideoModel(
      caption: map['caption'] as String,
      video: map['video'] as String,
      userId: map["userId"] as String,
      datePublished:
          DateTime.fromMillisecondsSinceEpoch(map['datePublished'] as int),
    );
  }
}
