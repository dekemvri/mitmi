import 'package:firebase_auth/firebase_auth.dart';
import 'package:mitmi/loading.dart';
import 'package:mitmi/models/theuser.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home/home.dart';

final usersInstance = FirebaseFirestore.instance.collection("Users");

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Column countColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        Container(
            margin: const EdgeInsets.only(top: 4),
            child: Text(
              label,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ))
      ],
    );
  }

  buttonEditProfile() {
    return const Text("Edit Profile");
  }

  profileHeader() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userId = auth.currentUser?.uid;
    return FutureBuilder(
      future: usersInstance.doc(userId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Loading();
        }
        UserModel user = UserModel.fromDocument(snapshot.data);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const CircleAvatar(
                    radius: 40.0, backgroundColor: Colors.amber,
                    // backgroundImage: CachedNetworkImageProvider(user.photoURL),
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
//                            countColumn("free days", 0),
                              countColumn("followers", 0),
                              countColumn("following", 0),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              buttonEditProfile(),
                            ],
                          )
                        ],
                      ))
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
//                  "asd",
                  user.username,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
//                  "asd",
                  //trqbwa da e user.nickname ili displayName
                  user.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

// OPTIONAL CONTAINER FOR BIO
              // Container(
              //   alignment: Alignment.centerLeft,
              //   padding: EdgeInsets.only(top: 2.0),
              //   child: Text(
              //     user.bio,
              //     style: TextStyle(... ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () => {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()))
          },
          icon: const Icon(Icons.ac_unit),
          alignment: Alignment.center,
        ),
      ]),
      body:

          // Text("profile:")
          ListView(
        children: <Widget>[profileHeader()],
      ),

// Add picture at top --- maybe an avatar library

// Add username --- editable under certain conditions

// Add personal callendar

// Add list of friends somewhere
    );
  }
}
