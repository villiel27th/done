import 'package:done/dao/schedule_dao.dart';
import 'package:done/model/schedule.dart';

class ScheduleRepository {
  final scheduleDao = ScheduleDao();

  Future getAllSchedules({String query}) =>
      scheduleDao.getSchedules(query: query);

  Future insertSchedule(Schedule todo) => scheduleDao.createSchedule(todo);

  Future updateSchedule(Schedule todo) => scheduleDao.updateSchedule(todo);

  Future deleteScheduleById(int id) => scheduleDao.deleteSchedule(id);

  //We are not going to use this in the demo
  Future deleteAllTodos() => scheduleDao.deleteAllSchedules();
}
