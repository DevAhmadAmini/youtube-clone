// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';
import 'package:youtube_clone/cores/screens/show_error.dart';
import 'package:youtube_clone/features/upload/short_video/export_service.dart';
import 'package:youtube_clone/features/upload/short_video/widgets/cover_selection.dart';

class CoverSelectionPage extends StatefulWidget {
  final VideoEditorController controller;
  final double height;
  final File editedVideo;
  const CoverSelectionPage({
    Key? key,
    required this.controller,
    required this.height,
    required this.editedVideo,
  }) : super(key: key);

  @override
  State<CoverSelectionPage> createState() => _CoverSelectionPageState();
}

class _CoverSelectionPageState extends State<CoverSelectionPage> {
  final TextEditingController captionController = TextEditingController();
  File? cover;
  void exportCover() async {
    final config = CoverFFmpegVideoEditorConfig(widget.controller);
    final execute = await config.getExecuteConfig();
    if (execute == null) {
      showErrorSnackBar("Error on cover exportation initialization.", context);
      return;
    }
    await ExportService.runFFmpegCommand(
      execute,
      onError: (e, s) =>
          showErrorSnackBar("Error on cover exportation :(", context),
      onCompleted: (cover) {
        if (!mounted) return;
        this.cover = cover;
        log("$cover");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14, left: 3, right: 3),
          child: Column(
            children: [
              CoverViewer(controller: widget.controller),
              const Spacer(),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.82,
                height: 80,
                child: TextField(
                  controller: captionController,
                  decoration: const InputDecoration(
                    hintText: "Write a caption",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              CoverSelectionWidget(
                controller: widget.controller,
                height: widget.height,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6, right: 20),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(17),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        exportCover();
                      },
                      child: const Text(
                        "Upload",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
