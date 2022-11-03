// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internship/tile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var i = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Internship"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Tile(name: "Krishna"),
          Tile(name: "Sameera"),
          Tile(name: "Radhika"),
          Tile(name: "Yogesh"),
          Tile(name: "Radhe"),
          Tile(name: "Anshu"),
          Tile(name: "Balay"),
          Tile(name: "Julie"),
          Tile(name: "Swaminathan"),
          Tile(name: "Charandeep"),
          Tile(name: "Sankaran"),
          Tile(name: "Alpa"),
          Tile(name: "Sheth"),
        ]),
      ),
    ));
  }
}
