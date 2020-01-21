import 'package:flutter/foundation.dart';

enum Service { Basic, Bootcamp, Premium, Razor, Dye }

class Schedule {
  final String id;
  final Service service;
  final DateTime starttime;
  final String barberid;
  final String customerid;
  final String shopid;
  Duration duration;

  Schedule({
    @required this.id,
    @required this.service,
    @required this.starttime,
    @required this.barberid,
    @required this.customerid,
    @required this.shopid,
    this.duration = const Duration(minutes: 30),
  });

  DateTime get endtime => starttime.add(duration);
}
