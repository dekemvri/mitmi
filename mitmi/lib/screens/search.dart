// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../loading.dart';
import '../models/theuser.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textControl = TextEditingController();
  Future<QuerySnapshot>? finalSearchrResult;

  final usersInstance = FirebaseFirestore.instance.collection("Users");

  handleSearching(String typeInSearchBar) {
    Future<QuerySnapshot> friends = usersInstance
        .where("username", isGreaterThanOrEqualTo: typeInSearchBar)
        .get();

    setState(() {
      finalSearchrResult = friends;
    });
  }

  clear() {
    return textControl.clear();
  }

  AppBar seatchField() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: textControl,
        decoration: InputDecoration(
          hintText: "Find friends",
          filled: true,
          prefixIcon: const Icon(
            Icons.account_box,
            size: 28.0,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear), iconSize: 28.0, onPressed: clear,

            // I'm going to use this little code later
            //  () {
            //   Navigator.pushReplacement(
            //       context, MaterialPageRoute(builder: (context) => Home()));
            // },
          ),
        ),
        onFieldSubmitted: handleSearching,
      ),
    );
  }

// The screen if it has no content to show
  Center noContent() {
    return Center(
      child: Image.asset('assets/images/LOGO-TRANS-SMALL.png'),
    );
  }

// The screen after a search word is submited
  searchResults() {
    return FutureBuilder(
      future: finalSearchrResult,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Loading();
        }
        List<UserResults> findings = [];
        snapshot.data?.docs.forEach((doc) {
          UserModel users = UserModel.fromDocument(
              doc as DocumentSnapshot<Map<String, dynamic>>?);
          UserResults userResult = UserResults(users);
          findings.add(userResult);
        });
        return ListView(
          children: findings,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: seatchField(),
      body: finalSearchrResult == null ? noContent() : searchResults(),
    );
  }
}

class UserResults extends StatelessWidget {
  final UserModel user;
  const UserResults(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      // Custom Theme here
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => print("tapped"),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.grey,
                // Avatar:
                // backgroundImage: CachedNetworkImageProvider(),
              ),
              title: Text(
                user.username,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              // Something else; not the email; real name
              subtitle: Text(
                user.email,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Divider(
            height: 5.0,
            color: Colors.white54,
          ),
        ],
      ),
    );
  }
}
