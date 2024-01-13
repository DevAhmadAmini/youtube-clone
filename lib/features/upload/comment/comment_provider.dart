import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/upload/comment/comment_repository.dart';

final commentProvider = FutureProvider.family<
    List<QueryDocumentSnapshot<Map<String, dynamic>>>,
    String>((ref, videoId) async {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> comments = await ref
      .read(commentRepositoryProvider)
      .retrieveCommentRepository(videoId);

  return comments;
});
