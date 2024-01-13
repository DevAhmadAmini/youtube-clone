// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/data/model/user.dart';
import 'package:youtube_clone/features/upload/models/video_model.dart';
import 'package:uuid/uuid.dart';

final videoRepositoryProvider = Provider(
  (ref) => VideoRepository(firestore: FirebaseFirestore.instance),
);

class VideoRepository {
  final FirebaseFirestore firestore;
  VideoRepository({
    required this.firestore,
  });
  uploadVideoFirestore({
    required String videoUrl,
    required String tumbnail,
    required String title,
    required int views,
    required DateTime datePublished,
    required UserModel user,
  }) async {
    String videoId = const Uuid().v4();
    VideoModel video = VideoModel(
      videoUrl: videoUrl,
      tumbnail: tumbnail,
      title: title,
      datePublished: datePublished,
      views: views,
      videoId: videoId,
      user: user,
      likes: [],
    );

    await firestore.collection("videos").doc(videoId).set(
          video.toMap(),
        );
  }

  likeVideo(videoId, ownUserId, currentUserId, List likesList) async {
    if (!likesList.contains(currentUserId)) {
      await firestore.collection("videos").doc(videoId).update({
        "likes": FieldValue.arrayUnion([currentUserId])
      });
    }
    if (likesList.contains(currentUserId)) {
      await firestore.collection("videos").doc(videoId).update({
        "likes": FieldValue.arrayRemove([currentUserId])
      });
    }
  }
}
