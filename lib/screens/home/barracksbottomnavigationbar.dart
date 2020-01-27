import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BarracksBottomNavigationBar extends StatefulWidget {
  @override
  _BarracksBottomNavigationBarState createState() =>
      _BarracksBottomNavigationBarState();
}

class _BarracksBottomNavigationBarState
    extends State<BarracksBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      backgroundColor: Colors.black,
      itemCornerRadius: 0,
      selectedIndex: _selectedIndex,
      curve: Curves.easeOutQuad,
      animationDuration: const Duration(milliseconds: 150),
      showElevation: false, // use this to remove appBar's elevation
      onItemSelected: (index) => setState(() {
        _selectedIndex = index;
      }),
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
    );
  }
}
