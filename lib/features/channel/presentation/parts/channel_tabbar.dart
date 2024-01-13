import 'package:flutter/material.dart';

class ChannelTabBar extends StatelessWidget {
  const ChannelTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      isScrollable: true,
      labelColor: Color(0xff5F5F5F),
      labelStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      indicatorColor: Colors.black,
      indicatorPadding: EdgeInsets.only(top: 12),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: [
        Text("Home"),
        Text("Videos"),
        Text("Shorts"),
        Text("Playlists"),
        Text("Community"),
        Text("Channels"),
        Text("about"),
      ],
    );
  }
}
