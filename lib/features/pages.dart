import 'package:flutter/material.dart';
import 'package:youtube_clone/features/channel/screens/my_channel_settings.dart';
import 'package:youtube_clone/features/search/search_screen.dart';
import 'feed/pages/feed_screen.dart';

List pages = [
  const FeedScreen(),
  const ChannelSettings(),
  const SearchScreen(),
  const Center(
    child: Text("Subscriptions"),
  ),
  const Center(
    child: Text("Library"),
  ),
];
