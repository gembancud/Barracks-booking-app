import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/screens/shopbooking/barracksbookingscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:url_launcher/url_launcher.dart';

class BarracksShopsList extends StatefulWidget {
  @override
  _BarracksShopsListState createState() => _BarracksShopsListState();
}

class _BarracksShopsListState extends State<BarracksShopsList> {
  void _selectShop(BuildContext ctx, Shop shop) {
    Navigator.of(ctx).pushNamed(
      BarracksBookingScreen.routeName,
      arguments: shop,
    );
  }

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
              return _buildBarracksStickyHeader(stuckAmount, _shops, idx);
            },
            content: Column(
              children: <Widget>[
                Card(
                  elevation: 5.0,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage("assets/img/barracks_background3.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 70),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Hero(
                            tag: 'ShopImageTag' + _shops[idx].id,
                            child: CachedNetworkImage(
                              imageUrl: _shops[idx].imgUrl,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            OutlineButton(
                              splashColor: Colors.grey[500],
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    FontAwesomeIcons.book,
                                    color: Colors.white60,
                                  ),
                                  const Text(' Book Here',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14)),
                                ],
                              ),
                              onPressed: () async {
                                _selectShop(context, _shops[idx]);
                              },
                            ),
                            OutlineButton(
                              splashColor: Colors.grey[500],
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    FontAwesomeIcons.mapMarkerAlt,
                                    color: Colors.white60,
                                  ),
                                  const Text(
                                    ' Find Us',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ],
                              ),
                              onPressed: () async {
                                if (await MapLauncher.isMapAvailable(
                                    MapType.google)) {
                                  await MapLauncher.launchMap(
                                    mapType: MapType.google,
                                    coords: Coords(
                                        double.parse(_shops[idx].lat),
                                        double.parse(_shops[idx].long)),
                                    title: _shops[idx].name,
                                    description:
                                        'Barracks Barbers & Shaves Co.',
                                  );
                                }
                              },
                            ),
                            OutlineButton(
                              splashColor: Colors.grey[500],
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    FontAwesomeIcons.phone,
                                    color: Colors.white60,
                                  ),
                                  const Text(
                                    ' Call Us',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ],
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

  Container _buildBarracksStickyHeader(
      double stuckAmount, List<Shop> _shops, int idx) {
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
                      color: Colors.black.withOpacity(1 - stuckAmount))),
            ),
            Hero(
              tag: 'ShopHeaderTag' + _shops[idx].id,
              child: Center(
                child: Text(_shops[idx].name,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white.withOpacity(stuckAmount))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
