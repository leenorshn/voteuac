import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voteuac/models/electeur.dart';

class ElecteurPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List des electeur"),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("electeurs").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Electeur> electeurs = snapshot.data.docs
                .map((e) => Electeur.fromJson(e.data()))
                .toList();
            return ListView.builder(
              itemCount: electeurs.length,
              itemBuilder: (context, index) {
                Electeur electeur = electeurs[index];
                return ListTile(
                  title: Text("${electeur.name}"),
                  subtitle: Text("${electeur.matricule}"),
                  leading: CircleAvatar(
                    backgroundImage: Image.asset("images/profile.png").image,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
