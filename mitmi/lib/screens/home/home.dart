import 'package:flutter/material.dart';
import 'package:mitmi/services/auth.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthenticationAct _auth = AuthenticationAct();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text("mitmi"),
        backgroundColor: Colors.cyan[200],
        elevation: 0,
        actions: [
          TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text("Logout"),
              icon: Icon(Icons.person_2))
        ],
      ),
    );
  }
}
