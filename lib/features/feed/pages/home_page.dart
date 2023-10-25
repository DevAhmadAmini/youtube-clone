// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_clone/cores/widgets/image_button.dart';
import 'package:youtube_clone/features/auth/data/model/user.dart';
import 'package:youtube_clone/features/feed/parts/bottom_navigation.dart';
import 'package:youtube_clone/features/search/search_screen.dart';
import '../../../cores/screens/error_page.dart';
import '../../../cores/widgets/loader.dart';
import '../../account/account_page.dart';
import '../../auth/providers/user_provider.dart';
import '../../pages.dart';
import '../../../cores/widgets/custom_button.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int currentIndex = 0;
  UserModel? userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      bottomNavigationBar: BottomNavigation(
        onPressed: (index) {
          currentIndex = index;
          setState(() {});
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.5, left: 12, right: 10),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/youtube.jpg",
                    height: 32.5,
                  ),
                  const SizedBox(width: 4),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(
                      height: 40,
                      child: ImageButton(
                        image: "cast.png",
                        onPressed: () {},
                        haveColor: false,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: ImageButton(
                      image: "notification.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 15),
                    child: SizedBox(
                      height: 38,
                      child: ImageButton(
                        image: "search.png",
                        onPressed: () {},
                        haveColor: false,
                      ),
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return ref.watch(userDataProvider).when(
                        data: (data) {
                          userData = data;
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => DraggableScrollableSheet(
                                  initialChildSize: 1.0,
                                  minChildSize: 1.0,
                                  maxChildSize: 1.0,
                                  builder: (context, scrollController) {
                                    return AccountSheet(
                                      userModel: userData!,
                                    );
                                  },
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 11,
                              backgroundColor: Colors.grey,
                              backgroundImage: CachedNetworkImageProvider(
                                data.profilePic,
                              ),
                            ),
                          );
                        },
                        error: (error, stackTrace) {
                          return const ErrorPage();
                        },
                        loading: () {
                          return const Loader();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: pages[currentIndex],
            ),
          ],
        ),
      ),
    );
  }
}
