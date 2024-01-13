import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/colors.dart';
import 'package:youtube_clone/cores/widgets/custom_button.dart';
import 'package:youtube_clone/cores/widgets/loader.dart';
import 'package:youtube_clone/features/auth/data/model/user.dart';
import 'package:youtube_clone/features/auth/providers/user_provider.dart';
import 'package:youtube_clone/features/content_pages/widgets/post.dart';
import 'package:youtube_clone/features/search/widgets/search_tile_widget.dart';
import 'package:youtube_clone/features/upload/models/video_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController textController = TextEditingController();
  List<Map<String, dynamic>> allUsers = [];
  List<Map<String, dynamic>> foundItems = [];
  List<Map<String, dynamic>> selectedVideos = [];

  filterList(String keywordSelected) async {
    List<Map<String, dynamic>> result = [];

    final videoMap =
        await FirebaseFirestore.instance.collection("videos").get();
    final docs = videoMap.docs;
    List<Map<String, dynamic>> videos = [];
    docs.forEach((doc) {
      videos.add(doc.data());
    });

    List<Map<String, dynamic>> foundVideos = videos
        .where((video) => video["title"]
            .toString()
            .toLowerCase()
            .contains(keywordSelected.toLowerCase()))
        .toList();
    result = allUsers
        .where((user) => user["displayName"]
            .toString()
            .toLowerCase()
            .contains(keywordSelected.toLowerCase()))
        .toList();
    result.addAll(foundVideos);
    setState(() {
      selectedVideos = foundVideos;
      foundItems = result;
      foundItems.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          return ref.watch(allUsersDataProvider).when(
                data: (userMap) {
                  allUsers = userMap;

                  return Column(
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
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.69,
                                  child: TextFormField(
                                    onChanged: (value) {
                                      filterList(value);
                                    },
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
                                      contentPadding:
                                          EdgeInsets.only(top: 6, left: 6),
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
                        child: ListView.builder(
                          itemCount: foundItems.length,
                          itemBuilder: (context, index) {
                            List<Widget> items = [];
                            final currentMap = foundItems[index];
                            if (currentMap["type"] == "video") {
                              VideoModel videoModel =
                                  VideoModel.fromMap(currentMap);
                              items.add(
                                Post(video: videoModel),
                              );
                              items.shuffle();
                            }
                            if (currentMap["type"] == "user") {
                              final userModel = UserModel.fromMap(currentMap);
                              items.add(
                                SearchUserTileWidget(userModel: userModel),
                              );
                              items.shuffle();
                            }

                            return items[0];
                          },
                        ),
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) => ErrorWidget("NO RESUTL"),
                loading: () => const Loader(),
              );
        },
      ),
    );
  }
}
