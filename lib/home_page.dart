import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:voteuac/login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenu",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Vote-UAC",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
            Text("Identifiez-vous pour commencer"),
            SizedBox(
              height: 120,
            ),
            RaisedButton(
              color: Colors.blue[800],
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 56),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text("Connexion"),
            ),
          ],
        ),
      ),
    );
  }
}
