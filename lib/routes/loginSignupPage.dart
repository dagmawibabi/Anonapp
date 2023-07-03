// ignore_for_file: unused_element, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:anonapp/routes/homePage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:uuid/uuid.dart';

class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({super.key});

  @override
  State<LoginSignupPage> createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  String uuid = "";

  void getLoggedInUser() async {
    Box systemBox = await Hive.openBox("System");
    dynamic previousLoggedInUser = await systemBox.get("loggedInUser");
    if (previousLoggedInUser != null) {
      // LOG IN
      print(previousLoggedInUser);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  void generateUUID() async {
    uuid = Uuid().v4();
    setState(() {});
  }

  List createdIDs = [];
  void getCreatedIDs() async {
    Box systemBox = await Hive.openBox("System");
    // dynamic keys = await systemBox.keys.toList();
    // print("========================================");
    // print(keys);
    // print("========================================");
    dynamic previousCreatedIDs = await systemBox.get("previousCreatedIDs");
    if (previousCreatedIDs != null) {
      createdIDs = previousCreatedIDs;
    }
    setState(() {});
  }

  void login() async {
    Box systemBox = await Hive.openBox("System");
    await systemBox.put("loggedInUser", uuid);

    dynamic previousCreatedIDs = await systemBox.get("previousCreatedIDs");
    if (previousCreatedIDs == null) {
      await systemBox.put("previousCreatedIDs", [uuid]);
    } else {
      List createdIDs = previousCreatedIDs;
      createdIDs.add(uuid);
      await systemBox.put("previousCreatedIDs", createdIDs);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  void savedLogin(String savedUUID) async {
    Box systemBox = await Hive.openBox("System");
    await systemBox.put("loggedInUser", savedUUID);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  void getIP() async {
    final networkInfo = NetworkInfo();
    Future<String?> ip = networkInfo.getWifiIPv6();
    ip.then((v) => print(v));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoggedInUser();
    getCreatedIDs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            uuid == ""
                ? Container()
                : Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "This is your Unique Identifier in the Network",
                    ),
                  ),
            SizedBox(height: 15.0),
            uuid == ""
                ? GestureDetector(
                    onTap: () {
                      generateUUID();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                        top: 7.0,
                        bottom: 10.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[900]!.withOpacity(0.5),
                        border: Border.all(
                          color: Colors.grey[800]!,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Generate Unique ID",
                      ),
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      top: 7.0,
                      bottom: 10.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[900]!,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      uuid.toString(),
                    ),
                  ),
            SizedBox(height: 15.0),
            uuid == ""
                ? Container()
                : GestureDetector(
                    onTap: () {
                      login();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                        top: 7.0,
                        bottom: 10.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                top: 7.0,
                bottom: 10.0,
                left: 20.0,
                right: 20.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[900]!.withOpacity(0.5),
                border: Border.all(
                  color: Colors.grey[800]!,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text("Saved Unique IDs"),
                  SizedBox(height: 10.0),
                  for (var eachCreatedID in createdIDs)
                    GestureDetector(
                      onTap: () {
                        savedLogin(eachCreatedID);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          eachCreatedID,
                          style: TextStyle(
                            color: Colors.greenAccent,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Spacer(),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}
