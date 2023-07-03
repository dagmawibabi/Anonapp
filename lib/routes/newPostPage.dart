// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:anonapp/models/postsModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({
    super.key,
    required this.getPosts,
  });

  final Function getPosts;

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  TextEditingController contentController = TextEditingController();
  String uuid = "";

  void getUser() async {
    Box systemBox = await Hive.openBox("System");
    uuid = await systemBox.get("loggedInUser");
    setState(() {});
  }

  void addNewPostToHive() async {
    String postContent = contentController.text.trim().toString();

    PostsModel newPost = PostsModel()
      ..username = uuid
      ..datetime = DateTime.now().millisecondsSinceEpoch
      ..content = postContent;

    Box userBox = await Hive.openBox(uuid);

    dynamic posts = await userBox.get("posts");
    // print(posts);
    // print(posts.length);
    // print(posts[0].datetime);
    List previousPosts = [];
    if (posts == null) {
      await userBox.put("posts", previousPosts);
    } else {
      previousPosts = posts;
    }

    previousPosts.add(newPost);
    await userBox.put("posts", previousPosts);

    // await userBox.put("posts", newPost);
    // print(myPosts.put(key, value));
    widget.getPosts();
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Post",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextButton(
              onPressed: () {
                addNewPostToHive();
              },
              child: Text(
                "Post",
                style: TextStyle(
                  color: Colors.greenAccent,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Column(
              children: [
                // PFP and Username
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Row(
                    children: [
                      // PFP and Username
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // PFP
                          Container(
                            width: 40.0,
                            height: 40.0,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Colors.grey[800]!,
                              borderRadius: BorderRadius.all(
                                Radius.circular(100.0),
                              ),
                            ),
                            child: Image.network(
                              "https://ichef.bbci.co.uk/news/976/cpsprodpb/16620/production/_91408619_55df76d5-2245-41c1-8031-07a4da3f313f.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          // Username and Timestamp
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                uuid.toString(),
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11.0,
                                    ),
                                  ),
                                  SizedBox(width: 2.0),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 2.5),
                                    child: Icon(
                                      Ionicons.time_outline,
                                      color: Colors.grey,
                                      size: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Content
                Container(
                  margin: EdgeInsets.only(top: 15.0),
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 0.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[900]!.withOpacity(0.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: TextField(
                    controller: contentController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "What do you have to say? ...",
                    ),
                    maxLines: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
