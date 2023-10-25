import 'package:flutter/material.dart';

void showErrorSnackBar(String message,context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
