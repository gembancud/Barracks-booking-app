import 'package:barracks_app/models/shop.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:url_launcher/url_launcher.dart';

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
                child: Center(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Center(
                        child: Text(_shops[idx].name,
                            style: TextStyle(
                                fontSize: 20,
                                color:
                                    Colors.black.withOpacity(1 - stuckAmount))),
                      ),
                      Center(
                        child: Text(_shops[idx].name,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white.withOpacity(stuckAmount))),
                      )
                    ],
                  ),
                ),
              );
            },
            content: Column(
              children: <Widget>[
                Card(
                  elevation: 4.0,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 70),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(
                          imageUrl: _shops[idx].imgUrl,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          OutlineButton(
                            child: const Text('Book Here',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14)),
                            onPressed: () {},
                          ),
                          OutlineButton(
                            child: const Text(
                              'Get Directions',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            onPressed: () {},
                          ),
                          OutlineButton(
                            child: const Text(
                              'Contact Us',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            onPressed: () async {
                              try {
                                print('calling ${_shops[idx].phonenumber}');
                                launch('tel://${_shops[idx].phonenumber}');
                              } catch (e) {
                                print(e.toString());
                              }
                            },
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
