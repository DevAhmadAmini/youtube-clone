// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone/features/upload/models/short_video_model.dart';

class ShortVideoTile extends StatefulWidget {
  final ShortVideoModel shortVideo;
  const ShortVideoTile({
    Key? key,
    required this.shortVideo,
  }) : super(key: key);

  @override
  State<ShortVideoTile> createState() => _ShortVideoTileState();
}

class _ShortVideoTileState extends State<ShortVideoTile> {
  VideoPlayerController? shortController;

  @override
  void initState() {
    super.initState();
    shortController = VideoPlayerController.file(
      File(widget.shortVideo.video),
    )..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 3),
      child: Column(
        children: [
          shortController!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: 11 / 16,
                  child: GestureDetector(
                    onTap: () {
                      if (shortController!.value.isPlaying) {
                        shortController!.pause();
                      } else {
                        shortController!.play();
                      }
                    },
                    child: VideoPlayer(
                      shortController!,
                    ),
                  ),
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.shortVideo.caption,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat().add_yMMMd().format(
                        widget.shortVideo.datePublished,
                      ),
                  style: const TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
