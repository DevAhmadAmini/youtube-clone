import 'package:flutter/material.dart';
import 'package:youtube_clone/features/content_pages/pages/short_video_content.dart';
import 'package:youtube_clone/features/search/search_screen.dart';
import 'content_pages/pages/feed_screen.dart';

List pages = [
  const FeedScreen(),
  const ShortVideoContent(),
  const SearchScreen(),
  const Center(
    child: Text("Subscribtion"),
  ),
  const Center(
    child: Text("Library"),
  ),
];
