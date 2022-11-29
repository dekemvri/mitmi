import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TheUser {
  final String uid;
  TheUser({required this.uid});
}

class UserModel {
  final String id;
  final String username;
  final String email;

  UserModel({required this.email, required this.id, required this.username});

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
        email: doc['email'], id: doc['id'], username: doc['username']);
  }
}
