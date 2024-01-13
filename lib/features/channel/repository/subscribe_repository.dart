// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subscribeChannelProvider = Provider(
  (ref) => SubscribeChannels(firestore: FirebaseFirestore.instance),
);

class SubscribeChannels {
  FirebaseFirestore firestore;
  SubscribeChannels({
    required this.firestore,
  });

  subscribeUser({
    required String? subscribedUserId,
    required String? currentUserId,
    required List? userSubscriptions,
    // required String? userVideoId,
  }) async {
    print(userSubscriptions);
    if (!userSubscriptions!.contains(currentUserId)) {
      print("current user id $currentUserId");
      print("subscribed user Id $subscribedUserId");
      print("user subscriptions: $userSubscriptions");
      // print("subscribe button clicked");
      await firestore.collection("users").doc(subscribedUserId).update({
        "subscriptions": FieldValue.arrayUnion([currentUserId])
      });
    } else if (userSubscriptions.contains(currentUserId)) {
      print("current user id $currentUserId");
      print("subscribed user Id $subscribedUserId");
      print("user subscriptions: $userSubscriptions");
      print("subscribe button clicked");
      await firestore.collection("users").doc(subscribedUserId).update({
        "subscriptions": FieldValue.arrayRemove([currentUserId])
      });
    }
  }
}
