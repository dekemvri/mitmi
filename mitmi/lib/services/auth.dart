import 'package:firebase_auth/firebase_auth.dart';
import 'package:mitmi/models/theuser.dart';

class AuthenticationAct {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

// sign in as anon
  Future anonSignIn() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
