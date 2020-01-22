import 'package:barracks_app/models/customer.dart';
import 'package:barracks_app/screens/authenticate/authenticate.dart';
import 'package:barracks_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<Customer>(context);
    if (customer != null) {
      print('Customer details:');
      print(customer.name);
      print(customer.email);
    }
    if (customer == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
