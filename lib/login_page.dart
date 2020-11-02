import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                UserCredential userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _matricule + "@vote.com", password: _password);
                if (userCredential.user != null) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => VotePage()),
                    ModalRoute.withName('/'),
                  );
                  Navigator.of(context).pop();
                } else {
                  print("Erreur");
                }
              },
              child: Text("Connexion"),
            )
          ],
        ),
      ),
    );
  }
}
