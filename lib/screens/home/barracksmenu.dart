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
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, idx) {
                  return StickyHeaderBuilder(
                    overlapHeaders: true,
                    builder: (BuildContext context, double stuckAmount) {
                      stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
                      return new Container(
                        height: 70.0 + 10 * stuckAmount,
                        color: Colors.black.withOpacity(stuckAmount),
                        padding: new EdgeInsets.only(
                            bottom: 10, top: stuckAmount * 30),
                        alignment: Alignment.center,
                        child: Container(
                          child: Text(
                            _shops[idx].name,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                      );
                    },
                    content: Column(
                      children: <Widget>[
                        Card(
                          child: Column(
                            children: <Widget>[
                              Container(
                                color: Colors.blue,
                                width: double.infinity,
                                height: 120,
                              ),
                              Container(
                                color: Colors.yellow,
                                width: double.infinity,
                                child: Text(_shops[idx].id),
                                height: 360,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
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
