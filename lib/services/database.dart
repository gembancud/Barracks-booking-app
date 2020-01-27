import 'package:barracks_app/models/barber.dart';
import 'package:barracks_app/models/customer.dart';
import 'package:barracks_app/models/schedule.dart';
import 'package:barracks_app/models/shop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //Customer collection reference
  final CollectionReference customerCollection =
      Firestore.instance.collection('customer');

  Future updateCustomerData(
      String name, String phonenumber, String email, int absences) async {
    return await customerCollection.document(uid).setData({
      'name': name,
      'email': email,
      'phonenumber': phonenumber,
      'absences': absences,
      'bookings': FieldValue.arrayUnion([])
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
    return barberCollection.snapshots().map(_barberListfromQuerySnapshot);
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

// Returns all past and current schedules from the database
// primarily for the purpose of the admin app
  Stream<List<Schedule>> get adminschedules {
    return scheduleCollection.snapshots().map(_scheduleListfromQuerySnapshot);
  }

// Returns all current schedules from the database
// Primarily for the purpose of the cusotmer booking app
  Stream<List<Schedule>> get userschedules {
    DateTime now = new DateTime.now();
    return scheduleCollection
        .where(
          'starttime',
          isGreaterThanOrEqualTo: new DateTime(now.year, now.month, now.day),
        )
        .snapshots()
        .map(_scheduleListfromQuerySnapshot);
  }

  List<Schedule> _scheduleListfromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Schedule(
        id: doc.documentID,
        service: doc.data['service'],
        starttime: doc.data['starttime'],
        bookdate: doc.data['bookdate'],
        barberid: doc.data['barberid'],
        customerid: doc.data['customerid'],
        shopid: doc.data['shopid'],
      );
    }).toList();
  }

  Future BookSchedule(
      Customer customer, Barber barber, Shop shop, DateTime starttime) async {
    try {
      DocumentReference sched = await scheduleCollection.add({
        'service': 0,
        'starttime': starttime,
        'bookdate': DateTime.now(),
        'customerid': customer.id,
        'barberid': barber.id,
        'shopid': shop.id,
      });
      scheduleCollection
          .document(sched.documentID)
          .updateData({'id': sched.documentID});

      customer.bookings.add(sched.documentID);
      customerCollection
          .document(customer.id)
          .updateData({'bookings': FieldValue.arrayUnion(customer.bookings)});

      barber.schedule.add(sched.documentID);
      barberCollection
          .document(barber.id)
          .updateData({'schedule': FieldValue.arrayUnion(barber.schedule)});

      return sched.documentID;
    } catch (e) {
      print(e.toString());
    }
  }
}
