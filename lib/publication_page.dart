import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/candidat.dart';

class PublicationPage extends StatefulWidget {
  @override
  _PublicationPageState createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultant"),
      ),
      body: Column(
        children: [
          Container(
            height: 170,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
              left: 16,
              right: 100,
              top: 16,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Statistique votes",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Nombre d'electeurs:"),
                    Text(
                      "20",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Nombre de candidats:"),
                    Text(
                      "2",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ont voté:"),
                    Text(
                      "18",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("N'ont pas voté:"),
                    Text(
                      "2",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("candidats")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
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
                            backgroundImage:
                                Image.network("${candidat.avatar}").image,
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
          ),
        ],
      ),
    );
  }
}
