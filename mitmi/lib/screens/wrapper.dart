import 'package:flutter/material.dart';
import 'package:mitmi/screens/home/home.dart';
import 'package:mitmi/screens/profile.dart';
import 'package:provider/provider.dart';

import '../models/theuser.dart';
import 'auth/reg_and_signin.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser?>(context);
    if (user == null) {
      return const Register();
    } else {
      return Home();
    }
  }
}
