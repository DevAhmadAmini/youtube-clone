// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:youtube_clone/features/auth/data/repository/user_auth_service.dart';
import 'package:youtube_clone/features/auth/data/repository/user_data_service.dart';
import 'package:youtube_clone/features/auth/pages/username_page.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  // sign in with google
  loginWithGoogle() async {
    final GoogleSignInAccount user =
        await ref.watch(userAuthServiceProvider).signInWithGoogle();

    // compare the signed in email with all available emails in database

    final snapshots =
        await FirebaseFirestore.instance.collection("users").get();
    log("signed in with google");
    final docs = snapshots.docs;
    final email = user.email;
    for (var doc in docs) {
      final eachEmail = doc.data()["email"];
      if (email == eachEmail) {
        log("same emails");
        // if email is available directly go to homepage
      } else if (email != eachEmail) {
        log("different emails");
        // if not we need to provide username and add other user data to database
        // await Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => UsernamePage(
        //       user: user,
        //     ),
        //   ),
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 25),
                child: Image.asset(
                  "assets/images/youtube-signin.jpg",
                  height: 150,
                ),
              ),
              const Text(
                "WELCOME TO YOUTUBE",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 55),
                child: GestureDetector(
                  onTap: () async {
                    await loginWithGoogle();
                  },
                  child: Image.asset(
                    "assets/images/signinwithgoogle.png",
                    height: 60,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
