import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:voteuac/enrollement_electeur.dart';
import 'package:voteuac/screen_page.dart';
import 'package:voteuac/vote_page.dart';

import 'enrollement_candidat.dart';
import 'publication_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Administration"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Bienvenu le 17/11/2020",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              MenuBtn(
                name: "Je vote",
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => VotePage()));
                },
              ),
              SizedBox(
                height: 6,
              ),
              MenuBtn(
                name: "Electeurs",
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ElecteurPage()));
                },
              ),
              SizedBox(
                height: 6,
              ),
              MenuBtn(
                name: "Enrolement",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EnrollementElecteur()));
                },
              ),
              SizedBox(
                height: 6,
              ),
              MenuBtn(
                name: "GEstion Candidats",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EnrollementCandidat()));
                },
              ),
              SizedBox(
                height: 6,
              ),
              MenuBtn(
                name: "Publication",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PublicationPage()));
                },
              ),
              SizedBox(
                height: 6,
              ),
              MenuBtn(
                name: "Gerer les elections",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuBtn extends StatelessWidget {
  final Function onPressed;
  final String name;
  const MenuBtn({
    this.name,
    this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue[700],
      ),
      child: RaisedButton(
        onPressed: onPressed,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          "$name",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        color: Colors.blue[700],
        textColor: Colors.white,
      ),
    );
  }
}
