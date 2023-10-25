// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class ShortVideoModel {
  final String caption;
  final File video;
  final File tumbnail;
  ShortVideoModel({
    required this.caption,
    required this.video,
    required this.tumbnail,
  });

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'caption': caption,
  //     'video': video.toMap(),
  //     'tumbnail': tumbnail.toMap(),
  //   };
  // }

  // factory ShortVideoModel.fromMap(Map<String, dynamic> map) {
  //   return ShortVideoModel(
  //     caption: map['caption'] as String,
  //     video: File.fromMap(map['video'] as Map<String, dynamic>),
  //     tumbnail: File.fromMap(map['tumbnail'] as Map<String, dynamic>),
  //   );
  // }
}
