import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userPic;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: homeBody(),
      ),
    );
  }

  homeBody() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          child: userPic == null ? Icon(Icons.person) : userPic,
          backgroundColor: Colors.grey,
        )
      ],
    );
  }
}
