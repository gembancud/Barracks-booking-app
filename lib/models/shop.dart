import 'package:barracks_app/models/barber.dart';
import 'package:flutter/foundation.dart';

class Shop {
  final String id;
  final String name;
  final String imgUrl;
  final String lat;
  final String long;
  final String phonenumber;
  final List<String> barbers;

  const Shop({
    @required this.id,
    @required this.name,
    @required this.imgUrl,
    @required this.lat,
    @required this.long,
    @required this.phonenumber,
    @required this.barbers,
  });
}
