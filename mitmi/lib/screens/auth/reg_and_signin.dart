import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:mitmi/loading.dart';
import '../../services/auth.dart';
import '../profile.dart';

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
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            // backgroundColor: Color.fromARGB(255, 167, 210, 203),
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromARGB(255, 167, 210, 203),
                    Color.fromARGB(255, 242, 211, 136),
                    Color.fromARGB(255, 201, 132, 116),
//                    Color.fromARGB(255, 135, 76, 98),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(60.0),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 40.0,
                            ),
                            TextFormField(
                              validator: (em) {
                                if (em == "") {
                                  return "Enter valid e-mail";
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: "E-mail",
                                fillColor: Colors.transparent,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color.fromARGB(255, 135, 76, 98),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 135, 76, 98),
                                    width: 3,
                                  ),
                                ),
                              ),
                              onChanged: (em) {
                                setState(
                                  () {
                                    email = em;
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              validator: (ps) {
                                if (ps!.length < 6) {
                                  return "Password needs to be 6 or more characters.";
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: "Password",
                                fillColor: Colors.transparent,
                                prefixIcon: Icon(
                                  Icons.password_outlined,
                                  color: Color.fromARGB(255, 135, 76, 98),
                                ),
                                // filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 135, 76, 98),
                                    width: 3,
                                  ),
                                ),
                              ),
                              obscureText: true,
                              onChanged: (ps) {
                                setState(() {
                                  password = ps;
                                });
                              },
                            ),
                            const SizedBox(height: 40.0),

// Two buttons - Register and Sign In

                            Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: OutlinedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            loading = true;
                                          });
                                          dynamic result = await _auth
                                              .regMailPass(email, password);
                                          if (result == null) {
                                            setState(
                                              () {
                                                err =
                                                    "Something went wrong. Try again.";
                                                loading = false;
                                              },
                                            );
                                          }
                                        }
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                          width: 2.0,
                                          color:
                                              Color.fromARGB(255, 135, 76, 98),
                                        ),
                                      ),
                                      child: const Text(
                                        'Sign up',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 135, 76, 98),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: OutlinedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          dynamic result = await _auth
                                              .signInMailPass(email, password);
                                          if (result == null) {
                                            setState(
                                              () {
                                                err =
                                                    "Something went wrong. Try again.";
                                              },
                                            );
                                          }
                                        }
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                          width: 2.0,
                                          color:
                                              Color.fromARGB(255, 135, 76, 98),
                                        ),
                                      ),
                                      child: const Text(
                                        'Sign In',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 135, 76, 98),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40.0),

// BUTTON FOR Google sign-in

                            Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: SignInButton(
                                      Buttons.GoogleDark,
                                      text: "Sign up with Google",
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              err,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 135, 76, 98)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
