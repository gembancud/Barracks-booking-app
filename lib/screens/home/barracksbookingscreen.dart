import 'dart:js';

import 'package:flutter/material.dart';

class BarracksBookingScreen extends StatelessWidget {
  static const routeName = '/BarracksBookingScreen';

  @override
  Widget build(BuildContext context) {
    final _shopId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      body: Container(
        child: CustomScrollView(),
      ),
    );
  }
}
