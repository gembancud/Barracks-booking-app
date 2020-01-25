import 'package:barracks_app/models/schedule.dart';
import 'package:flutter/widgets.dart';

class Customer {
  final String id;
  final String name;
  final String email;
  final String phonenumber;
  final int absences;
  List<String> bookings = [];

  Customer({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.phonenumber,
    this.absences = 0,
  });
}
