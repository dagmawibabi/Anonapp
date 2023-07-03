// ignore_for_file: prefer_const_constructors

import 'package:anonapp/models/postsModel.dart';
import 'package:anonapp/routes/homePage.dart';
import 'package:anonapp/routes/loginSignupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(PostsModelAdapter());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Colors.black;
    // Color.fromARGB(255, 25, 25, 25);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => LoginSignupPage(),
        "homePage": (context) => HomePage(),
      },
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(
          color: primaryColor,
          elevation: 0.0,
        ),
        scaffoldBackgroundColor: primaryColor,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            height: 1.3,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 19.0,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.grey[900]!,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            fontSize: 15.0,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
