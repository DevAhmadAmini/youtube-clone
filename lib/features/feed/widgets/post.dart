// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:youtube_clone/cores/widgets/custom_button.dart';
import 'package:youtube_clone/features/feed/widgets/video.dart';
import 'package:youtube_clone/features/upload/models/video_model.dart';

class Post extends StatefulWidget {
  final VideoModel video;
  const Post({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Video(video: widget.video),
            ),
          );
        },
        child: Column(
          children: [
            // here show the image
            CachedNetworkImage(
              imageUrl: widget.video.tumbnail,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      widget.video.title,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  CustomButton(
                    iconData: Icons.more_vert,
                    onTap: () {},
                    haveColor: false,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.sizeOf(context).width * 0.145,
              ),
              child: Row(
                children: [
                  Text(
                    widget.video.user.displayName,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff5F5F5F),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      "${widget.video.views}",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xff5F5F5F),
                      ),
                    ),
                  ),
                  const Text(
                    "2 Years ago",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff5F5F5F),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
