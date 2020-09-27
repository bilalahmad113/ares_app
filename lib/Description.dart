import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Navigation_bar.dart';
class Descrption extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<Descrption> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController descrptionController = TextEditingController();
  String subject ,descrption;
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  var user = FirebaseAuth.instance.currentUser;
  void showToast1() {
    Fluttertoast.showToast(
        msg: 'save successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white
    );
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,


        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height/24,
              ),
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
                    ]
                ),

                height: height/6,
                child:Row(
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
                    Container(
                      child: Row(
                        children: <Widget>[
                          Image.asset('asseds/Areslogo.png',
                            width: width/3,)
                        ],
                      ),

                    )
                  ],
                ),


              ),
              SizedBox(
                height: height/25,
              ),
              Column(
//              mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('subject', textAlign: TextAlign.right,style: TextStyle(
                    color: Color(0XFFCECCCF),
                    fontSize: 15.0,
                  ),),
//                  TextField(
//                    obscureText: true,
//                    keyboardType: TextInputType.emailAddress,
//                    decoration: InputDecoration(
//                      border: ,
//                      hintText:'johndoe@gmail.com' ,
//
//
//                    ),
//                  ),
                SizedBox(
                  height: height/90,
                ),
                  Container(
                    alignment: Alignment.center,
                      width: width/1.2,
                    child:Form(
                      key: _formKey,
                     child:TextFormField(
                         controller:subjectController,
                     validator: (value) {
    if (value.isEmpty) {
    return 'Please enter some text';
    }
   return null;
                     },




                       onChanged: (value)
                       {
                         subject = value;
                       },
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(30.0),
                              ),
                              borderSide: BorderSide(
                                width: width/10,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.white),
                            hintText: "Enter subject",
                            fillColor: Color(0XFFCECCCF)),
                      ),
                    )),
                  SizedBox(height: height/90,),

                  Text('Descrption', textAlign: TextAlign.start,style: TextStyle(
                    color: Colors.black45,
                    fontSize: 15.0,
                  ),),
                  SizedBox(
                    height: height/70,
                  ),

                  Container(
                      alignment: Alignment.center,

                      width: width/1.2,
                    child:Form(
                     key: _formKey1,
                      child: TextFormField(
                        controller:descrptionController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }return null;
                        },
                      onChanged: (value)
                      {
                        descrption = value;
                      },
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(30.0),
                            ),
                            borderSide: BorderSide(
                              width: width/10,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.white),
                          fillColor: Color(0XFFCECCCF)),
                      ),
                    )),
                ],
              ),
              SizedBox(
                height: height/28,
              ),
              Container(
                width: width/2.2,
                height: height/16,
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.black,
                  child: Text('Save', ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.black)
                  ),
                  onPressed: () {
    if (_formKey.currentState.validate()) {
      if (_formKey1.currentState.validate()) {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore.collection("Descrption").document(user.email).setData(
    {
    "subject": subject,
    "descrption": descrption,
    }
    );
    showToast1();
    }
    }

                  },
                ),
              ),




            ],
          ),
        ));
  }
}