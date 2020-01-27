import 'package:barracks_app/screens/home/barracksappbar.dart';
import 'package:barracks_app/screens/home/barracksbottomnavigationbar.dart';
import 'package:flutter/material.dart';

class BarracksMenu extends StatelessWidget {
  static const Color BackgroundGradientStart = const Color(0xFFeef2f3);
  static const Color BackgroundGradientEnd = const Color(0xFF8e9eab);
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.black, //or set color with: Color(0xFF0000FF)
    // ));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/barracks_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            BarracksAppbar(),
            // SliverFixedExtentList()
          ],
        ),
      ),
      bottomNavigationBar: BarracksBottomNavigationBar(),
    );
  }
}
