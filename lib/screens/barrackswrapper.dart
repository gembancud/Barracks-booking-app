import 'package:barracks_app/models/customer.dart';
import 'package:barracks_app/models/schedule.dart';
import 'package:barracks_app/screens/authenticate/authenticate.dart';
import 'package:barracks_app/screens/home/barracksmenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarracksWrapper extends StatelessWidget {
  static const routeName = '/BarracksWrapper';

  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<Customer>(context);
    if (customer != null) {
      print('Customer details:');
      print(customer.email);
    }

    if (customer == null) {
      return Authenticate();
    } else {
      return BarracksMenu();
    }
  }
}
