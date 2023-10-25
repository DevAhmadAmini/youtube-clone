import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 22,
        width: 22,
        child: CircularProgressIndicator(
          color: Colors.pink,
          strokeWidth: 1.8,
        ),
      ),
    );
  }
}
