import 'package:barracks_app/models/barber.dart';
import 'package:barracks_app/models/schedule.dart';
import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/screens/home/barracksmenu.dart';
import 'package:barracks_app/screens/home/bookingmenu/bookingmenunotifier.dart';
import 'package:barracks_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:barracks_app/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Shop>>.value(
          value: DatabaseService().shops,
        ),
        StreamProvider<List<Barber>>.value(
          value: DatabaseService().barbers,
        ),
        StreamProvider<List<Schedule>>.value(
          value: DatabaseService().userschedules,
        ),
        // ChangeNotifierProvider<BookingMenuNotifier>(
        //   create: (ctx) => BookingMenuNotifier(),
        // )
      ],
      child: BarracksMenu(),
    );
  }
}
