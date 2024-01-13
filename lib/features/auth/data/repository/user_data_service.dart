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
    String displayName,
    String email,
    String userPhotoUrl,
    String userId,
    String username,
  ) async {
    String photoUrl =
        "https://img.freepik.com/free-photo/gray-painted-background_53876-94041.jpg?w=1060&t=st=1698410195~exp=1698410795~hmac=4aac5ab6f61188883d55610b76e3fb224db3b6bdf744ef5bd99f4bcae524f43a";

    if (userPhotoUrl != null) {
      photoUrl = userPhotoUrl;
    }
    UserModel userInfo = UserModel(
      displayName: displayName,
      username: username,
      email: email,
      profilePic: photoUrl,
      suberscribers: [],
      videos: 0,
      views: 3,
      userId: userId,
      description: "",
    );
    await firestore.collection("users").doc(userId).set(
          userInfo.toMap(),
        );
  }

  // Future retrieveUserData() async {
  //   final userDataMap =
  //       await FirebaseFirestore.instance.collection("users").get();
  // }

  Future<UserModel> retrieveCurrentUserData() async {
    final userDataMap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    final UserModel userModel = UserModel(
      description: userDataMap["description"],
      displayName: userDataMap["displayName"],
      email: userDataMap["email"],
      profilePic: userDataMap["profilePic"],
      suberscribers: userDataMap["suberscribers"],
      userId: userDataMap["userId"],
      username: userDataMap["username"],
      videos: userDataMap["videos"],
      views: userDataMap["views"],
    );
    return userModel;
  }

  retrieveCurrentUserData2() async {
    final userDataMap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (userDataMap != null) {
      UserModel userModel = UserModel.fromMap(userDataMap.data()!);

      return userModel;
    }
  }
}
