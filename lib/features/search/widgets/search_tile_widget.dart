// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/auth/data/model/user.dart';
import 'package:youtube_clone/features/channel/screens/users_channels.dart';

class SearchUserTileWidget extends StatelessWidget {
  final UserModel userModel;
  const SearchUserTileWidget({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      "${userModel.suberscribers}",
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
                        onPressed: () {
                          //TODO subscribe the channel
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
