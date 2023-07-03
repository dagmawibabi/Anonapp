// ignore_for_file: unused_element, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:anonapp/routes/homePage.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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

  String deviceIP = "";
  int devicePort = 47123;
  String otherIP = "";
  int otherPort = 47123;
  Future<void> getDeviceIP() async {
    Permission.locationWhenInUse.request();
    deviceIP = await Ipify.ipv4();
    print(deviceIP);
    await initServer();
    setState(() {});
  }

  void connectSOCKET() async {
    print("==========================================");
    print('DeviceIP: ${deviceIP} == OtherIP: ${otherIP}');
    print('DevicePort: ${devicePort} == OtherPort: ${otherPort}');
    print("==========================================");

    try {
      print("connecting...");
      await Socket.connect(otherIP, otherPort).then(
        (socket) {
          socket.listen(
            (data) {
              print("""data""");
            },
            onDone: () {
              print("done");
            },
          );
        },
      );
      print("connected");
    } catch (e) {
      print(e);
    }
  }

  Future<void> initServer() async {
    print("Server binding to IP and port");
    // await ServerSocket.bind(InternetAddress.anyIPv4, devicePort).then(
    //   (ServerSocket server) {
    //     print("server running");
    //     server.listen(
    //       (client) async {
    //         print("-----------------server-------------------");
    //         print('Connection from '
    //             '${client.remoteAddress.address}:${client.remotePort}');
    //         client.write("heyyy");
    //         // client.close();
    //       },
    //     );
    //   },
    // );

    // IO.Socket socket = IO.io('http://localhost:3000');
    // socket.onConnect((_) {
    //   print('connect');
    //   socket.emit('msg', 'test');
    // });
    // socket.on('event', (data) => print(data));
    // socket.onDisconnect((_) => print('disconnect'));
    // socket.on('fromServer', (_) => print(_));

    print("Server Binded to ${deviceIP} on port ${devicePort}");
  }

  void findAvailablePorts() async {
    final startPort = 1024;
    final endPort = 65535;

    for (int port = startPort; port <= endPort; port++) {
      try {
        final serverSocket =
            await ServerSocket.bind(InternetAddress.anyIPv4, port);
        print('Port $port is available');
        await serverSocket.close();
      } catch (e) {
        print('Port $port is not available');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceIP();
    getLoggedInUser();
    getCreatedIDs();
  }

  TextEditingController otherIPCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          deviceIP,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              devicePort = 1027;
              initServer();
              setState(() {});
            },
            child: Text(
              devicePort.toString(),
              style: TextStyle(
                color: Colors.lightGreen,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              connectSOCKET();
            },
            icon: Icon(
              Ionicons.wifi_outline,
            ),
          ),
          IconButton(
            onPressed: () {
              getDeviceIP();
            },
            icon: Icon(
              Icons.refresh,
            ),
          ),
          IconButton(
            onPressed: () async {
              // findAvailablePorts();
              final ipv4 = await Ipify.ipv4();
              print(ipv4);
            },
            icon: Icon(
              Icons.abc,
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey[900]!,
              child: TextField(
                controller: otherIPCtrl,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                otherIP = otherIPCtrl.text.trim();
                setState(() {});
              },
              child: Text(
                "Set Other IP",
              ),
            ),

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
