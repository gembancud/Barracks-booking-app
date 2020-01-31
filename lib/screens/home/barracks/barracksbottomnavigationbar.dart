import 'package:barracks_app/screens/home/barracks/barracksnavigator.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BarracksBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigator = Provider.of<BarracksNavigator>(context);

    return Hero(
      tag: 'BarracksBottomNavigation',
      child: BottomNavyBar(
        backgroundColor: Colors.black,
        itemCornerRadius: 0,
        selectedIndex: navigator.getIndex,
        curve: Curves.easeOutQuad,
        animationDuration: const Duration(milliseconds: 150),
        showElevation: false, // use this to remove appBar's elevation
        onItemSelected: (index) {
          navigator.setPageIndex(index);
        },
        items: [
          BottomNavyBarItem(
              icon: Icon(FontAwesomeIcons.home),
              title: Text('SHOPS'),
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
              textAlign: TextAlign.center),
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.calendarAlt),
            title: Text('BOOKINGS'),
            activeColor: Colors.white,
            inactiveColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('MESSAGES'),
            activeColor: Colors.white,
            inactiveColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('MORE'),
            activeColor: Colors.white,
            inactiveColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
