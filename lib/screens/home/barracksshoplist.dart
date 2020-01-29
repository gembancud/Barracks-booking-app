import 'dart:js';

import 'package:barracks_app/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

class BarracksShopsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _shops = Provider.of<List<Shop>>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, idx) {
          return StickyHeaderBuilder(
            overlapHeaders: true,
            builder: (BuildContext context, double stuckAmount) {
              stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
              return new Container(
                height: 70.0 + 10 * stuckAmount,
                color: Colors.black.withOpacity(stuckAmount),
                padding: new EdgeInsets.only(bottom: 10, top: stuckAmount * 30),
                alignment: Alignment.center,
                child: Container(
                  child: Text(
                    _shops[idx].name,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
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
    );
  }
}
