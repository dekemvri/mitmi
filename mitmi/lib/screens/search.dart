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
  handleSearching(String typing) {
    Future<QuerySnapshot> friends = FirebaseFirestore.instance
        .collection("Users")
        .where("username", isGreaterThanOrEqualTo: typing)
        .get();
    setState(() {
      finalSearchrResult = friends;
    });
  }

  wipeLetters() {
    return textControl.clear();
  }

  AppBar seatchField() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: textControl,
        onChanged: (typeInSearchBar) {
          setState(() {
            var searchText = typeInSearchBar;
          });
          handleSearching(typeInSearchBar);
        },
        decoration: InputDecoration(
          hintText: "Find your friends",
          filled: true,
          prefixIcon: Icon(
            Icons.account_box,
            size: 28.0,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear), iconSize: 28.0, onPressed: wipeLetters,

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
  Container noContent() {
    return Container(
      child: Center(
        child: Text(
          "Search...",
          style: TextStyle(fontSize: 50.0, color: Colors.black12),
        ),
      ),
    );
  }

// The screen after a search word is submited
  searchResults() {
    return FutureBuilder(
      future: finalSearchrResult,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        List<Text> findings = [];
        snapshot.data?.docs.forEach((doc) {
          UserModel users = UserModel.fromDocument(doc);
          findings.add(Text(users.username));
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

class UserResult extends StatelessWidget {
  const UserResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
