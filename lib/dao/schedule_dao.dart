import 'dart:async';

import 'package:done/database/database.dart';
import 'package:done/model/schedule.dart';

class ScheduleDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Todo records
  Future<int> createSchedule(Schedule schedule) async {
    final db = await dbProvider.database;
    var result = db.insert(scheduleTABLE, schedule.toDatabaseJson());
    return result;
  }

  //Get All Todo items
  //Searches if query string was passed
  Future<List<Schedule>> getSchedules(
      {List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(scheduleTABLE,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(scheduleTABLE, columns: columns);
    }

    List<Schedule> schedules = result.isNotEmpty
        ? result.map((item) => Schedule.fromDatabaseJson(item)).toList()
        : [];
    return schedules;
  }

  //Update Todo record
  Future<int> updateSchedule(Schedule schedule) async {
    final db = await dbProvider.database;

    var result = await db.update(scheduleTABLE, schedule.toDatabaseJson(),
        where: "id = ?", whereArgs: [schedule.id]);

    return result;
  }

  //Delete Todo records
  Future<int> deleteSchedule(int id) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(scheduleTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllSchedules() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      scheduleTABLE,
    );

    return result;
  }
}
