// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';
import 'package:youtube_clone/cores/screens/show_error.dart';
import 'package:youtube_clone/cores/widgets/loader.dart';
import 'package:youtube_clone/features/upload/short_video/pages/short_video_detail_page.dart';
import 'package:youtube_clone/features/upload/short_video/export_service.dart';
import 'package:youtube_clone/features/upload/short_video/widgets/trim_slinder.dart';

class ShortVideoScreen extends StatefulWidget {
  final File? video;
  const ShortVideoScreen({
    Key? key,
    this.video,
  }) : super(key: key);

  @override
  State<ShortVideoScreen> createState() => _ShortVideoScreenState();
}

class _ShortVideoScreenState extends State<ShortVideoScreen> {
  VideoEditorController? editorController;
  final _exportingProgress = ValueNotifier<double>(0.0);
  final _isExporting = ValueNotifier<bool>(false);
  bool exportingDone = false;
  final double height = 45;

  int? shortDuration;
  @override
  void initState() {
    super.initState();

    editorController = VideoEditorController.file(
      widget.video!,
      maxDuration: const Duration(seconds: 60),
      minDuration: const Duration(seconds: 3),
    );

    editorController!.initialize(aspectRatio: 3 / 3.35).then((value) {
      setState(() {});
    });
  }

  Future<void> exportVideo() async {
    _exportingProgress.value = 0;
    _isExporting.value = true;
    final config = VideoFFmpegVideoEditorConfig(editorController!);

    await ExportService.runFFmpegCommand(
      await config.getExecuteConfig(),
      onProgress: (stats) {
        _exportingProgress.value =
            config.getFFmpegProgress(stats.getTime().toInt());
      },
      onError: (e, s) => showErrorSnackBar("Error on export video :(", context),
      onCompleted: (file) async {
        // this file is the short video we need
        _isExporting.value = false;
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShortVideoDetailPage(
              shortVideo: file,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    editorController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 2,
              bottom: 7,
              right: 9,
              left: 9,
            ),
            child: editorController!.initialized
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton.outlined(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          CircleAvatar(
                            foregroundColor: Colors.white,
                            radius: 19,
                            child: Text(
                              "${editorController!.trimmedDuration.inSeconds}s",
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      CropGridViewer.preview(
                        controller: editorController!,
                      ),
                      const SizedBox(height: 0),
                      const Spacer(),
                      MyTrimSlider(
                        controller: editorController!,
                        height: height,
                      ),
                      // shows while exporting
                      ValueListenableBuilder(
                        valueListenable: _isExporting,
                        builder: (_, bool export, Widget? child) =>
                            AnimatedSize(
                          duration: kThemeAnimationDuration,
                          child: export ? child : null,
                        ),
                        child: AlertDialog(
                          title: ValueListenableBuilder(
                            valueListenable: _exportingProgress,
                            builder: (_, double value, __) {
                              return Text(
                                "Exporting video ${(value * 100).ceil()}%",
                                style: const TextStyle(fontSize: 12),
                              );
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                await exportVideo();
                              },
                              child: const Text(
                                "DONE",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const Loader(),
          ),
        ),
      ),
    );
  }
}
