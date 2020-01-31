import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/screens/barrackswrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BookingHeaderDelegate implements SliverPersistentHeaderDelegate {
  final double minExtent;
  final double maxExtent;
  final Shop shop;

  BookingHeaderDelegate(
      {this.minExtent, @required this.maxExtent, @required this.shop});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Hero(
          tag: 'ShopImageTag' + shop.id,
          child: CachedNetworkImage(
            imageUrl: shop.imgUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Positioned(
          right: 16.0,
          bottom: 16.0,
          child: Hero(
            tag: 'ShopHeaderTag' + shop.id,
            child: Container(
              decoration: BoxDecoration(color: Colors.black54),
              child: Text(shop.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
            ),
          ),
        ),
        Positioned(
          left: 16.0,
          bottom: 10.0,
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              // Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        )
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  // TODO: implement snapConfiguration
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
