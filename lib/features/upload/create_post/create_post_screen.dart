import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youtube_clone/cores/methods.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Create Post",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 19,
              ),
            ),
            // const Spacer(),
            SizedBox(
              height: 35,
              width: 60,
              child: FlatButton(
                text: "Post",
                onPressed: () {},
                colour: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 17.5,
                  backgroundColor: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    "Code Hq",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: "Write a message",
                hintStyle: TextStyle(
                  color: Colors.blueGrey[300],
                ),
                border: InputBorder.none,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () async {
                await pickImage(ImageSource.gallery);
              },
              icon: const Icon(
                Icons.photo,
                color: Colors.white,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
