import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/candidat.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultant"),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("candidats").snapshots(),
          builder: (context, snapshot) {
            List<Candidat> candidats = snapshot.data.docs
                .map((e) => Candidat.fromJson(e.data()))
                .toList();
            return ListView.builder(
              itemCount: candidats.length,
              itemBuilder: (context, index) {
                Candidat candidat = candidats[index];
                return Card(
                  child: ListTile(
                    title: Text("${candidat.name}"),
                    subtitle: Text("${candidat.numero}"),
                    leading: CircleAvatar(
                      backgroundImage: Image.asset("${candidat.avatar}").image,
                    ),
                    trailing: Container(
                      height: 40,
                      width: 40,
                      child: Text("${candidat.votes.length}"),
                    ),
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
