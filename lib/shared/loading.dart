import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Loading...',
                style: TextStyle(fontSize: 20),
              ),
              SpinKitPulse(
                color: Colors.grey,
                size: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
