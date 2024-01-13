// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subscribeRepository = Provider(
  (ref) => SubscribeRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class SubscribeRepository {
  FirebaseFirestore firestore;
  FirebaseAuth auth;
  SubscribeRepository({
    required this.firestore,
    required this.auth,
  });

  subscribeChannel({
    required specificUserId,
    required currentUserId,
    required List subscribers,
    required String videoId,
  }) async {
    if (!subscribers.contains(currentUserId)) {
      // update the userModel inside video collection
      var video = await firestore.collection("videos").doc(videoId).get();
      var videoMap = video.data();
      Map<String, dynamic> userMap = videoMap!["user"];
      List subscribers = userMap["suberscribers"];

      subscribers.add(currentUserId);

      userMap.update(
        "suberscribers",
        (list) {
          list = subscribers;
        },
      );
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa$subscribers");
      // then update the userModel collection first
      await firestore.collection("users").doc(specificUserId).update(
        {
          "suberscribers": FieldValue.arrayUnion(
            [currentUserId],
          ),
        },
      );
    }

    if (subscribers.contains(currentUserId)) {
      await firestore.collection("users").doc(specificUserId).update(
        {
          "suberscribers": FieldValue.arrayRemove(
            [currentUserId],
          ),
        },
      );
    }
  }
}
