import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internship/user.dart';

class Tile extends StatefulWidget {
  var name;
  Tile({Key? key, required this.name}) : super(key: key);

  @override
  State<Tile> createState() => _TileState();
}

late var name, age, gender;

class _TileState extends State<Tile> {
  TextEditingController ageController = new TextEditingController();
  var genders = ["Male", "Female", "Others"];
  var selGen = "Male";
  var check = "Sign In";
  Color btnColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: btnColor),
        onPressed: () async {
          signOut();
        },
        child: Text(check),
      ),
      onTap: () async {
        bool isLoggedIn = false;

        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection("Users")
            .where("name", isEqualTo: widget.name)
            .get();

        for (var doc in snapshot.docs) {
          if (doc["isLoggedIn"] == true) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => User()));
            setState(() {
              isLoggedIn = true;
              name = doc["name"];
              age = doc["age"];
              gender = doc["gender"];
            });
          }
        }

        isLoggedIn ? null : createAlertDialog(context);

        setState(() {
          selGen = "Male";
          ageController.clear();
        });
      },
    );
  }

  createAlertDialog(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text(widget.name),
      content: SingleChildScrollView(
          child: Column(
        children: [
          Form(
              child: Column(
            children: [
              TextField(
                controller: ageController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "enter your age",
                ),
              ),
              DropdownButtonFormField(
                value: selGen,
                items: genders.map((item) {
                  return DropdownMenuItem(
                    child: Text(item),
                    value: item,
                  );
                }).toList(),
                onChanged: (item) {
                  setState(() {
                    selGen = item as String;
                  });
                },
              ),
            ],
          ))
        ],
      )),
      actions: [
        ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              Fluttertoast.showToast(msg: "tap to see details");
              Map<String, dynamic> newUserData = {
                "name": widget.name,
                "age": ageController.text.toString(),
                "gender": selGen,
                "isLoggedIn": true
              };

              await FirebaseFirestore.instance
                  .collection("Users")
                  .doc(widget.name)
                  .set(newUserData);

              setState(() {
                check = "Sign Out";
                btnColor = Colors.red;
              });
            },
            child: Text("sign in"))
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void signOut() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Users")
        .where("name", isEqualTo: widget.name)
        .get();

    for (var doc in snapshot.docs) {
      if (doc["isLoggedIn"] == true) {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(widget.name)
            .delete();
        Fluttertoast.showToast(msg: widget.name + " signed out");
        setState(() {
          check = "Sign In";
          btnColor = Colors.blue;
        });
      }
    }
  }
}
