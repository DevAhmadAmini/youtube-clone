// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/features/account/parts/items.dart';
import '../auth/data/model/user.dart';

class AccountSheet extends StatelessWidget {
  final UserModel userModel;
  const AccountSheet({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 20,
          top: 30,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close_sharp,
                  size: 27,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 24),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: CachedNetworkImageProvider(
                        //TODO
                        userModel.profilePic!,
                      ),
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Ahmad Amini",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        "@Ahmad-Amini-11",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 9),
                      Text(
                        "Manage your Google Account",
                        style: TextStyle(
                          color: Color.fromARGB(255, 8, 121, 214),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Items(),
            const Text(
              "Privacy Policy . Terms of Service",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xff5F5F5F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
