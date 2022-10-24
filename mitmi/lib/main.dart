import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mitmi/screens/wrapper.dart';
import 'firebase_options.dart';
import 'package:mitmi/screens/home/home.dart';

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
    return const MaterialApp(
      home: Wrapper(),
    );
  }
}
