// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_clone/cores/methods.dart';
import 'package:youtube_clone/features/auth/data/repository/user_data_service.dart';
import 'package:youtube_clone/features/content_pages/pages/feed_screen.dart';
import 'package:youtube_clone/features/upload/long_video/video_repository.dart';

class VideoDetailScreen extends ConsumerStatefulWidget {
  final File? video;
  const VideoDetailScreen({
    super.key,
    required this.video,
  });

  @override
  ConsumerState<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends ConsumerState<VideoDetailScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isThumbnailSelected = false;
  final DateTime datePublished = DateTime.now();
  String randomNumber = const Uuid().v4();
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Details"),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Enter the Title",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  hintText: "Enter the Title",
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter the description",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 4),
              TextField(
                maxLines: 6,
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: "Enter the Description",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      // select thumbnail
                      image = await pickImage(ImageSource.gallery);

                      isThumbnailSelected = true;
                      setState(() {});
                    },
                    child: const Text(
                      "Select Thumbnail",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              image != null
                  ? Image.file(
                      image!,
                      cacheHeight: 160,
                      cacheWidth: 400,
                    )
                  : const SizedBox(),
              const Spacer(),
              isThumbnailSelected
                  ? Container(
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          // publish video to firestore
                          final currentUserData = await ref
                              .watch(userDataServiceProvider)
                              .retrieveCurrentUserData();

                          String videoUrl = await putFileOnStorage(
                            widget.video,
                            randomNumber,
                            "video",
                          );
                          String thumbnailUrl = await putFileOnStorage(
                            image!,
                            randomNumber,
                            "image",
                          );
                          ref
                              .watch(videoRepositoryProvider)
                              .uploadVideoFirestore(
                                user: currentUserData,
                                datePublished: datePublished,
                                videoUrl: videoUrl,
                                views: 0,
                                tumbnail: thumbnailUrl,
                                title: titleController.text,
                              );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FeedScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Publish Video",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
