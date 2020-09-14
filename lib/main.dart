import 'package:flutter/material.dart';

import 'home_screen.dart';

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
      title: "Chatlity",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}
