import 'package:barracks_app/models/shop.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                    style: TextStyle(
                      color: Colors.black.withOpacity(1 - stuckAmount),
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            },
            content: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 70),
                      CachedNetworkImage(
                        imageUrl: _shops[idx].imgUrl,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            child: Text('Book Here'),
                            onPressed: () {},
                          ),
                          FlatButton(
                            child: Text('Get Directions'),
                            onPressed: () {},
                          ),
                          FlatButton(
                            child: Text('Contact Us'),
                            onPressed: () {},
                          ),
                        ],
                      ),
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
