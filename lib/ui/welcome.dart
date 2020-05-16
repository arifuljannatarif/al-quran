import 'dart:async';

import 'package:alquran/ui/HomeScreen.dart';
import 'package:flutter/material.dart';

class WelcomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _WelcomeScreenState(),
    );
  }
}

class _WelcomeScreenState extends StatefulWidget {
  @override
  _WelcomeScreenStateState createState() => _WelcomeScreenStateState();
}

class _WelcomeScreenStateState extends State<_WelcomeScreenState> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen())));
    return Scaffold(
        body: Container(
      child: Stack(
        children: <Widget>[
          Container(
            child: Image(
              fit: BoxFit.cover,
              height: double.infinity,
              image: AssetImage("assets/images/wcbg.jpg"),
            ),
          )
        ],
      ),
    ));
  }

  Future navigateToHomePage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
