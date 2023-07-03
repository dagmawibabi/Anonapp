// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'dart:ffi';

import 'package:anonapp/models/postsModel.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class EachPost extends StatefulWidget {
  const EachPost({
    super.key,
    required this.postData,
  });

  final PostsModel postData;

  @override
  State<EachPost> createState() => _EachPostState();
}

class _EachPostState extends State<EachPost> {
  bool isLiked = false;
  bool isReposted = false;
  bool isBookmarked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.5),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        children: [
          // PFP and Username
          Row(
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
                        widget.postData.username.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            DateTime.fromMillisecondsSinceEpoch(
                                        widget.postData.datetime)
                                    .toString()
                                    .substring(11, 16) +
                                " • " +
                                DateTime.fromMillisecondsSinceEpoch(
                                        widget.postData.datetime)
                                    .toString()
                                    .substring(0, 10),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11.0,
                            ),
                          ),
                          SizedBox(width: 2.0),
                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: 2.5),
                          //   child: Icon(
                          //     Ionicons.time_outline,
                          //     color: Colors.grey,
                          //     size: 12.0,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Content
          Container(
            margin: EdgeInsets.only(top: 15.0),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.postData.content.toString(),
              textAlign: TextAlign.left,
            ),
          ),
          // Interactions
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            isLiked = !isLiked;
                            setState(() {});
                          },
                          child: Icon(
                            isLiked == true
                                ? Ionicons.heart
                                : Ionicons.heart_outline,
                            color: isLiked == true
                                ? Colors.greenAccent
                                : Colors.white,
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "1.2k",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20.0),
                    Row(
                      children: [
                        Icon(
                          Ionicons.chatbubble_outline,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "1.2k",
                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(width: 20.0),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            isReposted = !isReposted;
                            setState(() {});
                          },
                          child: Icon(
                            Ionicons.repeat_outline,
                            color: isReposted == true
                                ? Colors.greenAccent
                                : Colors.white,
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "1.2k",
                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(width: 20.0),
                    Row(
                      children: [
                        Icon(
                          Ionicons.eye_outline,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "1.2k",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    isBookmarked = !isBookmarked;
                    setState(() {});
                  },
                  child: Icon(
                    isBookmarked == true
                        ? Icons.bookmark
                        : Icons.bookmark_border_outlined,
                    color: isBookmarked == true
                        ? Colors.greenAccent
                        : Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
