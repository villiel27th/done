import 'package:done/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

import '../const.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userPic;
  final List<String> list = [
    'My Meetings',
    'My Schedule',
    'My meetings',
    'My meetings',
    'My meetings'
  ];

  @override
  Widget build(BuildContext context) {
    ResponsiveWidgets.init(
      context,
      height: 1920, // Optional
      width: 1080, // Optional
      allowFontScaling: true, // Optional
    );

    return ResponsiveWidgets.builder(
      height: 1920, // Optional
      width: 1080, // Optional
      allowFontScaling: true, // Optional
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(backgroundColor: Colors.white, body: homeBody()),
        ),
      ),
    );
  }
//
//  Widget build(BuildContext context) {
//    return Container(
//      color: Colors.white,
//      child: SafeArea(
//        child: Scaffold(
//          backgroundColor: Colors.white,
//          body: homeBody(),
//        ),
//      ),
//    );
//  }

  homeBody() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleAvatar(
                  radius: 25,
                  child: userPic == null
                      ? Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        )
                      : userPic,
                  backgroundColor: mainColor,
                ),
                IconButton(
                    icon: Icon(
                      Icons.add_box,
                      size: 40,
                    ),
                    onPressed: () => print('add'))
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                  child: TextResponsive(
                    'Welcome to the Dashboard',
                    style: TextStyle(fontSize: 42, color: Colors.grey),
                  ),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: TextResponsive(
                    'Calvin Williamson',
                    style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                  ),
                )),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                splashColor: mainColor,
                onTap: () {
                  print('Card tapped.');
                },
                child: ContainerResponsive(
                  width: 1080,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.9)),
//                  color: Color.fromRGBO(225, 245, 254, 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ContainerResponsive(
                        margin: EdgeInsets.only(bottom: 14),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.notifications,
                          size: 30,
                          color: secondaryColor,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You Have 3 meetings today.',
                            style: TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'the next in 2h',
                            style: TextStyle(
                              fontSize: regularFontSize,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: secondaryColor,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBoxResponsive(height: 40),
            Align(
                alignment: Alignment.centerLeft,
                child: TextResponsive(
                  'TODAY: JANUARY 17, 2020',
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.grey,
                      fontWeight: FontWeight.w800),
                )),
            SizedBoxResponsive(height: 40),
            ContainerResponsive(
//              height: MediaQuery.of(context).size.height / 2.2,
              height: 980,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ContainerResponsive(
//                      width: MediaQuery.of(context).size.width * 0.6,
                      width: 650,
                      margin: EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen())),
                        child: ContainerResponsive(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/black-vector-background.jpg'),
                                  fit: BoxFit.cover)),
                          child: ContainerResponsive(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  list[index].split(" ").first,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  list[index].split(" ").last,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
