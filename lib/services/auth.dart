import 'package:barracks_app/models/customer.dart';
import 'package:barracks_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create Customer Object based on FirebaseUser
  Customer _customerFromFirebase(FirebaseUser user) {
    if (user == null) return null;
    return Customer(
      id: user.uid,
      email: user.email,
      name: user.displayName,
      phonenumber: user.phoneNumber,
    );
  }

  //Auth Change User Stream
  Stream<Customer> get customer {
    return _auth.onAuthStateChanged.map(_customerFromFirebase);
  }

  //Anonymous Sign in
  Future signinAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _customerFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Email Sign in
  Future signinemail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _customerFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Email Sign up
  Future signupemail(
      String name, String phone, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //create a document in firestore using the user with the uid
      await DatabaseService(uid: user.uid)
          .updateCustomerData(name, phone, email, 0);

      return _customerFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //Google Sign in
  Future googleSignIn() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      assert(!user.isAnonymous);

      await DatabaseService(uid: user.uid)
          .updateCustomerData(googleUser.displayName, '', googleUser.email, 0);
      return _customerFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign out
  Future signOut() async {
    try {
      if (_googleSignIn.isSignedIn() == true) _googleSignIn.signOut();
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      print('Signout error');
      return null;
    }
  }
}
