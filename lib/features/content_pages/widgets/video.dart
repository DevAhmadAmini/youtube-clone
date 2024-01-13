// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone/cores/colors.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/cores/widgets/loader.dart';
import 'package:youtube_clone/features/content_pages/pages/comment_sheet.dart';
import 'package:youtube_clone/features/content_pages/repository.dart';
import 'package:youtube_clone/features/content_pages/widgets/post.dart';
import 'package:youtube_clone/features/upload/comment/provider.dart';
import 'package:youtube_clone/features/upload/models/video_model.dart';
import 'package:youtube_clone/features/upload/long_video/video_repository.dart';

class Video extends ConsumerStatefulWidget {
  final VideoModel video;
  final String videoId;
  const Video({
    Key? key,
    required this.video,
    required this.videoId,
  }) : super(key: key);

  @override
  ConsumerState<Video> createState() => _VideoState();
}

class _VideoState extends ConsumerState<Video> {
  VideoPlayerController? videoPlayerController;

  bool isPlaying = false;
  bool showIcons = false;
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.videoUrl),
    )..initialize().then((value) {
        setState(() {});
      });
  }

  goBack() {
    Duration videoPosition = videoPlayerController!.value.position;
    videoPosition = videoPosition - const Duration(seconds: 1);
    videoPlayerController!.seekTo(videoPosition);
  }

  goAhead() {
    Duration videoPosition = videoPlayerController!.value.position;
    videoPosition = videoPosition + const Duration(seconds: 1);
    videoPlayerController!.seekTo(videoPosition);
  }

  toggleVideoPlayer() {
    if (videoPlayerController!.value.isPlaying) {
      videoPlayerController!.pause();
      isPlaying = false;
      setState(() {});
    } else {
      videoPlayerController!.play();
      isPlaying = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    log("${widget.video.user.suberscribers}");
    log("${widget.video.user.displayName}");
    log("${widget.video.user.email}");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(176),
          child: videoPlayerController!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: videoPlayerController!.value.aspectRatio,
                  child: GestureDetector(
                    onTap: () {
                      if (showIcons) {
                        showIcons = false;
                      } else {
                        showIcons = true;
                      }
                      setState(() {});
                    },
                    child: Stack(
                      children: [
                        VideoPlayer(videoPlayerController!),
                        // here we have the video player
                        showIcons
                            ? Positioned(
                                left: 182,
                                top: 87,
                                child: GestureDetector(
                                  onTap: toggleVideoPlayer,
                                  child: SizedBox(
                                    height: 50,
                                    child: isPlaying
                                        ? Image.asset(
                                            "assets/images/pause.png",
                                            color: Colors.white,
                                            height: 41,
                                            width: 41,
                                          )
                                        : Image.asset(
                                            "assets/images/play.png",
                                            height: 41,
                                            width: 41,
                                            color: Colors.white,
                                          ),
                                  ),
                                ),
                              )
                            : Container(),
                        showIcons
                            ? Positioned(
                                left: 72,
                                top: 92,
                                child: GestureDetector(
                                  onTap: () {
                                    goBack();
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    child: Image.asset(
                                      "assets/images/go_back_final.png",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),

                        showIcons
                            ? Positioned(
                                right: 75,
                                top: 93,
                                child: GestureDetector(
                                  onTap: () {
                                    goAhead();
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    child: Image.asset(
                                      "assets/images/go ahead final.png",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 7.5,
                            child: VideoProgressIndicator(
                              videoPlayerController!,
                              allowScrubbing: true,
                              colors: const VideoProgressColors(
                                playedColor: Colors.red,
                                bufferedColor: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.only(bottom: 88),
                  child: Loader(),
                ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 6, left: 14, top: 6, right: 9),
              child: Text(
                widget.video.title,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      "${widget.video.views} views",
                      style: const TextStyle(
                        fontSize: 13.4,
                        color: Color(0xff5F5F5F),
                      ),
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(widget.video.datePublished),
                    style: const TextStyle(
                      fontSize: 13.4,
                      color: Color(0xff5F5F5F),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 9, right: 9),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.grey,
                    backgroundImage: CachedNetworkImageProvider(
                      widget.video.user.profilePic!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: Text(
                      widget.video.user.displayName!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "${widget.video.user.suberscribers!.length}",
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  // subscribe the channel
                  SizedBox(
                    height: 35,
                    child: FlatButton(
                      text: "Subscribe",
                      onPressed: () {
                        // subscribe the channel which has posted the video
                        ref.read(subscribeRepository).subscribeChannel(
                              videoId: widget.videoId,
                              specificUserId: widget.video.user.userId,
                              currentUserId:
                                  FirebaseAuth.instance.currentUser!.uid,
                              subscribers: widget.video.user.suberscribers!,
                            );
                      },
                      colour: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9, top: 10.5, right: 9),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: const BoxDecoration(
                        color: softBlueGreyBackGround,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("liked");
                              ref.read(videoRepositoryProvider).likeVideo(
                                    widget.videoId,
                                    widget.video.user.userId,
                                    FirebaseAuth.instance.currentUser!.uid,
                                    widget.video.likes,
                                  );
                            },
                            child: const Icon(
                              Icons.thumb_up,
                              size: 15.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 9),
                            child: Text("${widget.video.likes.length}"),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.thumb_down,
                            size: 15.5,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 9, right: 9),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 3,
                        ),
                        decoration: const BoxDecoration(
                          color: softBlueGreyBackGround,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.analytics_outlined),
                            SizedBox(width: 6),
                            Text("Share"),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 3,
                      ),
                      decoration: const BoxDecoration(
                        color: softBlueGreyBackGround,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.analytics_outlined),
                          SizedBox(width: 6),
                          Text("Remix"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 9, right: 9),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 3,
                        ),
                        decoration: const BoxDecoration(
                          color: softBlueGreyBackGround,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.analytics_outlined),
                            SizedBox(width: 6),
                            Text("Download"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return CommentSheet(
                      user: widget.video.user,
                      videoId: widget.videoId,
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 9, top: 16, right: 9),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: const BoxDecoration(
                    color: softBlueGreyBackGround,
                    borderRadius: BorderRadius.all(
                      Radius.circular(11),
                    ),
                  ),
                  child: Consumer(
                    builder: (context, ref, child) {
                      AsyncValue<
                              List<
                                  QueryDocumentSnapshot<Map<String, dynamic>>>>?
                          comments = ref.watch(
                        commentProvider(widget.videoId),
                      );
                      // checking when value is null
                      if (comments!.value == null) {
                        return const SizedBox();
                      }
                      // then showing the actual value
                      if (comments.value!.isNotEmpty) {
                        return comments.when(
                          data: (data) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Comments",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text("${data.length}"),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7.5),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 14,
                                        backgroundColor: Colors.grey,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          widget.video.user.profilePic!,
                                        ),
                                      ),
                                      const SizedBox(width: 7),
                                      SizedBox(
                                        width: 280,
                                        child: Text(
                                          data[0].data()["commentText"],
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13.5,
                                          ),
                                        ),
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
                      }
                      return const Text("");
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("videos")
                  .where(
                    "videoId",
                    isNotEqualTo: widget.videoId,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const SizedBox();
                }
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data!.docs.isEmpty) {
                      return const SizedBox();
                    }
                    final data = snapshot.data!.docs[index].data();
                    final videoModel = VideoModel.fromMap(data);
                    return Post(
                      video: videoModel,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
