// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/features/upload/short_video/pages/short_video_page.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseStorage storage = FirebaseStorage.instance;

pickShortVideo(ImageSource imageSource, BuildContext context) async {
  XFile? xFile = await ImagePicker().pickVideo(
    source: imageSource,
  );
  File video = File(xFile!.path);
  if (video != null) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShortVideoScreen(
                  video: video,
                )));
  }
}

pickVideo(ImageSource imageSource) async {
  XFile? xFile = await ImagePicker().pickVideo(
    source: imageSource,
  );
  File video = File(xFile!.path);
  if (video != null) {
    return video;
  }
}

pickImage(ImageSource imageSource) async {
  XFile? xFile = await ImagePicker().pickImage(source: imageSource);
  File image = File(xFile!.path);
  if (image != null) {
    return image;
  }
}

putFileOnStorage(video, number, fileType) async {
  final ref = storage.ref().child("$fileType/$number");
  UploadTask upload = ref.putFile(video);
  TaskSnapshot snapshot = await upload;
  String videoUrl = await snapshot.ref.getDownloadURL();
  return videoUrl;
}
