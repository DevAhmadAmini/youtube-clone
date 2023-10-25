// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/user.dart';

final userDataServiceProvider = Provider(
  (ref) => UserService(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class UserService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  UserService({
    required this.firestore,
    required this.auth,
  });

  addUserDataToFirestore(
      GoogleSignInAccount user, String userId, String username) async {
    UserModel userInfo = UserModel(
      displayName: user.displayName!,
      username: username,
      email: user.email,
      profilePic: user.photoUrl!,
      suberscribers: 0,
      videos: 0,
      views: 3,
      userId: userId,
    );
    await firestore.collection("users").doc(userId).set(
          userInfo.toMap(),
        );
  }

  Future<UserModel> retrieveUserData() async {
    final userDataMap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    UserModel userData = UserModel.fromMap(userDataMap.data()!);
    return userData;
  }
}
