// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, unused_import

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/widgets/loader.dart';
import 'package:youtube_clone/features/content_pages/widgets/post.dart';
import 'package:youtube_clone/features/upload/models/video_model.dart';
import '../../auth/providers/user_provider.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  Future<void> _handleRefresh() async {
    await Future.delayed(
      const Duration(seconds: 1),
      () => const Text(
        "Refreshed",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("videos")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text("something went wrong");
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Loader();
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final videoMap = snapshot.data!.docs[index];
                        final videoData = VideoModel.fromMap(videoMap.data());
                        return Post(
                          video: videoData,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
