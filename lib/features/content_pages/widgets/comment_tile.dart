// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:youtube_clone/features/upload/models/comment_model.dart';

class CommentTile extends StatelessWidget {
  final CommentModel comment;
  const CommentTile({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 11, bottom: 5, left: 9, right: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      CachedNetworkImageProvider(comment.user.profilePic!),
                  radius: 14.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 8),
                child: Text(
                  comment.user.displayName!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                DateFormat().add_yMMMEd().format(comment.date),
              ),
              const Spacer(),
              const Icon(Icons.more_vert),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.096),
            child: Text(
              comment.commentText,
            ),
          ),
        ],
      ),
    );
  }
}
