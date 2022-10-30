import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mitmi/models/theuser.dart';
import 'package:mitmi/screens/wrapper.dart';
import 'package:mitmi/services/auth.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return StreamProvider<TheUser?>.value(
      value: AuthenticationAct().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
