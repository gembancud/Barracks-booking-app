import 'package:barracks_app/models/barber.dart';
import 'package:barracks_app/models/customer.dart';
import 'package:barracks_app/models/schedule.dart';
import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/screens/barrackswrapper.dart';
import 'package:barracks_app/screens/home/barracksbookingscreen.dart';
import 'package:barracks_app/services/auth.dart';
import 'package:barracks_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Customer>.value(
          value: AuthService().customer,
        ),
        StreamProvider<List<Shop>>.value(
          value: DatabaseService().shops,
        ),
        StreamProvider<List<Barber>>.value(
          value: DatabaseService().barbers,
        ),
        StreamProvider<List<Schedule>>.value(
          value: DatabaseService().userschedules,
        ),
      ],
      child: MaterialApp(
        title: 'Barracks App',
        theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.grey,
        ),
        initialRoute: BarracksWrapper.routeName,
        routes: {
          BarracksWrapper.routeName: (ctx) => BarracksWrapper(),
          BarracksBookingScreen.routeName: (ctx) => BarracksBookingScreen(),
        },
      ),
    );
  }
}
