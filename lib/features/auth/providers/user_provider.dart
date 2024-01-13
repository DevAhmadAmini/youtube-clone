import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/repository/user_data_service.dart';
import '../model/user_model.dart';

final currentUserDataProvider = FutureProvider<UserModel>((ref) async {
  final UserModel user =
      await ref.read(userDataServiceProvider).retrieveCurrentUserData();
  return user;
});

// we use this for search feature

final allUsersDataProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  List<Map<String, dynamic>> usersList = [];
  final users = await FirebaseFirestore.instance.collection("users").get();
  final doc = users.docs;
  doc.forEach((element) {
    final item = element.data();
    usersList.add(item);
  });
  return usersList;
});

final anyUserDataProvider =
    FutureProvider.family<DocumentSnapshot<Map<String, dynamic>>, String>(
        (ref, userId) async {
  final DocumentSnapshot<Map<String, dynamic>> user =
      await ref.read(userDataServiceProvider).retrieveAnyUserData(userId);
  return user;
});
