import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthenticationAct _auth = AuthenticationAct();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String err = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        elevation: 1.0,
        title: const Text("reg or sign in :)"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (em) {
                    if (em == "") {
                      return "Enter valid e-mail";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(hintText: "E-mail"),
                  onChanged: (em) {
                    setState(() {
                      email = em;
                    });
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (ps) {
                    if (ps!.length < 6) {
                      return "Password needs to be 6 or more characters.";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(hintText: "Password"),
                  obscureText: true,
                  onChanged: (ps) {
                    setState(() {
                      password = ps;
                    });
                  },
                ),
                SizedBox(height: 20.0),

// Two buttons - Register and Sign In

                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: ElevatedButton(
                            child: Text('Register'),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                dynamic result =
                                    await _auth.regMailPass(email, password);
                                if (result == null) {
                                  setState(() {
                                    err = "Something went wrong. Try again.";
                                  });
                                }
                              }
                            }),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ElevatedButton(
                          child: Text('Sign In'),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              dynamic result =
                                  await _auth.signInMailPass(email, password);
                              if (result == null) {
                                setState(() {
                                  err = "Something went wrong. Try again.";
                                });
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  err,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            )),
      ),
    );
  }
}
