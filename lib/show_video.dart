// import 'dart:io';
// import 'package:cached_video_player/cached_video_player.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:youtube_clone/cores/methods.dart';

// class ShowVideoScreen extends StatefulWidget {
//   const ShowVideoScreen({super.key});

//   @override
//   State<ShowVideoScreen> createState() => _ShowVideoScreenState();
// }

// class _ShowVideoScreenState extends State<ShowVideoScreen> {
//   File? video;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   video = showVidoeScreen();
//   //   // videoPlayerController = CachedVideoPlayerController.file(video!)
//   //     ..initialize().then((value) {
//   //       setState(() {});
//   //     });
//   // }

//   showVidoeScreen() async {
//     await pickVideo(ImageSource.gallery, context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           video != null
//               ? GestureDetector(
//                   onTap: () {
//                     videoPlayerController!.play();
//                   },
//                   child: CachedVideoPlayer(videoPlayerController!))
//               : Container(),
//           TextButton(
//             onPressed: () async {
//               await pickVideo(ImageSource.gallery, context);
//             },
//             child: const Text("Upload Video"),
//           ),
//         ],
//       ),
//     );
//   }
// }
