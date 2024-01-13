// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/widgets/custom_button.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';
import 'package:youtube_clone/features/channel/repository/subscribe_repository.dart';

class UserChannel extends ConsumerWidget {
  final UserModel? userModel;
  const UserChannel({super.key, this.userModel});
  //b
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CachedNetworkImage(
                imageUrl:
                    "https://graphicsfamily.com/wp-content/uploads/2020/10/Photography-web-banner-design-template-scaled.jpg",
                height: MediaQuery.sizeOf(context).height * 0.2,
                fit: BoxFit.cover,
              ),
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      CachedNetworkImageProvider(userModel!.profilePic!),
                ),
              ),
              Center(
                child: Text(
                  userModel!.displayName!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: userModel!.username,
                      ),
                      TextSpan(
                        text: "  ${userModel!.subscriptions} subscribers",
                      ),
                      TextSpan(
                        text: "  ${userModel!.videos} videos",
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 220, 216, 216),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                      ),
                      child: const Center(
                        child: Text("Manage Videos"),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      iconData: Icons.pending_actions,
                      onTap: () {},
                      haveColor: true,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      iconData: Icons.pending_actions,
                      onTap: () {},
                      haveColor: true,
                    ),
                  ),
                ],
              ),
              FlatButton(
                colour: Colors.black,
                onPressed: () async {
                  await ref.watch(subscribeChannelProvider).subscribeUser(
                        currentUserId: FirebaseAuth.instance.currentUser!.uid,
                        subscribedUserId: userModel!.userId,
                        userSubscriptions: userModel!.subscriptions,
                        // userVideoId:
                      );
                },
                text: "Subscribe",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
