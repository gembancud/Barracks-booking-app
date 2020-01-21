import 'package:barracks_app/models/customer.dart';
import 'package:barracks_app/screens/authenticate/register.dart';
import 'package:barracks_app/services/auth.dart';
import 'package:barracks_app/shared/loading.dart';
import 'package:flutter/material.dart';

class SiginIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SiginIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  //textfield states
  var _email = '';
  var _password = '';
  var _error = '';

  void onRegisterPressed(BuildContext ctx) async {
    await Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => Register()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            // resizeToAvoidBottomInset: false,
            backgroundColor: Colors.grey[80],
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.grey[40],
              title: Text(
                'Sign in to Barracks',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 50,
              ),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) =>
                            email.isEmpty ? 'Enter email' : null,
                        onChanged: (val) {
                          setState(() {
                            _email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        validator: (password) =>
                            password.length < 8 ? 'Enter password' : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            _password = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        color: Colors.grey[40],
                        child: Text('Sign In'),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => _loading = true);
                            dynamic result =
                                await _auth.signinemail(_email, _password);

                            if (result == null) {
                              setState(() {
                                _loading = false;
                                _error = 'Please supply a valid email';
                              });
                            } else {
                              print('signin successful!');
                            }
                          }
                        },
                      ),
                      RaisedButton(
                        color: Colors.grey[40],
                        child: Text('Sign Up'),
                        onPressed: () {
                          onRegisterPressed(context);
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        _error,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
