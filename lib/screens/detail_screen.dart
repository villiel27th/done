import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:done/bloc/schedule_bloc.dart';
import 'package:done/main.dart';
import 'package:done/model/schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

import '../const.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DatePickerController _controller = DatePickerController();
  final ScheduleBloc scheduleBloc = ScheduleBloc();
  final DismissDirection _dismissDirection = DismissDirection.endToStart;
  List<Schedule> scheduleList;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: secondaryColor,
          body: detailBody(),
        ),
      ),
    );
  }

  Widget detailBody() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBoxResponsive(
                height: 20,
              ),
              ContainerResponsive(
                height: 450,
                margin: EdgeInsetsResponsive.symmetric(horizontal: 35),
                width: 1080,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://media.istockphoto.com/videos/black-abstract-corporate-motion-design-with-waves-video-id1205173184?s=640x640'),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      alignment: FractionalOffset.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Text(
                          'Calvin\'s Timeline',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 5),
                          child: IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              size: 35,
                              color: secondaryColor,
                            ),
                            onPressed: () => _showAddTodoSheet(context),
                          ),
                        )
                      ],
                    ),
                    SizedBoxResponsive(
                      height: 20,
                    ),
                    Container(
                      child: DatePicker(
                        DateTime.now().subtract(Duration(days: 2)),
                        controller: _controller,
                        width: 74,
                        height: 100,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: secondaryColor.withOpacity(0.9),
                        selectedTextColor: mainColor,
                        dateTextStyle: TextStyle(
                          color: secondaryColor,
                          fontSize: 24,
                        ),
                        monthTextStyle: TextStyle(
                          color: secondaryColor,
                          fontSize: 11,
                        ),
                        dayTextStyle: TextStyle(
                          color: secondaryColor,
                          fontSize: 11,
                        ),
                        onDateChange: (date) {
                          // New date selected
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBoxResponsive(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: getTodosWidget(),
//          child: ShaderMask(
//            shaderCallback: (Rect bounds) {
//              return LinearGradient(
//                begin: Alignment.center,
//                end: Alignment.bottomCenter,
//                colors: <Color>[Colors.white, Colors.transparent],
//              ).createShader(bounds);
//            },
//            child: getTodosWidget(),
//            blendMode: BlendMode.dstIn,
//          ),
        )
      ],
    );
  }

  void _showAddTodoSheet(BuildContext context) {
    final _todoDescriptionFormController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: new Container(
              color: Colors.transparent,
              child: new Container(
                height: 230,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15, top: 25.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _todoDescriptionFormController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'I have to...',
                                  labelText: 'New Todo',
                                  labelStyle: TextStyle(
                                      color: mainColor,
                                      fontWeight: FontWeight.w500)),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Empty description!';
                                }
                                return value.contains('')
                                    ? 'Do not use the @ char.'
                                    : null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: mainColor,
                              radius: 18,
                              child: IconButton(
                                icon: Icon(
                                  Icons.save,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  final newTodo = Schedule(
                                      description:
                                          _todoDescriptionFormController
                                              .value.text);
                                  if (newTodo.description.isNotEmpty) {
                                    /*Create new Todo object and make sure
                                    the Todo description is not empty,
                                    because what's the point of saving empty
                                    Todo
                                    */
                                    scheduleBloc.addSchedule(newTodo);

                                    //dismisses the bottomsheet
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget getTodosWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (todos)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      stream: scheduleBloc.schedules,
      builder: (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
        return getTodoCardWidget(snapshot);
      },
    );
  }

//  Widget getTodoCardWidget(AsyncSnapshot<List<Schedule>> snapshot) {
//    /*Since most of our operations are asynchronous
//    at initial state of the operation there will be no stream
//    so we need to handle it if this was the case
//    by showing users a processing/loading indicator*/
//    if (snapshot.hasData) {
//      /*Also handles whenever there's stream
//      but returned returned 0 records of Todo from DB.
//      If that the case show user that you have empty Todos
//      */
//      return snapshot.data.length != 0
//          ? ListView.builder(
//              itemCount: snapshot.data.length,
//              itemBuilder: (context, itemPosition) {
//                Schedule todo = snapshot.data[itemPosition];
//                final Widget dismissibleCard = new Dismissible(
//                  background: Container(
//                    margin: EdgeInsetsResponsive.symmetric(horizontal: 35),
//                    child: Padding(
//                      padding: EdgeInsets.only(right: 20),
//                      child: Align(
//                        alignment: Alignment.centerRight,
//                        child: Text(
//                          "Delete",
//                          style: TextStyle(color: Colors.white),
//                        ),
//                      ),
//                    ),
//                    color: Colors.redAccent,
//                  ),
//                  onDismissed: (direction) {
//                    /*The magic
//                    delete Todo item by ID whenever
//                    the card is dismissed
//                    */
//                    scheduleBloc.deleteScheduleById(todo.id);
//                  },
//                  direction: _dismissDirection,
//                  key: new ObjectKey(todo),
//                  child: Card(
//                      margin: EdgeInsetsResponsive.symmetric(horizontal: 35),
//                      shape: RoundedRectangleBorder(
//                        side: BorderSide(color: Colors.grey[200], width: 0.5),
//                        borderRadius: BorderRadius.circular(5),
//                      ),
//                      color: Colors.white,
//                      child: ListTile(
//                        leading: InkWell(
//                          onTap: () {
//                            //Reverse the value
//                            todo.isDone = !todo.isDone;
//                            /*
//                            Another magic.
//                            This will update Todo isDone with either
//                            completed or not
//                          */
//                            scheduleBloc.updateSchedule(todo);
//                          },
//                          child: Container(
//                            //decoration: BoxDecoration(),
//                            child: Padding(
//                              padding: const EdgeInsets.all(15.0),
//                              child: todo.isDone
//                                  ? Icon(
//                                      Icons.done,
//                                      size: 26.0,
//                                      color: Colors.indigoAccent,
//                                    )
//                                  : Icon(
//                                      Icons.check_box_outline_blank,
//                                      size: 26.0,
//                                      color: Colors.tealAccent,
//                                    ),
//                            ),
//                          ),
//                        ),
//                        title: Text(
//                          todo.description,
//                          style: TextStyle(
//                              fontSize: 16.5,
//                              fontFamily: 'RobotoMono',
//                              fontWeight: FontWeight.w500,
//                              decoration: todo.isDone
//                                  ? TextDecoration.lineThrough
//                                  : TextDecoration.none),
//                        ),
//                      )),
//                );
//                return dismissibleCard;
//              },
//            )
//          : Container(
//              child: Center(
//              //this is used whenever there 0 Todo
//              //in the data base
//              child: noTodoMessageWidget(),
//            ));
//    } else {
//      return Center(
//        /*since most of our I/O operations are done
//        outside the main thread asynchronously
//        we may want to display a loading indicator
//        to let the use know the app is currently
//        processing*/
//        child: loadingData(),
//      );
//    }
//  }

  Widget getTodoCardWidget(AsyncSnapshot<List<Schedule>> snapshot) {
    /*Since most of our operations are asynchronous
    at initial state of the operation there will be no stream
    so we need to handle it if this was the case
    by showing users a processing/loading indicator*/
    if (snapshot.hasData) {
      /*Also handles whenever there's stream
      but returned returned 0 records of Todo from DB.
      If that the case show user that you have empty Todos
      */
      return snapshot.data.length != 0
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, itemPosition) {
                Schedule todo = snapshot.data[itemPosition];
                final Widget dismissibleCard = new Dismissible(
                  background: Container(
                    margin: EdgeInsetsResponsive.fromLTRB(35, 0, 35, 39),
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    color: Colors.redAccent,
                  ),
                  onDismissed: (direction) {
                    /*The magic
                    delete Todo item by ID whenever
                    the card is dismissed
                    */
                    scheduleBloc.deleteScheduleById(todo.id);
                  },
                  direction: _dismissDirection,
                  key: new ObjectKey(todo),
                  child: ContainerResponsive(
                    margin: EdgeInsets.only(bottom: 20),
                    height: 200,
                    child: Card(
                        elevation: 2,
                        margin: EdgeInsetsResponsive.symmetric(horizontal: 35),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey[200], width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Colors.white,
                        child: ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "11:00",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBoxResponsive(
                                height: 15,
                              ),
                              Text("12:30",
                                  style: TextStyle(
                                      color: mainColor.withOpacity(0.6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ],
                          ),
                          title: Row(
                            children: <Widget>[
                              ContainerResponsive(
                                width: 13,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black,
                                ),
                                margin: EdgeInsets.only(bottom: 8),
                              ),
                              SizedBoxResponsive(
                                width: 40,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3, bottom: 4),
                                    child: Text(
                                      'BUSINESS',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: mainColor.withOpacity(0.6)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3, bottom: 4),
                                    child: Text(
                                      todo.description,
                                      style: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.bold,
                                          decoration: todo.isDone
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on,
                                        color: mainColor.withOpacity(0.6),
                                        size: 17,
                                      ),
                                      Text(
                                        'Kensington Park Road',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: mainColor.withOpacity(0.6)),
                                      ),
                                    ],
                                  ),
                                  SizedBoxResponsive(
                                    height: 10,
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                );
                return dismissibleCard;
              },
            )
          : Container(
              child: Center(
              //this is used whenever there 0 Todo
              //in the data base
              child: noTodoMessageWidget(),
            ));
    } else {
      return Center(
        /*since most of our I/O operations are done
        outside the main thread asynchronously
        we may want to display a loading indicator
        to let the use know the app is currently
        processing*/
        child: loadingData(),
      );
    }
  }

  Widget noTodoMessageWidget() {
    return Column(
      children: <Widget>[
        SizedBoxResponsive(
          height: 100,
        ),
        Container(child: Image.asset("assets/empty_list.png")),
        SizedBoxResponsive(
          height: 100,
        ),
        TextResponsive(
          "Start adding plans to your schedule!",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget loadingData() {
    //pull todos again
    scheduleBloc.getSchedule();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Loading...",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  dispose() {
    /*close the stream in order
    to avoid memory leaks
    */
    scheduleBloc.dispose();
  }
}
