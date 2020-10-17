import 'dart:async';
import 'package:done/model/schedule.dart';
import 'package:done/repository/schedule_repository.dart';

class ScheduleBloc {
  //Get instance of the Repository
  final _scheduleRepository = ScheduleRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _scheduleController = StreamController<List<Schedule>>.broadcast();

  get schedules => _scheduleController.stream;

  ScheduleBloc() {
    getSchedule();
  }

  getSchedule({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _scheduleController.sink
        .add(await _scheduleRepository.getAllSchedules(query: query));
  }

  addSchedule(Schedule schedule) async {
    await _scheduleRepository.insertSchedule(schedule);
    getSchedule();
  }

  updateSchedule(Schedule schedule) async {
    await _scheduleRepository.updateSchedule(schedule);
    getSchedule();
  }

  deleteScheduleById(int id) async {
    _scheduleRepository.deleteScheduleById(id);
    getSchedule();
  }

  dispose() {
    _scheduleController.close();
  }
}
