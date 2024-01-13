// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:youtube_clone/features/content_pages/widgets/create_bottom_sheet.dart';

class BottomNavigation extends StatefulWidget {
  final Function(int index) onPressed;
  const BottomNavigation({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black87,
      unselectedIconTheme: const IconThemeData(color: Colors.grey),
      unselectedLabelStyle: const TextStyle(
        color: Colors.black12,
        fontWeight: FontWeight.w300,
      ),
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
      ),
      selectedFontSize: 13,
      unselectedFontSize: 13,
      onTap: (index) {
        if (index != 2) {
          widget.onPressed(index);
          currentIndex = index;
          setState(() {});
        } else {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const CreateBottomSheet();
            },
          );
        }
      },
      backgroundColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          backgroundColor: Colors.black,
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.short_text),
          label: "Shorts",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add, size: 30),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "subscription",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Library",
        ),
      ],
    );
  }
}
