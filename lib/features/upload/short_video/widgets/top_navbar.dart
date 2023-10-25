// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';

class TopNavBar extends StatelessWidget {
  final VoidCallback onExport;
  final double height;
  final VideoEditorController controller;

  const TopNavBar({
    Key? key,
    required this.onExport,
    required this.height,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_outlined),
                tooltip: 'Leave editor',
              ),
            ),
            const VerticalDivider(endIndent: 22, indent: 22),
            Expanded(
              child: IconButton(
                color: Colors.black,
                onPressed: onExport,
                icon: const Icon(Icons.import_export),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
