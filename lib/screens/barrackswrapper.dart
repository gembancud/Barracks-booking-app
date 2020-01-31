import 'package:barracks_app/models/customer.dart';
import 'package:barracks_app/screens/authenticate/authenticate.dart';
import 'package:barracks_app/screens/home/barracks/barracksmenu.dart';
import 'package:barracks_app/screens/home/barracks/barracksnavigator.dart';
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
      return ChangeNotifierProvider<BarracksNavigator>(
        create: (_) => BarracksNavigator(),
        child: BarracksMenu(),
      );
    }
  }
}
