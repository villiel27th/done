import 'package:done/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userPic;
  final List<int> numbers = [1, 2, 3, 5, 8, 13, 21, 34, 55];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: homeBody(),
        ),
      ),
    );
  }

  homeBody() {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
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
                    backgroundColor: Colors.green,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.add_box,
                        size: 40,
                      ),
                      onPressed: () => print('add'))
                ],
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                  child: Text(
                    'Welcome to the Dashboard',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Calvin Williamson',
                    style: TextStyle(
                        fontSize: largeFontSize, fontWeight: FontWeight.bold),
                  ),
                )),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                splashColor: Colors.green.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  color: Color.fromRGBO(225, 245, 254, 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                        ),
                        child: Icon(
                          Icons.notifications,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You Have 3 meetings today.',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
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
                        size: 15,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'TODAY: JANUARY 17, 2020',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w800),
                )),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: numbers.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      margin: EdgeInsets.only(right: 20),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.green,
                        child: Container(
                          child: Center(
                              child: Text(
                            numbers[index].toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 36.0),
                          )),
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
