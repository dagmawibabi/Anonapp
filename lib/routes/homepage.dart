// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Anonapp",
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.grey[900]!,
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
                              "Anonuser1",
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
                // Content
                Container(
                  margin: EdgeInsets.only(top: 15.0, bottom: 10.0),
                  child: Text(
                    "Peer-to-peer computing or networking is a distributed application architecture that partitions tasks or workloads between peers. Peers are equally privileged, equipotent participants in the network. They are said to form a peer-to-peer network of nodes.",
                  ),
                ),
                // Interactions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Ionicons.heart_outline,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              "1.2k",
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey),
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
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(width: 20.0),
                        Row(
                          children: [
                            Icon(
                              Ionicons.repeat_outline,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              "1.2k",
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey),
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
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark_border_outlined,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
