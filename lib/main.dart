import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voteuac/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'vote uac',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      // home: StreamBuilder<User>(
      //     stream: FirebaseAuth.instance.authStateChanges(),
      //     builder: (context, snapshot) {
      //       if (!snapshot.hasData && snapshot.data == null) {
      //         return HomePage();
      //       } else {
      //         return StreamBuilder<DocumentSnapshot>(
      //             stream: FirebaseFirestore.instance
      //                 .collection("votes")
      //                 .doc(snapshot.data.uid)
      //                 .snapshots(),
      //             builder: (context, snapshot) {
      //               if (!snapshot.hasData && !snapshot.data.exists) {
      //                 return VotePage();
      //               } else {
      //                 return ResultPage();
      //               }
      //             });
      //       }
      //     }),
    );
  }
}
