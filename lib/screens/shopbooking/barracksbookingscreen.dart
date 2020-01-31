import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/screens/shopbooking/barracksbookingbarberbuilder.dart';
import 'package:barracks_app/screens/shopbooking/barracksbookingcontent.dart';
import 'package:barracks_app/screens/shopbooking/bookingheaderdelegate.dart';
import 'package:flutter/material.dart';

class BarracksBookingScreen extends StatelessWidget {
  static const routeName = '/BarracksBookingScreen';

  @override
  Widget build(BuildContext context) {
    final shop = ModalRoute.of(context).settings.arguments as Shop;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/barracks_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: BookingHeaderDelegate(
                  minExtent: 80, maxExtent: 250, shop: shop),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Schedules',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((ctx, idx) {
                return BarracksBookingBarberBuilder(idx, shop);
              }, childCount: shop.barbers.length),
            )
            // SliverFillRemaining(child: BarracksBookingContent(shop)),
          ],
        ),
      ),
      // bottomNavigationBar: BarracksBottomNavigationBar(),
    );
  }
}
