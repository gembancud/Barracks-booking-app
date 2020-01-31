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

class BarracksBookingBarberBuilder extends StatelessWidget {
  final int barberindex;
  final Shop shop;
  BarracksBookingBarberBuilder(this.barberindex, this.shop);

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
    //checks if there is an overlap in the schedule to the query request
    return schedules.every((schedule) =>
        !(schedule.starttime.isBefore(query.add(const Duration(minutes: 30))) &&
            schedule.endtime.isAfter(query)));
  }

  @override
  Widget build(BuildContext context) {
    final _customer = Provider.of<Customer>(context);
    final _barbers = Provider.of<List<Barber>>(context);
    final List<Schedule> _schedules = Provider.of<List<Schedule>>(context);
    print('all schedules:');
    for (var sched in _schedules) print(sched.id);

    if (_customer == null || _barbers == null || _schedules == null)
      return Loading();

    final _barber = _barbers[barberindex];
    final List<Schedule> _schedule = _schedules.where((schedule) {
      return (schedule.barberid == _barber.id && !schedule.isEnded
          // &&schedule.isToday
          );
    }).toList();
    print('Scheds of ${_barber.name}:');
    for (Schedule sched in _schedule) print(sched.id);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 10.0,
      color: Colors.white,
      child: ExpansionTile(
        leading: CachedNetworkImage(
          imageUrl: _barber.imgUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        title: Text(_barber.name),
        subtitle: Text('Dayoff: ${weekday(_barber.dayoff)}'),
        children: <Widget>[
          buildEmptyChoice(_schedule),
          ...buildListView(_schedule),
          Container(
            child: Row(
              children: <Widget>[
                RaisedButton(
                  child: Text('Enlist'),
                  onPressed: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime.now().add(const Duration(days: 30)),
                      currentTime: DateTime.now(),
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
                                  .BookSchedule(_customer, _barber, shop, date);
                              print('Added $docId');

                              print('May net!');
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

  Widget buildEmptyChoice(List<Schedule> _schedule) {
    if (_schedule.isEmpty)
      return Center(
        child: Text('No Schedule to Display'),
      );
    else
      return SizedBox(
        height: 0,
      );
  }

  List<ListTile> buildListView(List<Schedule> _schedule) {
    return _schedule.map((sched) {
      return ListTile(
        title: Text(
            'From ${new DateFormat.jm().format(sched.starttime)} to ${new DateFormat.jm().format(sched.endtime)}'),
        subtitle: Text(new DateFormat.MMMEd().format(sched.starttime)),
      );
    }).toList();
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
