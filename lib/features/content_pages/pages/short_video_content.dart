import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/widgets/loader.dart';
import 'package:youtube_clone/features/content_pages/widgets/short_video_tile.dart';
import 'package:youtube_clone/features/upload/models/short_video_model.dart';

class ShortVideoContent extends StatefulWidget {
  const ShortVideoContent({super.key});

  @override
  State<ShortVideoContent> createState() => _ShortVideoContentState();
}

class _ShortVideoContentState extends State<ShortVideoContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("shorts").snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const ErrorPage();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final shortVideoMap = snapshot.data!.docs[index];

              final shortVideoModel =
                  ShortVideoModel.fromMap(shortVideoMap.data()!);
              return ShortVideoTile(shortVideo: shortVideoModel);
            },
          );
        },
      ),
    );
  }
}
