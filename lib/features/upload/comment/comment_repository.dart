// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_clone/features/auth/data/model/user.dart';
import 'package:youtube_clone/features/upload/models/comment_model.dart';

final commentRepositoryProvider = Provider(
  (ref) => CommentRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class CommentRepository {
  FirebaseFirestore firestore;
  FirebaseAuth auth;
  CommentRepository({
    required this.firestore,
    required this.auth,
  });

  addCommentOnFirestore({
    required UserModel user,
    required String videoId,
    required String commentText,
    required DateTime date,
  }) async {
    String commentId = const Uuid().v4();
    final comment = CommentModel(
      user: user,
      commentId: commentId,
      videoId: videoId,
      commentText: commentText,
      date: date,
    );
    await firestore.collection("comments").doc(commentId).set(comment.toMap());
  }

  Future retrieveCommentRepository(String videoId) async {
    final commentMap = await firestore
        .collection("comments")
        .where("videoId", isEqualTo: videoId)
        .get();
    final docs = commentMap.docs;
    return docs;
  }
}
