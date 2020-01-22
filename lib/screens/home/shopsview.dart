import 'package:barracks_app/models/shop.dart';
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
    loop: true,
    viewportFraction: 0.8,
    itemCount: shops.length,
    transformer:
        new PageTransformerBuilder(builder: (Widget child, TransformInfo info) {
      return new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Material(
          elevation: 4.0,
          textStyle: new TextStyle(color: Colors.white),
          borderRadius: new BorderRadius.circular(10.0),
          child: new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              new ParallaxImage.network(
                // images[info.index],
                shops[info.index].imgUrl,
                position: info.position,
              ),
              // new DecoratedBox(
              //   decoration: new BoxDecoration(
              //     gradient: new LinearGradient(
              //       begin: FractionalOffset.bottomCenter,
              //       end: FractionalOffset.topCenter,
              //       colors: [
              //         const Color(0xFF000000),
              //         const Color(0x33FFC0CB),
              //       ],
              //     ),
              //   ),
              // ),
              new Positioned(
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new ParallaxContainer(
                      child: new Text(
                        // text0[info.index],
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
                      child: new Text(shops[info.index].id,
                          style: new TextStyle(fontSize: 18.0)),
                      position: info.position,
                      translationFactor: 200.0,
                    ),
                  ],
                ),
                left: 10.0,
                right: 10.0,
                bottom: 10.0,
              )
            ],
          ),
        ),
      );
    }),
  );
}
