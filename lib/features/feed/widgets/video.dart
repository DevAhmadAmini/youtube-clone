// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone/cores/colors.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/cores/widgets/loader.dart';
import 'package:youtube_clone/features/feed/widgets/post.dart';
import 'package:youtube_clone/features/upload/models/video_model.dart';

class Video extends StatefulWidget {
  final VideoModel video;
  const Video({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
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
    final currentMinute = videoPlayerController!.value.position.inMinutes;
    final currentSecond = videoPlayerController!.value.position.inSeconds;
    return Scaffold(
      appBar: AppBar(
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
                                left: 160,
                                top: 86,
                                child: GestureDetector(
                                  onTap: toggleVideoPlayer,
                                  child: SizedBox(
                                    height: 50,
                                    child: isPlaying
                                        ? Image.asset("assets/icons/pause.png")
                                        : Image.asset(
                                            "assets/icons/play.png",
                                          ),
                                  ),
                                ),
                              )
                            : Container(),
                        showIcons
                            ? Positioned(
                                left: 63,
                                top: 92,
                                child: GestureDetector(
                                  onTap: () {
                                    goBack();
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    child: Image.asset(
                                      "assets/icons/backward.png",
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7.5),
                            child: Text(
                              "$currentMinute:$currentSecond / ${videoPlayerController!.value.duration.inMinutes}:${videoPlayerController!.value.duration.inSeconds}",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        showIcons
                            ? Positioned(
                                right: 58,
                                top: 92,
                                child: GestureDetector(
                                  onTap: () {
                                    goAhead();
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    child: Image.asset(
                                      "assets/icons/ahead.png",
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
              : const Center(
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
              child: Expanded(
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
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        "${widget.video.views}",
                        style: const TextStyle(
                          fontSize: 13.4,
                          color: Color(0xff5F5F5F),
                        ),
                      ),
                    ),
                    const Text(
                      "2 Years ago",
                      style: TextStyle(
                        fontSize: 13.4,
                        color: Color(0xff5F5F5F),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 9, right: 9),
              child: Expanded(
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: Text(
                        widget.video.user.displayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Text(
                      "8.76M",
                      style: TextStyle(fontSize: 11.5),
                    ),
                    const Spacer(),
                    FlatButton(
                      text: "Subscribe",
                      onPressed: () {},
                      colour: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9, top: 10.5, right: 9),
              child: Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: const BoxDecoration(
                          color: softBlueGreyBackGround,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              size: 15.5,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 9),
                              child: Text("323K"),
                            ),
                            Icon(
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
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9, top: 16, right: 9),
              child: Expanded(
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
                  child: const Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Comments",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text("9.1K"),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7.5),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.grey,
                            ),
                            SizedBox(width: 7),
                            SizedBox(
                              width: 280,
                              child: Text(
                                "I see health, wealth and happiness coming to the person reading this.",
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Post(
                  video: widget.video,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
