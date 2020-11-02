import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voteuac/candidat.dart';

class VotePage extends StatefulWidget {
  @override
  _VotePageState createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List des candidats"),
        actions: [
          IconButton(
            icon: Icon(Icons.supervised_user_circle_outlined),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("candidats").snapshots(),
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
                    child: Container(
                      height: 140,
                      child: Row(
                        children: [
                          Image.network(
                            "${candidat.avatar}",
                            height: 140,
                            width: 140,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${candidat.name}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text("Numero:${candidat.numero}"),
                              Text(
                                "${candidat.sloga}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                              RaisedButton(
                                child: Text("Je vote"),
                                onPressed: () async {
                                  User u = FirebaseAuth.instance.currentUser;
                                  await FirebaseFirestore.instance
                                      .collection("candidats")
                                      .doc(candidat.matricule)
                                      .update({
                                    "votes": [...candidat.votes, u.uid]
                                  });
                                  await FirebaseFirestore.instance
                                      .collection("votes")
                                      .doc(u.uid)
                                      .set({"uid": u.uid});
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
