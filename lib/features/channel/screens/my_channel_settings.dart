// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/colors.dart';
import 'package:youtube_clone/cores/widgets/custom_appbar.dart';
import 'package:youtube_clone/features/auth/data/model/user.dart';
import 'package:youtube_clone/features/channel/widgets/settings_dialog.dart';
import 'package:youtube_clone/features/channel/widgets/settings_item.dart';

class ChannelSettings extends StatefulWidget {
  final UserModel userModel;
  const ChannelSettings({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  State<ChannelSettings> createState() => _ChannelSettingsState();
}

class _ChannelSettingsState extends State<ChannelSettings> {
  bool switchValue = false;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          title: "Channel Settings",
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 100,
                  width: 900,
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://www.pixelstalk.net/wp-content/uploads/2016/06/HD-High-Tech-Image.jpg",
                    width: 900,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 184,
                  top: 21,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey.shade400,
                    backgroundImage: NetworkImage(widget.userModel.profilePic!),
                  ),
                ),
                Positioned(
                  left: MediaQuery.sizeOf(context).width * 0.87,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/icons/camera.png",
                      color: Colors.white,
                      height: 24,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SettingsItem(
              identifier: "Name",
              value: widget.userModel.displayName!,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SettingsDialog(
                      identifier: "Enter the new channel Name",
                      onSave: (name) {
                        // update the channel name
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          "displayName": name,
                        });
                      },
                    );
                  },
                );
              },
            ),
            const Divider(color: Colors.grey),
            SettingsItem(
              identifier: "Handle",
              value: "@codeheadq",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SettingsDialog(
                      identifier: "Enter the new username",
                      onSave: (username) {
                        // update the username
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          "username": username,
                        });
                      },
                    );
                  },
                );
              },
            ),
            const Divider(color: Colors.grey),
            SettingsItem(
              identifier: "Description",
              value: widget.userModel.description!,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SettingsDialog(
                      identifier: "Enter the new Description",
                      onSave: (description) {
                        // update the description of channel
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          "description": description,
                        });
                      },
                    );
                  },
                );
              },
            ),
            const Divider(color: Colors.grey),
            const Padding(
              padding: EdgeInsets.only(top: 6, bottom: 17, left: 16),
              child: Text(
                "Privacy",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Keep all my Subscribers private"),
                  Switch(
                    value: switchValue,
                    onChanged: (value) {
                      switchValue = value;
                      setState(() {});
                    },
                    activeColor: Colors.black,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Text(
                "Changes made on your name and profile picture are visible only to youtube and not other Google services",
                style: TextStyle(
                  color: kDeepGreyFont,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
