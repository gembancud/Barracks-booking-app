import 'package:barracks_app/screens/shopbooking/bookingheaderdelegate.dart';
import 'package:flutter/material.dart';

class BarracksBookingScreen extends StatelessWidget {
  static const routeName = '/BarracksBookingScreen';

  @override
  Widget build(BuildContext context) {
    final _shopId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: BookingHeaderDelegate(
                  minExtent: 80, maxExtent: 250, shopid: _shopId),
            ),
            SliverFillRemaining(
              child: Center(
                child: Text('bilat'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
