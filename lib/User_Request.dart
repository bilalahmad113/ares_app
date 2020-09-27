import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Navigation_bar.dart';
import 'model.dart';
class user_request extends StatefulWidget {
  @override
  _user_requestState createState() => _user_requestState();
}

class _user_requestState extends State<user_request> {
  final items = List<String>.generate(51, (i) => "item $i");
  List<Need> list = List();

  Future Delete_User(String email) async
  {
    User user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection("Users").doc(email).delete();
  }
  Future getRequests() async
  {
    User user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference collectionReference = firebaseFirestore.collection("Users");
    QuerySnapshot documentSnapshot = await collectionReference.getDocuments();
    List<QueryDocumentSnapshot> dataSnapshot = documentSnapshot.docs;

    for(var docs in dataSnapshot)
    {
      var status = docs.get("status");
      if(status == "0")
      {
        Need need = new Need(
            email: docs.get("email"),
            name: docs.get("name")
        );
        list.add(need);
      }
    }
    setState(() {
    });
  }
  Future acceptRequest(String Accept_Email) async
  {
    User user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore.collection("Users").document(Accept_Email).updateData({
      "status" : "1",
    });
    setState(() {
      list.clear();
      getRequests();
    });
  }
  
  @override
  void initState() {
    getRequests();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,

        body: SingleChildScrollView(
          child: Column(children: <Widget>[
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
              height: height/6,
              width: width/1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => navigation_bar()));
                    },
                  ),
                  SizedBox(
                    width: width/5,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset('asseds/Areslogo.png',
                        width: width/3,)
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: height/40,
            ),
            Container(
              color: Colors.white,
              height: height / 1,
              width: width / 1.13,
              child: ListView.builder(
                itemCount:list.length,
                itemBuilder: (context,int position) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        height: height / 5.5,
                        width: width / 1.3,
                        decoration: new BoxDecoration(
                            color: Color(0XFFFFFAFA),
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(30.0),
                              bottomRight: const Radius.circular(30.0),
                              bottomLeft: const Radius.circular(15.0),
                            )
                        ),

                        child: Center(
                          child: Container(
                            color: Color(0XFFFFFAFA),
                            height: height / 5,
                            width: width / 1.4,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Align(alignment: Alignment.centerLeft, child: new Text(
                                    '${list[position].name}',

                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold),


                                  ),),
                                  SizedBox(height: height/80,),
                                  new Align(alignment: Alignment.centerLeft, child: new Text(
                                    '${list[position].email}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                    ),
                                  ),),
                                  SizedBox(height: height/80,),


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,

                                    children: <Widget>[
                                      Container(
                                        height: height/22,
                                        width: width/4.5,
                                        child: FlatButton(
                                          textColor: Colors.white,
                                          color: Colors.green,
                                          child: Text('Accept', ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0),
                                              side: BorderSide(color: Color(0XFFFFFAFA))
                                          ),
                                          onPressed: () {
                                            String email = list[position].email.toString();
                                            acceptRequest(email);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: width/25,
                                      ),
                                      Container(
                                        height: height/22,
                                        width: width/4.5,
                                        child: FlatButton(
                                          textColor: Colors.white,
                                          color: Colors.red,
                                          child: Text('Dlete', ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0),
                                              side: BorderSide(color: Color(0XFFFFFAFA))
                                          ),
                                          onPressed: () {
                                            String email = list[position].email.toString();
                                            Delete_User(email);

                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                        )),
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
