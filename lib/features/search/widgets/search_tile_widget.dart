// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';
import 'package:youtube_clone/features/channel/presentation/screens/users_channels.dart';
import 'package:youtube_clone/features/channel/repository/subscribe_repository.dart';

class SearchUserTileWidget extends ConsumerWidget {
  final UserModel userModel;
  const SearchUserTileWidget({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserChannel(
              userModel: userModel,
            ),
          ),
        );
      },
      child: Column(
        children: [
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.only(
              right: MediaQuery.sizeOf(context).width * 0.14,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      CachedNetworkImageProvider(userModel.profilePic!),
                ),
                const SizedBox(width: 9),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userModel.displayName!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        userModel.username!,
                        style: const TextStyle(
                          fontSize: 13.6,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                    Text(
                      userModel.subscriptions!.isEmpty
                          ? "No Subscribers"
                          : "${userModel.subscriptions!.length} Subscribers",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 35,
                      child: FlatButton(
                        text: "Subscribe",
                        onPressed: () async {
                          await ref
                              .read(subscribeChannelProvider)
                              .subscribeUser(
                                currentUserId:
                                    FirebaseAuth.instance.currentUser!.uid,
                                subscribedUserId: userModel.userId,
                                userSubscriptions: userModel.subscriptions,
                                // userVideoId:
                              );
                        },
                        colour: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
