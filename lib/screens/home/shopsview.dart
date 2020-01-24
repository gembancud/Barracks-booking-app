import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/screens/home/bookingmenu.dart';
import 'package:barracks_app/screens/home/bookingmenunotifier.dart';
import 'package:barracks_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class ShopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shops = Provider.of<List<Shop>>(context);
    if (shops == null)
      return Loading();
    else
      return _buildTransformerPageView(context);
  }
}

Widget _buildTransformerPageView(BuildContext context) {
  final shops = Provider.of<List<Shop>>(context);
  return TransformerPageView(
    loop: false,
    viewportFraction: 0.8,
    itemCount: shops.length,
    transformer:
        new PageTransformerBuilder(builder: (Widget child, TransformInfo info) {
      return new Padding(
        padding: new EdgeInsets.all(20.0),
        child: new Material(
          elevation: 4.0,
          textStyle: new TextStyle(color: Colors.white),
          borderRadius: new BorderRadius.circular(10.0),
          child: new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              new ParallaxImage.cachednetwork(
                shops[info.index].imgUrl,
                position: info.position,
              ),
              new Positioned(
                left: 10.0,
                right: 10.0,
                bottom: 10.0,
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new ParallaxContainer(
                      child: new Text(
                        shops[info.index].name,
                        style: new TextStyle(fontSize: 15.0),
                      ),
                      position: info.position,
                      translationFactor: 300.0,
                    ),
                    new SizedBox(
                      height: 8.0,
                    ),
                    new ParallaxContainer(
                      child: new FlatButton(
                        child: Text(
                          'Book Here',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Provider.of<BookingMenuNotifier>(context,
                                  listen: false)
                              .togglemenu();
                        },
                      ),
                      position: info.position,
                      translationFactor: 200.0,
                    ),
                  ],
                ),
              ),
              new BookingMenu(),
            ],
          ),
        ),
      );
    }),
  );
}
