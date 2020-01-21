import 'package:barracks_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:barracks_app/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().customer,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Barracks'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Home'),
              RaisedButton(
                child: Text('Logout'),
                onPressed: () async {
                  await _auth.signOut();
                  print('Signed out');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
