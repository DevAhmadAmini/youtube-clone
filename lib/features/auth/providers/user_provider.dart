import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/data/repository/user_data_service.dart';
import '../data/model/user.dart';

final currentUserDataProvider = FutureProvider<UserModel>((ref) async {
  final UserModel user =
      await ref.read(userDataServiceProvider).retrieveCurrentUserData();
  return user;
});

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
