import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
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

  Stream<QuerySnapshot> get customer {
    return customerCollection.snapshots();
  }
}
