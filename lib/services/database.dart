import 'package:barracks_app/models/barber.dart';
import 'package:barracks_app/models/shop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //Customer collection reference
  final CollectionReference customerCollection =
      Firestore.instance.collection('customer');
  //
  Future updateCustomerData(
      String name, String phonenumber, int absences) async {
    return await customerCollection.document(uid).setData({
      'name': name,
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
        id: uid,
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
        id: uid,
        name: doc.data['name'],
        imgUrl: doc.data['imgUrl'],
        branch: doc.data['branch'],
        dayoff: doc.data['dayoff'],
        schedule: List.from(doc.data['schedule']),
      );
    }).toList();
  }
}
