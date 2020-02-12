import 'package:barracks_app/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarracksMyBookingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myschedules = Provider.of<List<Schedule>>(context);
    return CustomScrollView(
      slivers: <Widget>[
        buildMyBookingsAppBar(),
        SliverList(
          delegate: SliverChildBuilderDelegate((ctx, idx) {}),
        )
      ],
    );
  }

  SliverAppBar buildMyBookingsAppBar() {
    return SliverAppBar(
      floating: true,
      // pinned: true,
      elevation: 10.0,
      forceElevated: true,
      backgroundColor: Colors.black,
      title: Center(child: Text('My Bookings')),
    );
  }
}
