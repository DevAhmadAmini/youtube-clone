import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/widgets/image_button.dart';
import 'package:youtube_clone/cores/widgets/loader.dart';
import 'package:youtube_clone/features/auth/providers/user_provider.dart';
import 'package:youtube_clone/features/channel/parts/channel_tab_pages.dart';
import 'package:youtube_clone/features/channel/parts/channel_tabbar.dart';
import 'package:youtube_clone/features/channel/parts/channel_user_info.dart';
import 'package:youtube_clone/features/channel/screens/my_channel_settings.dart';

class MyChannel extends ConsumerWidget {
  const MyChannel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.read(currentUserDataProvider).when(
          data: (user) {
            return DefaultTabController(
              length: 6,
              child: Scaffold(
                body: SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          ChannelUserInfo(user: user),
                          const Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 18),
                            child: Text(
                              "More about this Channel",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff5F5F5F),
                                fontWeight: FontWeight.w400,
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
                                    color: Color(0xffF2F2F2),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(18),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Manage Videos",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ImageButton(
                                  image: "time-watched.png",
                                  onPressed: () {},
                                  haveColor: true,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ImageButton(
                                  image: "pen.png",
                                  haveColor: true,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChannelSettings(
                                          userModel: user,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const ChannelTabBar(),
                          const ChannelTabPages(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          loading: () => const Loader(),
          error: (error, stackTrace) => const ErrorPage(),
        );
  }
}
