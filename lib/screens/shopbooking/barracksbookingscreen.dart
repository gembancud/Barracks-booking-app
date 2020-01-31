import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/screens/shopbooking/bookingheaderdelegate.dart';
import 'package:flutter/material.dart';

class BarracksBookingScreen extends StatelessWidget {
  static const routeName = '/BarracksBookingScreen';

  @override
  Widget build(BuildContext context) {
    final shop = ModalRoute.of(context).settings.arguments as Shop;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: BookingHeaderDelegate(
                  minExtent: 80, maxExtent: 250, shop: shop),
            ),
            SliverFillRemaining(
                child: Column(
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
            ))
          ],
        ),
      ),
    );
  }
}
