import 'package:barracks_app/models/customer.dart';
import 'package:barracks_app/screens/wrapper.dart';
import 'package:barracks_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Customer>.value(
      value: AuthService().customer,
      child: MaterialApp(
        title: 'Barracks App',
        home: Wrapper(),
      ),
    );
  }
}
