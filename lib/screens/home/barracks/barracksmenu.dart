import 'package:barracks_app/models/customer.dart';
import 'package:barracks_app/models/schedule.dart';
import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/screens/home/barracks/barracksappbar.dart';
import 'package:barracks_app/screens/home/barracks/barracksbottomnavigationbar.dart';
import 'package:barracks_app/screens/home/barracks/barracksnavigator.dart';
import 'package:barracks_app/screens/home/barracks/barracksshoplist.dart';
import 'package:barracks_app/services/database.dart';
import 'package:barracks_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarracksMenu extends StatelessWidget {
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
              CustomScrollView(
                slivers: <Widget>[
                  BarracksAppbar(),
                  SliverToBoxAdapter(child: SizedBox(height: 10)),
                  BarracksShopsList()
                ],
              ),
              StreamProvider<List<Schedule>>.value(
                value: DatabaseService(uid: customer.id).personalschedules,
                child: Container(
                  color: Colors.green,
                ),
              ),
              Container(
                color: Colors.blue,
              ),
              Container(
                color: Colors.red,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BarracksBottomNavigationBar(),
      );
  }
}
