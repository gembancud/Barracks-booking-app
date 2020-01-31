import 'package:barracks_app/models/shop.dart';
import 'package:flutter/material.dart';

class BarracksBookingContent extends StatelessWidget {
  final Shop shop;
  BarracksBookingContent(this.shop);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Text(
            'Schedules:',
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
        )
      ],
    );
  }
}
