// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';

class CoverSelectionWidget extends StatelessWidget {
  final double height;
  final VideoEditorController controller;
  const CoverSelectionWidget({
    Key? key,
    required this.height,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: CoverSelection(
            controller: controller,
            size: height + 10,
            quantity: 10,
            selectedCoverBuilder: (cover, size) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  cover,
                  Icon(
                    Icons.check_circle,
                    color: const CoverSelectionStyle().selectedBorderColor,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
