import 'package:barracks_app/models/barber.dart';
import 'package:barracks_app/models/customer.dart';
import 'package:barracks_app/models/schedule.dart';
import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/screens/home/(unused)bookingmenu/bookingmenunotifier.dart';
import 'package:barracks_app/services/database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingList extends StatefulWidget {
  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  String weekday(day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
    }
  }

  @override
  Widget build(BuildContext context) {
    final _customer = Provider.of<Customer>(context);
    final _notifier = Provider.of<BookingMenuNotifier>(context);
    final _shops = Provider.of<List<Shop>>(context);
    final _barbers = Provider.of<List<Barber>>(context);
    final _schedules = Provider.of<List<Schedule>>(context) ?? [];
    final _barberslist = _shops[_notifier.getpageNumber].barbers;
    final _shop = _shops[_notifier.getpageNumber];
    return Container(
        child: ListView.builder(
      itemCount: _barberslist.length,
      itemBuilder: (ctx, idx) {
        final _barber = _barbers.singleWhere((barber) {
          return barber.id == _barberslist[idx];
        });
        final List<Schedule> _schedule = _schedules.where((schedule) {
          return (schedule.barberid == _barber.id &&
              !schedule.isEnded &&
              schedule.isToday);
        }).toList();
        return ExpansionTile(
          leading: CachedNetworkImage(
            imageUrl: _barber.imgUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          title: Text(_barber.name),
          subtitle: Text('Dayoff: ${weekday(_barber.dayoff)}'),
          children: <Widget>[
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: _schedule.length,
            //     itemBuilder: (ctx, idx) {
            //       return ListTile(
            //         title: Text(
            //             DateFormat('MMMEd').format(_schedule[idx].starttime)),
            //       );
            //     },
            //   ),
            // ),
            Container(
              child: Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text('Enlist'),
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        maxTime: DateTime.now().add(const Duration(days: 30)),
                        currentTime: DateTime.now(),
                        locale: LocaleType.en,
                        onConfirm: (date) async {
                          try {
                            final docId = await DatabaseService()
                                .BookSchedule(_customer, _barber, _shop, date);
                            print('Added $docId');
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    ));
  }
}
