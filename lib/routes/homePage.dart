// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:anonapp/components/eachPost.dart';
import 'package:anonapp/routes/loginSignupPage.dart';
import 'package:anonapp/routes/newPostPage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uuid = "";
  List feed = [];

  void getUser() async {
    Box systemBox = await Hive.openBox("System");
    uuid = await systemBox.get("loggedInUser");
    await getPosts();
    setState(() {});
  }

  Future<void> getPosts() async {
    Box userBox = await Hive.openBox(uuid);
    dynamic posts = await userBox.get("posts");
    if (posts == null) {
      await userBox.put("posts", feed);
    } else {
      feed = posts;
    }
    feed = feed.reversed.toList();
    print("REFRESHED!");
    setState(() {});
  }

  void logout() async {
    Box systemBox = await Hive.openBox("System");
    await systemBox.delete("loggedInUser");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginSignupPage(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    // getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Anonapp",
          // style: TextStyle(
          //   fontSize: 12.0,
          // ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              getPosts();
            },
            icon: Icon(
              Icons.refresh_outlined,
            ),
          ),
          IconButton(
            onPressed: () {
              logout();
            },
            icon: Icon(
              Icons.logout_outlined,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              for (var eachPost in feed)
                EachPost(
                  postData: eachPost,
                ),

              // Space
              SizedBox(height: 200.0),
            ],
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(100.0),
          ),
          border: Border.all(
            color: Colors.grey[800]!,
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPostPage(
                  getPosts: getPosts,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 2.4, bottom: 4.0),
            child: Icon(
              Icons.post_add_outlined,
            ),
          ),
        ),
      ),
    );
  }
}
