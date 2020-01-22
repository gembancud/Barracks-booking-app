import 'dart:core';

import 'package:flutter/foundation.dart';

enum Service { Basic, Bootcamp, Premium, Razor, Dye }

class Schedule {
  final String id;
  final Service service;
  final DateTime starttime;
  final String barberid;
  final String customerid;
  final String shopid;

  Schedule({
    @required this.id,
    @required this.service,
    @required this.starttime,
    @required this.barberid,
    @required this.customerid,
    @required this.shopid,
  });

  DateTime get endtime => starttime.add(duration);

  Duration get duration {
    switch (service) {
      case Service.Basic:
        return Duration(minutes: 30);
      case Service.Bootcamp:
        return Duration(minutes: 30);
      case Service.Premium:
        return Duration(minutes: 30);
      case Service.Razor:
        return Duration(minutes: 30);
      case Service.Dye:
        return Duration(minutes: 30);
    }
  }
}
