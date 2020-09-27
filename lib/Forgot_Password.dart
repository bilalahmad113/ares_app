import 'package:aresapp/Login_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Forogetpassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<Forogetpassword> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String email;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child:Image.asset('asseds/logo.jpeg')
              ),
          Container(
                    padding: EdgeInsets.all(10),
                    child: (
                        Text('Forgot Password', textAlign: TextAlign.center,style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),)


                    ),

                  ),
              SizedBox(
                height: 20,
              ),


             Form(
               key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text('Email', textAlign: TextAlign.right,style: TextStyle(
                     color: Color(0XFFCECCCF),
                     fontSize: 15.0,
                   ),
                   ),
                   Container(
                     alignment: Alignment.center,
                     width: 300.0,
                     height: height/12,
                     child: TextFormField(
                       controller: emailController,
                       validator: (value) {
                         if (value.isEmpty) {
                           return 'Please enter valid Email';
                         }
                         return null;
                       },
                       decoration: new InputDecoration(
                           focusColor: Colors.red,
                           hoverColor: Colors.yellow,
                           border: new OutlineInputBorder(
                             borderRadius: const BorderRadius.all(
                               const Radius.circular(30.0),
                             ),
                             borderSide: BorderSide(
                               width: 50,
                               style: BorderStyle.none,
                             ),
                           ),
                           filled: true,
                           hintStyle: new TextStyle(color: Colors.white),
                           hintText: "johen@gmail.com",
                           fillColor: Color(0XFFCECCCF)),
                       onChanged: (value)
                       {
                         email = value;
                       },
                     ),),

                 ],
               ),
             ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 160,
                height: 40,
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.black,
                  child: Text('send', ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.black)
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await _firebaseAuth
                          .sendPasswordResetEmail(email: email)
                          .whenComplete(() {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  content: Container(
                                    height: height / 5.5,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                            "We sent email to : "
                                        ),
                                        SizedBox(
                                          height: height / 60,
                                        ),
                                        Text(
                                          "$email",
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(
                                          height: height / 60,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            ButtonTheme(
                                              minWidth: width / 4,
                                              height: height / 18,
                                              child: FlatButton(
                                                shape:
                                                new RoundedRectangleBorder(
                                                  borderRadius:
                                                  new BorderRadius
                                                      .circular(20.0),
                                                ),
                                                color: Color(0xff9847b7),
                                                textColor: Colors.white,
                                                child: Text(
                                                  "Ok",
                                                  style: TextStyle(
                                                      fontSize: height / 40,
                                                      fontWeight:
                                                      FontWeight.w500
                                                    //letterSpacing: 1
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginPage()));
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ));
                            });
                      });
                      }
                  },

                ),
              ),
            ],
          ),
        ));
  }
}