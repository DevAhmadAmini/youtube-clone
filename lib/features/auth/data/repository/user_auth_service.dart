// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_comparison
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userAuthServiceProvider = Provider(
  (ref) => AuthService(
    googleSignIn: GoogleSignIn(),
  ),
);

class AuthService {
  GoogleSignIn googleSignIn;
  AuthService({
    required this.googleSignIn,
  });

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? user = await googleSignIn.signIn();
      final googleAuth = await user!.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await firebaseAuth.signInWithCredential(credential);

      return user;
    } catch (error) {
      log(error.toString());
    }
  }
}
