import 'package:barracks_app/models/shop.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:provider/provider.dart';

class BookingHeaderDelegate implements SliverPersistentHeaderDelegate {
  final double minExtent;
  final double maxExtent;
  final String shopid;

  BookingHeaderDelegate(
      {this.minExtent, @required this.maxExtent, @required this.shopid});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final _shops = Provider.of<List<Shop>>(context);
    final Shop _shop = _shops.where((shop) {
      return shop.id == shopid;
    }) as Shop;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Hero(
          tag: 'ShopImageTag',
          child: CachedNetworkImage(
            fadeInCurve: Curves.easeInCubic,
            fadeOutCurve: Curves.easeInCubic,
            fadeInDuration: const Duration(milliseconds: 150),
            placeholderFadeInDuration: const Duration(milliseconds: 150),
            fadeOutDuration: const Duration(milliseconds: 150),
            imageUrl: _shop.imgUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
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
