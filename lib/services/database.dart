import 'package:barracks_app/models/barber.dart';
import 'package:barracks_app/models/schedule.dart';
import 'package:barracks_app/models/shop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //Customer collection reference
  final CollectionReference customerCollection =
      Firestore.instance.collection('customer');

  Future updateCustomerData(
      String name, String email, String phonenumber, int absences) async {
    return await customerCollection.document(uid).setData({
      'name': name,
      'email': email,
      'phonenumber': phonenumber,
      'absences': absences,
    });
  }

  Stream<QuerySnapshot> get customers {
    return customerCollection.snapshots();
  }

  //Shop Collection Reference
  final CollectionReference shopCollection =
      Firestore.instance.collection('shops');

  Stream<List<Shop>> get shops {
    return shopCollection.snapshots().map(_shopListfromQuerySnapshot);
  }

  List<Shop> _shopListfromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Shop(
        id: doc.documentID,
        name: doc.data['name'],
        imgUrl: doc.data['imgUrl'],
        lat: doc.data['lat'],
        long: doc.data['long'],
        barbers: List.from(doc.data['barbers']),
      );
    }).toList();
  }

  //Barbers Collection Reference
  final CollectionReference barberCollection =
      Firestore.instance.collection('barbers');

  Stream<List<Barber>> get barbers {
    return shopCollection.snapshots().map(_barberListfromQuerySnapshot);
  }

  List<Barber> _barberListfromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Barber(
        id: doc.documentID,
        name: doc.data['name'],
        imgUrl: doc.data['imgUrl'],
        branch: doc.data['branch'],
        dayoff: doc.data['dayoff'],
        schedule: List.from(doc.data['schedule']),
      );
    }).toList();
  }

  //Schedule Collection Reference
  final CollectionReference scheduleCollection =
      Firestore.instance.collection('schedule');

  Stream<List<Schedule>> get schedules {
    return scheduleCollection.snapshots().map(_scheduleListfromQuerySnapshot);
  }

  List<Schedule> _scheduleListfromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Schedule(
        id: doc.documentID,
        service: doc.data['service'],
        starttime: doc.data['starttime'],
        barberid: doc.data['barberid'],
        customerid: doc.data['customerid'],
        shopid: doc.data['shopid'],
      );
    }).toList();
  }
}
