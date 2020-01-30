import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/screens/home/barracksappbar.dart';
import 'package:barracks_app/screens/home/barracksbottomnavigationbar.dart';
import 'package:barracks_app/screens/home/barracksshoplist.dart';
import 'package:barracks_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarracksMenu extends StatelessWidget {
  static const Color BackgroundGradientStart = const Color(0xFFeef2f3);
  static const Color BackgroundGradientEnd = const Color(0xFF8e9eab);
  @override
  Widget build(BuildContext context) {
    final _shops = Provider.of<List<Shop>>(context);
    if (_shops == null)
      return Scaffold(body: Loading());
    else
      // for (Shop shop in _shops) print(shop.name);

      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/barracks_background2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: CustomScrollView(
            slivers: <Widget>[
              BarracksAppbar(),
              SliverToBoxAdapter(child: SizedBox(height: 10)),
              BarracksShopsList()
            ],
          ),
        ),
        bottomNavigationBar: BarracksBottomNavigationBar(),
      );
  }
}
