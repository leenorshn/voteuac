import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'models/electeur.dart';

class EnrollementCandidat extends StatefulWidget {
  @override
  _EnrollementCandidatState createState() => _EnrollementCandidatState();
}

class _EnrollementCandidatState extends State<EnrollementCandidat> {
  String _selectedElecteurName = "";
  String _selectedElecteurMatricule = "";
  int _numero;
  String _sloga;
  String _imageAvatar = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text("Enrollement Candidat"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                color: Colors.black,
                                child: Center(
                                  child: Text(
                                    "List des electeurs",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                height: 56,
                              ),
                              Expanded(
                                child: Container(
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("electeurs")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      List<Electeur> electeurs = snapshot
                                          .data.docs
                                          .map((e) =>
                                              Electeur.fromJson(e.data()))
                                          .toList();
                                      return ListView.builder(
                                        itemCount: electeurs.length,
                                        itemBuilder: (context, index) {
                                          Electeur electeur = electeurs[index];
                                          return ListTile(
                                            onTap: () {
                                              setState(() {
                                                _selectedElecteurName =
                                                    electeur.name;
                                                _selectedElecteurMatricule =
                                                    electeur.matricule;
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            title: Text("${electeur.name}"),
                                            subtitle:
                                                Text("${electeur.matricule}"),
                                            leading: CircleAvatar(
                                              backgroundImage: Image.asset(
                                                      "images/profile.png")
                                                  .image,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Card(
                margin: EdgeInsets.all(0),
                child: Container(
                  height: 56,
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_selectedElecteurName == ""
                            ? "Choisir candidat"
                            : _selectedElecteurName),
                        Icon(Icons.account_circle_outlined)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                ),
                fillColor: Colors.white,
                filled: true,
                suffixIcon: Icon(Icons.edit),
                labelText: "Numero candidat",
              ),
              onChanged: (v) {
                setState(() {
                  _numero = int.parse(v);
                });
              },
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                ),
                fillColor: Colors.white,
                filled: true,
                suffixIcon: Icon(Icons.edit),
                labelText: "Sloga",
              ),
              onChanged: (v) {
                setState(() {
                  _sloga = v;
                });
              },
            ),
            SizedBox(
              height: 8,
            ),
            Card(
              margin: EdgeInsets.all(0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("images")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return GridView.builder(
                                      itemCount: snapshot.data.docs.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 7 / 9,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _imageAvatar = snapshot
                                                    .data.docs[index]
                                                    .data()['url'];
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Image.network(
                                              "${snapshot.data.docs[index].data()['url']}",
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                            ),
                                          ),
                                        );
                                      });
                                }),
                          ),
                        );
                      });
                },
                child: CircleAvatar(
                  backgroundImage: _imageAvatar == ""
                      ? Image.asset(
                          "images/profile.png",
                          fit: BoxFit.contain,
                        ).image
                      : Image.network(_imageAvatar).image,
                  radius: 90,
                ),
              ),
            ),
            SizedBox(
              height: 64,
            ),
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      color: Colors.yellow,
                      textColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      onPressed: () {},
                      child: Text("Annuler"),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection("candidats")
                            .doc(_selectedElecteurMatricule)
                            .set({
                          "matricule": _selectedElecteurMatricule,
                          "name": _selectedElecteurName,
                          "numero": _numero,
                          "sloga": _sloga,
                          "avatar": _imageAvatar,
                          "votes": []
                        });
                      },
                      child: Text("Enregistrer"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
