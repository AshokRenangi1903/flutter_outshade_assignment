import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internship/tile.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          name,
          style: TextStyle(fontSize: 27),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Age : " + age,
          style: TextStyle(fontSize: 27),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          gender,
          style: TextStyle(fontSize: 27),
        ),
      ])),
    );
  }
}
