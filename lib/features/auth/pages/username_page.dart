// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/auth/data/repository/user_data_service.dart';
import 'package:youtube_clone/home_page.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final formKey = GlobalKey<FormState>();

class UsernamePage extends ConsumerStatefulWidget {
  final String displayName;
  final String photoUrl;
  final String email;
  UsernamePage({
    Key? key,
    required this.displayName,
    required this.photoUrl,
    required this.email,
  }) : super(key: key);

  @override
  ConsumerState<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends ConsumerState<UsernamePage> {
  final TextEditingController usernameController = TextEditingController();
  bool isValidate = true;

  validateUsername() async {
    final userMap = await FirebaseFirestore.instance.collection("users").get();
    final documents = userMap.docs;
    if (documents.isNotEmpty) {
      String eachUsername;
      for (var doc in documents) {
        eachUsername = doc.data()["username"];
        if (eachUsername == usernameController.text) {
          isValidate = false;
          setState(() {});
          break;
        }
        if (eachUsername != usernameController.text) {
          isValidate = true;
          setState(() {});
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 2,
                  bottom: 8,
                ),
                child: Text(
                  "Enter the username",
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  validator: (username) {
                    validateUsername();
                    return isValidate ? null : "username already taken";
                  },
                  controller: usernameController,
                  decoration: InputDecoration(
                    suffixIcon: isValidate
                        ? const Icon(Icons.verified_user_rounded)
                        : const Icon(Icons.cancel),
                    suffixIconColor: isValidate ? Colors.green : Colors.red,
                    hintText: "What is your unique username",
                    hintStyle: const TextStyle(fontSize: 15),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: FlatButton(
                  text: "CONTINUE",
                  onPressed: () async {
                    isValidate
                        ? await ref
                            .watch(userDataServiceProvider)
                            .addUserDataToFirestore(
                              widget.displayName,
                              widget.email,
                              widget.photoUrl,
                              auth.currentUser!.uid,
                              usernameController.text,
                            )
                        : null;
                  },
                  colour: isValidate ? Colors.green : Colors.green.shade100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
