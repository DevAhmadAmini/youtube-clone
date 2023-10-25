import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider =
    StreamProvider.family<QuerySnapshot, String>((ref, text) {
  return FirebaseFirestore.instance
      .collection("users")
      .where("userId", isGreaterThanOrEqualTo: text)
      .snapshots();
});
