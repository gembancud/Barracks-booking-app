import 'package:barracks_app/screens/home/bookingmenu/bookinglist.dart';
import 'package:barracks_app/screens/home/bookingmenu/bookingmenunotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingMenu extends StatefulWidget {
  @override
  _BookingMenuState createState() => _BookingMenuState();
}

class _BookingMenuState extends State<BookingMenu> {
  @override
  Widget build(BuildContext context) {
    final _notifier = Provider.of<BookingMenuNotifier>(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: _notifier.isOpen
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey.shade200.withOpacity(0.8),
              ),
              key: ValueKey(1),
              margin: EdgeInsets.symmetric(vertical: 45.0, horizontal: 20),
              child: BookingList(),
            )
          : Container(
              key: ValueKey(2),
              height: 0,
            ),
    );
  }
}
