import 'package:barracks_app/screens/home/bookingmenunotifier.dart';
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
    return _notifier.isOpen
        ? Center(child: Text('Booking menu'))
        : Container(
            height: 0,
          );
  }
}
