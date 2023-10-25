import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/colors.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/widgets/custom_button.dart';
import 'package:youtube_clone/cores/widgets/loader.dart';
import 'package:youtube_clone/features/auth/data/model/user.dart';
import 'package:youtube_clone/features/search/widgets/search_tile_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController textController = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_sharp),
                    ),
                    SizedBox(
                      height: 34,
                      width: MediaQuery.sizeOf(context).width * 0.69,
                      child: TextFormField(
                        // textAlign: TextAlign.center,
                        controller: textController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          hintText: "Search Youtube",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(top: 6, left: 6),
                          // hintTextDirection: Text,
                          filled: true,
                          fillColor: softBlueGreyBackGround,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CustomButton(
                        iconData: Icons.search,
                        onTap: () {},
                        haveColor: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: isSearching
                ? StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .where("userId",
                            isGreaterThanOrEqualTo: textController.text)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Loader();
                      } else if (snapshot.data == null) {
                        return const ErrorPage();
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final userMap = snapshot.data!.docs[index];
                          var userModel = UserModel.fromMap(userMap.data());
                          if (userModel.userId !=
                              FirebaseAuth.instance.currentUser!.uid) {
                            return SearchTileWidget(userModel: userModel);
                          }
                        },
                      );
                    },
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
