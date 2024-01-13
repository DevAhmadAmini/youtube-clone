// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/widgets/loader.dart';
import 'package:youtube_clone/features/auth/data/model/user.dart';
import 'package:youtube_clone/features/auth/providers/user_provider.dart';
import 'package:youtube_clone/features/content_pages/widgets/comment_tile.dart';
import 'package:youtube_clone/features/upload/comment/comment_repository.dart';
import 'package:youtube_clone/features/upload/comment/provider.dart';
import 'package:youtube_clone/features/upload/models/comment_model.dart';

class CommentSheet extends StatefulWidget {
  final UserModel user;
  final String videoId;

  CommentSheet({
    required this.user,
    required this.videoId,
  });

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final TextEditingController commentController = TextEditingController();
  String commentText = "";

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final AsyncValue<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
            comments = ref.watch(commentProvider(widget.videoId));
        return comments.when(
          data: (data) {
            return Column(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(left: 11, right: 6, bottom: 20, top: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Comments",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.close,
                        size: 26,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xffE5E5E5),
                    boxShadow: [
                      BoxShadow(blurRadius: 0.0000001),
                    ],
                  ),
                  child: const Text(
                    "Remember to keep comments respectful and to follow our community and guideline",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 122, 117, 117),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final commentMap = data[index].data();
                      CommentModel comment = CommentModel.fromMap(commentMap);
                      return CommentTile(
                        comment: comment,
                      );
                    },
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 17,
                      ),
                      const SizedBox(width: 13),
                      SizedBox(
                        width: 310,
                        child: TextField(
                          onSubmitted: (value) {
                            commentText = value;
                          },
                          controller: commentController,
                          decoration: const InputDecoration(
                            fillColor: Color(0xffF0F0F0),
                            hintText: "Add a comment...",
                            hintStyle: TextStyle(fontSize: 14),
                            border: InputBorder.none,
                            filled: true,
                          ),
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          return ref.watch(currentUserDataProvider).when(
                                data: (data) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(commentRepositoryProvider)
                                            .addCommentOnFirestore(
                                              user: data,
                                              videoId: widget.videoId,
                                              commentText:
                                                  commentController.text,
                                              date: DateTime.now(),
                                            );
                                      },
                                      child: const Icon(
                                        Icons.send,
                                        size: 29,
                                        color: Colors.green,
                                      ),
                                    ),
                                  );
                                },
                                error: (error, stackTrace) => const ErrorPage(),
                                loading: () => const Loader(),
                              );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) => const ErrorPage(),
          loading: () => const Loader(),
        );
      },
    );
  }
}
