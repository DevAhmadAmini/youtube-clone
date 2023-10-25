// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomItem extends StatelessWidget {
  final String itemText;
  final VoidCallback itemClicked;
  final IconData iconData;
  final bool? haveColor;
  const CustomItem({
    Key? key,
    required this.itemText,
    required this.itemClicked,
    required this.iconData,
    this.haveColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: itemClicked,
      child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 12),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
                color: haveColor! ? const Color(0xffF2F2F2) : null,
              ),
              child: TextButton(
                onPressed: itemClicked,
                child: Icon(
                  iconData,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                itemText,
                style: const TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
