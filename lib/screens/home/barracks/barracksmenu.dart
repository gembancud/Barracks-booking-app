import 'package:barracks_app/models/customer.dart';
import 'package:barracks_app/models/schedule.dart';
import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/screens/home/barracks/barracksappbar.dart';
import 'package:barracks_app/screens/home/barracks/barracksbottomnavigationbar.dart';
import 'package:barracks_app/screens/home/barracks/barracksnavigator.dart';
import 'package:barracks_app/screens/home/barracks/barracksshoplist.dart';
import 'package:barracks_app/screens/home/barracks/views/barracksmybookingsview.dart';
import 'package:barracks_app/screens/home/barracks/views/barracksshopview.dart';
import 'package:barracks_app/services/auth.dart';
import 'package:barracks_app/services/database.dart';
import 'package:barracks_app/shared/loading.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarracksMenu extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final _shops = Provider.of<List<Shop>>(context);
    final navigator = Provider.of<BarracksNavigator>(context);
    final customer = Provider.of<Customer>(context);

    if (_shops == null)
      return Loading();
    else
      // for (Shop shop in _shops) print(shop.name);

      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/barracks_background2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: PageView(
            controller: navigator.getPageController,
            onPageChanged: (index) {
              navigator.setPageIndex(index);
            },
            children: <Widget>[
              BarracksShopView(),
              StreamProvider<List<Schedule>>.value(
                  value: DatabaseService(uid: customer.id).personalschedules,
                  child: BarracksMyBookingsView()),
              Container(
                color: Colors.blue,
              ),
              Container(
                child: Center(
                  child: RaisedButton(
                    child: Text('Logout'),
                    onPressed: () async {
                      try {
                        dynamic result = await _auth.signOut();
                        showFlushbar(
                            context, 'Logged Out Successfully', Colors.white);
                      } catch (e) {
                        print(e.toString());
                        showFlushbar(context, 'Failed to Log out', Colors.red);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BarracksBottomNavigationBar(),
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
