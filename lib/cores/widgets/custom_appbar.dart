// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.arrow_back_sharp,
          color: Colors.black,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.cast,
            color: Colors.black,
            size: 21,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 14, right: 7),
          child: Icon(
            Icons.search,
            color: Colors.black,
            size: 21,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.more_vert,
            color: Colors.black,
            size: 21,
          ),
        ),
        const SizedBox(width: 6)
      ],
    );
  }
}
