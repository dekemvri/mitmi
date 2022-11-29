import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("profile"),

// Add picture at top --- maybe an avatar library

// Add username --- editable under certain conditions

// Add personal callendar

// Add list of friends somewhere
    );
  }
}
