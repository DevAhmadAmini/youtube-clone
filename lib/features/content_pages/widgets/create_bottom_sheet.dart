// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youtube_clone/cores/methods.dart';
import 'package:youtube_clone/cores/widgets/image_item.dart';
import 'package:youtube_clone/features/upload/long_video/video_detail_page.dart';

class CreateBottomSheet extends ConsumerStatefulWidget {
  const CreateBottomSheet({super.key});

  @override
  ConsumerState<CreateBottomSheet> createState() => _CreateBottomSheetState();
}

class _CreateBottomSheetState extends ConsumerState<CreateBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffFFFFFF),
      child: Padding(
        padding: const EdgeInsets.only(left: 7, top: 12),
        child: SizedBox(
          height: 270,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Create",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                height: 38,
                child: ImageItem(
                  itemText: "Create a Short",
                  itemClicked: () async {
                    await pickShortVideo(ImageSource.gallery, context);
                  },
                  imageName: "short-video.png",
                  haveColor: true,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 38,
                child: ImageItem(
                  itemText: "Upload a Video",
                  itemClicked: () async {
                    // just pick the video for now
                    File video = await pickVideo(ImageSource.gallery);

                    // Navigate to new page to complete details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return VideoDetailScreen(
                            video: video,
                          );
                        },
                      ),
                    );
                  },
                  imageName: "upload.png",
                  haveColor: true,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 38,
                child: ImageItem(
                  itemText: "Go Live",
                  itemClicked: () {},
                  imageName: "go-live.png",
                  haveColor: true,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 38,
                child: ImageItem(
                  itemText: "Create a post",
                  itemClicked: () {},
                  imageName: "create-post.png",
                  haveColor: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
