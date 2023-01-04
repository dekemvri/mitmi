import 'package:flutter/material.dart';
import 'package:mitmi/screens/profile.dart';
import 'package:mitmi/services/auth.dart';

import '../search.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthenticationAct _auth = AuthenticationAct();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text(
          "Mitmi",
          style: TextStyle(fontFamily: "Arvo", fontSize: 35),
        ),
        backgroundColor: Colors.cyan[200],
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Profile()))
            },
            icon: Icon(Icons.account_box_outlined),
            alignment: Alignment.center,
          ),
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Search()));
              },
              icon: Icon(Icons.saved_search),
              alignment: Alignment.center),
          // IconButton(
          //   onPressed: () async {
          //     await _auth.signOut();
          //   },
          //   icon: Icon(Icons.logout),
          // ),
        ],
      ),
    );
  }
}
