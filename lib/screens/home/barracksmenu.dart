import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/screens/home/barracksappbar.dart';
import 'package:barracks_app/screens/home/barracksbottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class BarracksMenu extends StatelessWidget {
  static const Color BackgroundGradientStart = const Color(0xFFeef2f3);
  static const Color BackgroundGradientEnd = const Color(0xFF8e9eab);
  @override
  Widget build(BuildContext context) {
    final _shops = Provider.of<List<Shop>>(context);
    for (Shop shop in _shops) print(shop.name);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/barracks_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            BarracksAppbar(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, idx) {
                  return StickyHeader(
                    header: Text(_shops[idx].name),
                    content: Container(
                      child: (Text(_shops[idx].id)),
                    ),
                  );
                },
                childCount: _shops.length,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BarracksBottomNavigationBar(),
    );
  }
}
