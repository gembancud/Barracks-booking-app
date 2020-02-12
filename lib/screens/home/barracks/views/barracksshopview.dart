import 'package:barracks_app/screens/home/barracks/barracksappbar.dart';
import 'package:barracks_app/screens/home/barracks/barracksshoplist.dart';
import 'package:flutter/material.dart';

class BarracksShopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        BarracksShopAppbar(),
        SliverToBoxAdapter(child: SizedBox(height: 10)),
        BarracksShopsList()
      ],
    );
  }
}
