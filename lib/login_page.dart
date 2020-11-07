import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voteuac/main_page.dart';
import 'package:voteuac/vote_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _matricule;
  String _password;
  @override
  Widget build(BuildContext context) {
    signin();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Matricule",
                filled: true,
                border: InputBorder.none,
              ),
              onChanged: (v) {
                setState(() {
                  _matricule = v;
                });
              },
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Mot de passe",
                filled: true,
                border: InputBorder.none,
              ),
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 6,
              onChanged: (v) {
                setState(() {
                  _password = v;
                });
              },
            ),
            SizedBox(
              height: 40,
            ),
            RaisedButton(
              color: Colors.blue[800],
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 56),
              onPressed: () async {
                print(_matricule);
                QuerySnapshot docsData = await FirebaseFirestore.instance
                    .collection("electeurs")
                    .get();
                var docUser = docsData.docs
                    .where(
                        (element) => element.data()['matricule'] == _matricule)
                    .toList();

                if (docUser[0].exists && docUser[0].data()["role"] == "admin") {
                  print(docUser[0].data().toString() + "<<<<<<<<<<<");
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MainPage()),
                    ModalRoute.withName('/'),
                  );
                  //Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => VotePage()),
                    ModalRoute.withName('/'),
                  );
                }
              },
              child: Text("Connexion"),
            )
          ],
        ),
      ),
    );
  }

  signin() async {
    if (FirebaseAuth.instance.currentUser == null) {
      await FirebaseAuth.instance.signInAnonymously();
    }
  }
}
