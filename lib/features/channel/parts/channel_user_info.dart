// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:youtube_clone/features/auth/data/model/user.dart';

class ChannelUserInfo extends StatelessWidget {
  final UserModel user;
  const ChannelUserInfo({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 31,
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(user.profilePic!),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          user.displayName!,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xff5F5F5F),
              fontWeight: FontWeight.w400,
            ),
            children: [
              const TextSpan(
                text: "@AhmadAmini-11",
              ),
              TextSpan(
                text: "  ${user.suberscribers} subscribers",
              ),
              TextSpan(
                text: "  ${user.videos} videos",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
