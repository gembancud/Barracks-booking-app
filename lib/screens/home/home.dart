import 'package:barracks_app/models/shop.dart';
import 'package:barracks_app/screens/home/shopsview.dart';
import 'package:barracks_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:barracks_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Shop>>.value(
      value: DatabaseService().shops,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Barracks'),
        ),
        body: Center(
          child: ShopView(),
        ),
      ),
    );
  }
}
