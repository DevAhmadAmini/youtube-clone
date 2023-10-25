import 'package:flutter/material.dart';

class ChannelTabPages extends StatelessWidget {
  const ChannelTabPages({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: TabBarView(
        children: [
          Center(
            child: Text("Home"),
          ),
          Center(
            child: Text("videos"),
          ),
          Center(
            child: Text("shorts"),
          ),
          Center(
            child: Text("playlists"),
          ),
          Center(
            child: Text("community"),
          ),
          Center(
            child: Text("channels"),
          ),
          Center(
            child: Text("about"),
          ),
        ],
      ),
    );
  }
}
