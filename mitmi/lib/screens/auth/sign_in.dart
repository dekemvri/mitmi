import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mitmi/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthenticationAct _auth = AuthenticationAct();

  String email = '';
  String pass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 87, 149),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 1.0,
        title: const Text("sign in :)"),
        actions: [],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                onChanged: (eml) {
                  setState(() {
                    email = eml;
                  });
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                obscureText: true,
                onChanged: (ps) {
                  setState(() {
                    pass = ps;
                  });
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text('Sign In ANON'),
                onPressed: () async {
                  dynamic result = await _auth.anonSignIn();
                  if (result == null) {
                    print("Not logged in");
                  } else {
                    print("Signed in");
                    print(result.uid);
                  }
                  print(email + " : email from sign_in");
                  print(pass + " : pass from sign_in");
                },
              )
            ],
          ))),
    );
  }
}
