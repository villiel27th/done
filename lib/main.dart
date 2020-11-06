import 'package:done/const.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "done",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(brightness: Brightness.light, primaryColor: mainColor),
    );
  }
}
