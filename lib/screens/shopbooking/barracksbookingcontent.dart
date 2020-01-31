import 'package:barracks_app/models/barber.dart';
import 'package:barracks_app/models/customer.dart';
import 'package:barracks_app/models/schedule.dart';
import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/services/database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BarracksBookingContent extends StatelessWidget {
  final Shop shop;
  BarracksBookingContent(this.shop);

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
    final _barbers = Provider.of<List<Barber>>(context);
    final _schedules = Provider.of<List<Schedule>>(context) ?? [];
    final _barberslist = shop.barbers;
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
            Expanded(
              child: ListView.builder(
                itemCount: _schedule.length,
                itemBuilder: (ctx, idx) {
                  return ListTile(
                    title: Text(
                        DateFormat('MMMEd').format(_schedule[idx].starttime)),
                  );
                },
              ),
            ),
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
                            Flushbar(
                              message: 'Checking your Internet Connection',
                              icon: Icon(
                                Icons.info_outline,
                                size: 28.0,
                                color: Colors.white,
                              ),
                              duration: Duration(seconds: 3),
                              leftBarIndicatorColor: Colors.white,
                            )..show(context);
                            bool result =
                                await DataConnectionChecker().hasConnection;
                            if (result == true) {
                              final docId = await DatabaseService()
                                  .BookSchedule(_customer, _barber, shop, date);
                              print('Added $docId');
                              if (docId != null) {
                                Flushbar(
                                  message: 'Successfully Added Schedule',
                                  icon: Icon(
                                    Icons.info_outline,
                                    size: 28.0,
                                    color: Colors.green[300],
                                  ),
                                  duration: Duration(seconds: 3),
                                  leftBarIndicatorColor: Colors.green[300],
                                )..show(context);
                              }
                            } else {
                              print(DataConnectionChecker().lastTryResults);
                              Flushbar(
                                message:
                                    'Unable to book without Internet Connection',
                                icon: Icon(
                                  Icons.info_outline,
                                  size: 28.0,
                                  color: Colors.red[300],
                                ),
                                duration: Duration(seconds: 3),
                                leftBarIndicatorColor: Colors.red[300],
                              )..show(context);
                            }
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
