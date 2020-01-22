import 'package:barracks_app/models/schedule.dart';
import 'package:flutter/widgets.dart';

class Customer {
  final String uid;
  final String name;
  final String email;
  final String phonenumber;
  final int absences;
  List<Schedule> closedbookings;
  List<Schedule> openbookings;

  Customer({
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.phonenumber,
    this.absences = 0,
  });
}
