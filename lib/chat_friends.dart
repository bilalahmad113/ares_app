import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aresapp/model.dart';
import 'package:flutter/material.dart';
import 'package:aresapp/model.dart';

import 'Chat.dart';

class chatlist extends StatefulWidget
{
  @override
  _User_managementState createState() => _User_managementState();
}
class _User_managementState extends State<chatlist> {
  List<Need> list = List();
  Future<Void> isertData(Users) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("Users").add(Users).then((DocumentReference document) {
    });
  }
  // Future Delete_User(String email) async
  // {
  //   User user = FirebaseAuth.instance.currentUser;
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   await firebaseFirestore.collection("Users").doc(email).delete();
  // }
  Future getData() async
  {
    User user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference collectionReference = firebaseFirestore.collection("Users");
    QuerySnapshot documentSnapshot = await collectionReference.getDocuments();
    List<QueryDocumentSnapshot> dataSnapshot = documentSnapshot.docs;

    for(var docs in dataSnapshot)
    {
      var status = docs.get("status");
      if(status == "1")
      {
        Need need = new Need(
          email: docs.get("email"),
          name: docs.get("name"),
          ph: docs.get("ph"),
        );
        list.add(need);
      }
    }
    setState(() {
    });
  }
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
                color: Colors.black
            ),
            title: Image.asset('asseds/Areslogo.png',
              width: width / 3,)
        ),
        body: Column(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(0.0),
                  topRight: const Radius.circular(0.0),
                  bottomRight: const Radius.circular(30.0),
                  bottomLeft: const Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: 30.0,
              width: 400.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 100,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            SingleChildScrollView(
              child: Container(
                color: Colors.white,
                height: height / 1.6,
                width: width / 1.1,
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context,int position)
                  {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: ()
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChatScreen(email: list[position].email)));
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                              color: Color(0XFFFFFAFA),
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(10.0),
                                topRight: const Radius.circular(30.0),
                                bottomRight: const Radius.circular(30.0),
                                bottomLeft: const Radius.circular(15.0),
                              )),
                          height: height / 7.8,
                          width: width / 1.3,
                          child: Center(
                            child: Container(
                              height: height/5,
                              width: width/1.3,
                              color: Color(0XFFFFFAFA),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Text(
                                      '${list[position].name}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: height / 40,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 150,
                                    ),
                                  ]),
                                  new Align(
                                      alignment: Alignment.centerLeft,
                                      child: new Text(
                                        '${list[position].email}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w200),
                                      )),
                                  SizedBox(height: 5,),
                                  new Align(
                                      alignment: Alignment.centerLeft,
                                      child: new Text(
                                        '${list[position].ph}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w200),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        )
    );
  }
}

