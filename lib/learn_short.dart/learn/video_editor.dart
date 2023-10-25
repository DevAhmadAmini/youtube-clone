// // ignore_for_file: use_build_context_synchronously

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fraction/fraction.dart';
// import 'package:video_editor/video_editor.dart';
// import 'package:youtube_clone/cores/screens/show_error.dart';
// import 'package:youtube_clone/learn_short.dart/learn/export_service.dart';
// import 'package:youtube_clone/learn_short.dart/widgets/cover_selection.dart';
// import 'package:youtube_clone/learn_short.dart/widgets/top_navbar.dart';
// import 'package:youtube_clone/learn_short.dart/widgets/trim_slinder.dart';

// class VideoEditor extends StatefulWidget {
//   const VideoEditor({super.key, required this.file});
//   final File file;
//   @override
//   State<VideoEditor> createState() => _VideoEditorState();
// }

// class _VideoEditorState extends State<VideoEditor> {
//   late final VideoEditorController _controller = VideoEditorController.file(
//     widget.file,
//     minDuration: const Duration(seconds: 1),
//     maxDuration: const Duration(seconds: 10),
//   );

//   @override
//   void initState() {
//     super.initState();
//     _controller.preferredCropAspectRatio =
//         Fraction.fromString("9/16").toDouble();
//     _controller
//         .initialize(aspectRatio: 9 / 16)
//         .then((_) => setState(() {}))
//         .catchError((error) {
//       Navigator.pop(context);
//     }, test: (e) => e is VideoMinDurationError);
//   }

//   @override
//   void dispose() async {
//     _exportingProgress.dispose();
//     _isExporting.dispose();
//     _controller.dispose();
//     ExportService.dispose();
//     super.dispose();
//   }

// // method of exporting cover

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         backgroundColor: Colors.blue,
//         body: _controller.initialized
//             ? SafeArea(
//                 child: Stack(
//                   children: [
//                     Column(
//                       children: [
//                         TopNavBar(
//                           onExport: _exportVideo,
//                           height: height,
//                           controller: _controller,
//                         ),
//                         Expanded(
//                           child: DefaultTabController(
//                             length: 2,
//                             child: Column(
//                               children: [
//                                 Expanded(
//                                   child: TabBarView(
//                                     physics:
//                                         const NeverScrollableScrollPhysics(),
//                                     children: [
//                                       Stack(
//                                         alignment: Alignment.center,
//                                         children: [
//                                           CropGridViewer.preview(
//                                             controller: _controller,
//                                           ),
//                                           // Animated Builder
//                                         ],
//                                       ),
//                                       CoverViewer(controller: _controller),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 200,
//                                   margin: const EdgeInsets.only(top: 10),
//                                   child: Column(
//                                     children: [
//                                       const TabBar(
//                                         tabs: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Padding(
//                                                 padding: EdgeInsets.all(5),
//                                                 child: Icon(Icons.content_cut),
//                                               ),
//                                               Text('Trim')
//                                             ],
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Padding(
//                                                 padding: EdgeInsets.all(5),
//                                                 child: Icon(Icons.video_label),
//                                               ),
//                                               Text('Cover'),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       Expanded(
//                                         child: TabBarView(
//                                           physics:
//                                               const NeverScrollableScrollPhysics(),
//                                           children: [
//                                             CoverSelectionWidget(
//                                               controller: _controller,
//                                               height: height,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 // appears when exporting and show how much has gone

//                                 // value listenable builder
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//             : const Center(
//                 child: CircularProgressIndicator(),
//               ),
//       ),
//     );
//   }
// }
