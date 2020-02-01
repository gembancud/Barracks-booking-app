import 'package:barracks_app/models/barber.dart';
import 'package:barracks_app/models/customer.dart';
import 'package:barracks_app/models/schedule.dart';
import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/services/database.dart';
import 'package:barracks_app/shared/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BarracksBookingBarberBuilder extends StatefulWidget {
  final int barberindex;
  final Shop shop;
  BarracksBookingBarberBuilder(this.barberindex, this.shop);

  @override
  _BarracksBookingBarberBuilderState createState() =>
      _BarracksBookingBarberBuilderState();
}

class _BarracksBookingBarberBuilderState
    extends State<BarracksBookingBarberBuilder> {
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

  bool isAvailable(Barber barber, List<Schedule> schedules, DateTime query) {
    //if it is barber's day of then false;
    if (DateTime.now().weekday == barber.dayoff) return false;

    //checks if within working hours;
    DateTime startinghour = new DateTime(query.year, query.month, query.day, 9);
    DateTime endinghour = new DateTime(query.year, query.month, query.day, 17);
    if (query.isBefore(startinghour) || query.isAfter(endinghour)) return false;

    //checks if there is an overlap in the schedule to the query request
    return schedules.every((schedule) =>
        !(schedule.starttime.isBefore(query.add(const Duration(minutes: 30))) &&
            schedule.endtime.isAfter(query)));
  }

  bool _istodayOnly = false;
  toggleToday(bool newvalue) => setState(() => _istodayOnly = newvalue);

  @override
  Widget build(BuildContext context) {
    final _customer = Provider.of<Customer>(context);
    final _barbers = Provider.of<List<Barber>>(context);
    final List<Schedule> _schedules = Provider.of<List<Schedule>>(context);
    print('all schedules:');
    for (var sched in _schedules) print(sched.id);

    if (_customer == null || _barbers == null || _schedules == null)
      return Loading();

    final _barber = _barbers[widget.barberindex];
    final List<Schedule> _schedule = _istodayOnly
        ? _schedules.where((schedule) {
            return (schedule.barberid == _barber.id && !schedule.isEnded
                // &&schedule.isToday
                );
          }).toList()
        : _schedules.where((schedule) {
            return (schedule.barberid == _barber.id &&
                !schedule.isEnded &&
                schedule.isToday);
          }).toList();

    print('Scheds of ${_barber.name}:');
    for (Schedule sched in _schedule) print(sched.id);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 10.0,
      color: Colors.grey[200],
      child: ExpansionTile(
        leading: CachedNetworkImage(
          imageUrl: _barber.imgUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        title: Text(_barber.name),
        subtitle: Text('Dayoff: ${weekday(_barber.dayoff)}'),
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _schedule.isEmpty
                ? buildEmptyChoice()
                : buildListView(_schedule),
          ),
          // buildAnimatedListView(_schedule),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Switch(
                        value: _istodayOnly,
                        onChanged: toggleToday,
                      ),
                      Text('Show All')
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text('Enlist'),
                  onPressed: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime.now().add(Duration(hours: 3)),
                      currentTime: DateTime.now().add(Duration(hours: 3)),
                      maxTime: DateTime.now().add(const Duration(days: 30)),
                      locale: LocaleType.en,
                      onConfirm: (date) async {
                        bool bookableresult =
                            await isAvailable(_barber, _schedules, date);
                        if (bookableresult == true) {
                          try {
                            showFlushbar(
                                context,
                                'Checking your Internet Connection',
                                Colors.white);

                            bool result =
                                await DataConnectionChecker().hasConnection;

                            if (result == true) {
                              dynamic docId = await DatabaseService()
                                  .BookSchedule(
                                      _customer, _barber, widget.shop, date);
                              print('Added $docId');

                              showFlushbar(
                                  context,
                                  'Successfully Added Schedule',
                                  Colors.green[300]);
                            } else {
                              print(DataConnectionChecker().lastTryResults);
                              showFlushbar(
                                  context,
                                  'Unable to book without Internet Connection',
                                  Colors.red[300]);
                            }
                          } catch (e) {
                            print(e.toString());
                          }
                        } else {
                          showFlushbar(context, 'Schedule is unbookable',
                              Colors.red[300]);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildEmptyChoice() {
    return Center(
      child: Text('No Schedule to Display'),
    );
  }

  Widget buildListView(List<Schedule> _schedule) {
    return Column(
      children: <Widget>[
        ..._schedule.map((sched) {
          return Card(
            elevation: 1,
            margin: EdgeInsets.symmetric(vertical: 2.0),
            child: ListTile(
              title: Text(
                  'From ${new DateFormat.jm().format(sched.starttime)} to ${new DateFormat.jm().format(sched.endtime)}'),
              subtitle: Text(new DateFormat.MMMEd().format(sched.starttime)),
            ),
          );
        }).toList()
      ],
    );
  }

  Flushbar<Object> showFlushbar(
      BuildContext context, String message, Color color) {
    return Flushbar(
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: color,
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: color,
    )..show(context);
  }
}
