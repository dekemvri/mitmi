import 'package:flutter/material.dart';
import 'package:mitmi/screens/auth/authenticate.dart';
import 'package:mitmi/screens/home/home.dart';
import 'package:provider/provider.dart';

import '../models/theuser.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
