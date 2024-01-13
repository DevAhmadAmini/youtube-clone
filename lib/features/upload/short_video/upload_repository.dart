// ignore_for_file: public_member_api_docs, sort_constructors_first
//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_clone/features/upload/models/short_video_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final shortVideoRepository = Provider(
  (ref) => ShortVideoRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class ShortVideoRepository {
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  ShortVideoRepository({
    required this.auth,
    required this.firestore,
  });

  String shortVideoId = const Uuid().v4();
  uploadShortToFirestore({
    required String? shortVideoCaption,
    required String? video,
    required DateTime currentDate,
  }) async {
    ShortVideoModel shortVideo = ShortVideoModel(
      caption: shortVideoCaption!,
      video: video!,
      datePublished: currentDate,
      userId: auth.currentUser!.uid,
    );
    await firestore
        .collection("shorts")
        .doc(shortVideoId)
        .set(shortVideo.toMap());
  }
}
