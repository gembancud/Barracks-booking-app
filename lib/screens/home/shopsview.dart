import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/screens/home/bookingmenu/bookingmenu.dart';
import 'package:barracks_app/screens/home/bookingmenu/bookingmenunotifier.dart';
import 'package:barracks_app/shared/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  final menu = Provider.of<BookingMenuNotifier>(context);

  return TransformerPageView(
    loop: true,
    viewportFraction: 0.8,
    itemCount: shops.length,
    onPageChanged: (page) {
      menu.setPageNumber = page;
    },
    transformer:
        new PageTransformerBuilder(builder: (Widget child, TransformInfo info) {
      return new Padding(
        padding: new EdgeInsets.all(30.0),
        child: new Material(
          elevation: 4.0,
          textStyle: new TextStyle(color: Colors.white),
          borderRadius: new BorderRadius.circular(10.0),
          child: new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              // new ParallaxContainer(
              //   child: CachedNetworkImage(
              //     imageUrl: shops[info.index].imgUrl,
              //     placeholder: (context, url) => SpinKitDoubleBounce(),
              //     errorWidget: (context, url, error) => Icon(Icons.error),
              //     fit: BoxFit.cover,
              //     alignment: FractionalOffset(0.5 + info.position * 0.3, 0.5),
              //   ),
              //   position: info.position,
              // ),
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
                      child: new RaisedButton(
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
              ParallaxContainer(
                child: new BookingMenu(),
                position: info.position,
              ),
            ],
          ),
        ),
      );
    }),
  );
}
