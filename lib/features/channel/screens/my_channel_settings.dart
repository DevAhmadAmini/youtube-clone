import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/colors.dart';
import 'package:youtube_clone/cores/widgets/custom_appbar.dart';
import 'package:youtube_clone/features/channel/widgets/settings_dialog.dart';
import 'package:youtube_clone/features/channel/widgets/settings_item.dart';

class ChannelSettings extends StatelessWidget {
  const ChannelSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
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
                        "https://th.bing.com/th/id/OIP._IgGc9h6kbuSmYLsRhBNvwHaEo?pid=ImgDet&rs=1",
                    width: 900,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 150,
                  top: 21,
                  child: CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.grey,
                    child: Image.asset(
                      "assets/icons/camera.png",
                      color: Colors.white,
                      height: 18,
                    ),
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
            SettingsItem(
              identifier: "Name",
              value: "Code HQ",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SettingsDialog(
                      identifier: "Name",
                      onSave: () {},
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
                      identifier: "Handle",
                      onSave: () {},
                    );
                  },
                );
              },
            ),
            const Divider(color: Colors.grey),
            SettingsItem(
              identifier: "Description",
              value: "Making code easy and fun",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SettingsDialog(
                      identifier: "Description",
                      onSave: () {},
                    );
                  },
                );
              },
            ),
            const Divider(color: Colors.grey),
            const Padding(
              padding: EdgeInsets.only(top: 6, bottom: 17, left: 10),
              child: Text(
                "Privacy",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Keep all my Subscribers private"),
                  Switch(
                    value: false,
                    onChanged: (value) {},
                    activeColor: Colors.black,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8),
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
