import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mitmi/models/theuser.dart';

class AuthenticationAct {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final userReference = FirebaseFirestore.instance.collection("Users");
  final DateTime regTime = DateTime.now();

// creating an user object that hold only its ID

  TheUser? _userFromUser(User? user) {
    if (user != null) {
      return TheUser(uid: user.uid);
    } else {
      return null;
    }
  }

// Setting up STREAM, yeyyyyy

  Stream<TheUser?> get user {
    return _auth.authStateChanges().map(_userFromUser);
  }

// SIGN IN: E-MAIL AND PASS

  Future signInMailPass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// REGISTER: MAIL AND PASS

  Future regMailPass(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await FirebaseFirestore.instance.collection('Users').doc(user?.uid).set({
        'email': email,
        'username': '',
        'id': user!.uid,
        'date': regTime,
        'photoUrl': user.photoURL,
      });
      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// SIGN OUT

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
