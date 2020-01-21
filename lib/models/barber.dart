import 'package:barracks_app/models/schedule.dart';
import 'package:flutter/widgets.dart';

class Barber {
  final String id;
  final String name;
  final String imgUrl;
  final String branch;
  final int dayoff;
  List<Schedule> schedule;

  Barber(
      {@required this.id,
      @required this.name,
      @required this.imgUrl,
      @required this.branch,
      @required this.dayoff,
      this.schedule});

  bool isAvailable(Schedule query) {
    //if it is barber's day of then false;
    if (DateTime.now().weekday == dayoff) return false;
    //checks if there is an overlap in the schedule to the query request
    return schedule.every((schedule) =>
        !(schedule.starttime.isBefore(query.endtime) &&
            schedule.endtime.isAfter(query.starttime)));
  }
}
