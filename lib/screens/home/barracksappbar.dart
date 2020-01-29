import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BarracksAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      // pinned: true,
      elevation: 10.0,
      forceElevated: true,
      backgroundColor: Colors.black,
      leading: Icon(
        FontAwesomeIcons.shieldAlt,
        color: Colors.grey,
      ),
      title: Row(
        children: <Widget>[
          FlatButton(
            child: Text(
              'BARRACKS',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {},
          ),
          FlatButton(
            child: Text(
              'ARMORY',
              style: TextStyle(
                  color: Colors.red[100],
                  decoration: TextDecoration.lineThrough),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
