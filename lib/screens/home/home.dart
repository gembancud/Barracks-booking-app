import 'package:barracks_app/models/barber.dart';
import 'package:barracks_app/models/schedule.dart';
import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/screens/home/menu.dart';
import 'package:barracks_app/screens/home/shopsview.dart';
import 'package:barracks_app/services/auth.dart';
import 'package:barracks_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:barracks_app/services/database.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:provider/provider.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Shop>>.value(
          value: DatabaseService().shops,
        ),
        StreamProvider<List<Barber>>.value(
          value: DatabaseService().barbers,
        ),
        StreamProvider<List<Schedule>>.value(
          value: DatabaseService().schedules,
        ),
      ],
      child: SimpleHiddenDrawer(
        menu: Menu(),
        screenSelectedBuilder: (position, controller) {
          Widget screenCurrent;
          switch (position) {
            case 0:
              screenCurrent = ShopView();
              break;
            case 1:
              screenCurrent = Loading();
              break;
          }

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    controller.toggle();
                  }),
            ),
            body: screenCurrent,
          );
        },
      ),
    );
  }
}
