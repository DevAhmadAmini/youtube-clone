// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SettingsDialog extends StatelessWidget {
  final String identifier;
  final VoidCallback onSave;
  const SettingsDialog({
    Key? key,
    required this.identifier,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(top: 0),
      title: Text(
        identifier,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.blue,
        ),
      ),
      content: const TextField(),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: onSave,
          child: const Text("Save"),
        ),
      ],
    );
  }
}
