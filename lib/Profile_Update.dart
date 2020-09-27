import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Login_Screen.dart';
class Profileupdate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<Profileupdate> {

  var user = FirebaseAuth.instance.currentUser;
  var _Password = TextEditingController();
  var _cnfrmpasword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  String password;
  String cnfrmpassword;

  void showToast() {
    Fluttertoast.showToast(
        msg: 'update successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white
    );
  }

  void showToast1() {
    Fluttertoast.showToast(
        msg: 'password miss match',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(


        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height/16,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Image.asset('asseds/logo.jpeg')
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: (
                    Text(
                      'Profile', textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    )
                ),
              ),
              Column(
//              mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Password', textAlign: TextAlign.right, style: TextStyle(
                    color: Color(0XFFCECCCF),
                    fontSize: 15.0,

                  ),),
                  SizedBox(
                    height: height/90,
                  ),
                  Container(
                      alignment: Alignment.center,
                      width: width/1.2,
                      child: Form(
                        key: _formKey1,
                        child: TextFormField(
                          validator: validatePass,
                          obscureText: true,
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
                              hintText: "password",
                              fillColor: Color(0XFFCECCCF)),
                          controller: _Password,
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                      )),
                  SizedBox(
                    height: height/90,
                  ),
                  Text('Confirm Password', textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0XFFCECCCF),
                      fontSize: 15.0,
                    ),),
                  SizedBox(
                    height: height/90,
                  ),
                  Container(
                      alignment: Alignment.center,
                      width: width/1.2,
                      child: Form(
                          key: _formKey,
                          child: TextFormField(
                          validator: validatePass,
                            obscureText: true,
                            decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(30.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.white),
                                hintText: "Confirm Password",

                                fillColor: Color(0XFFCECCCF)),
                            controller: _cnfrmpasword,
                            onChanged: (value) {
                              cnfrmpassword = value;
                            },
                          )
                      )
                  )
                ],
              ),
              SizedBox(
                height: height/25,
              ),
              Container(
                width: width/2.2,
                height: height/16,
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.black,
                  child: Text('Update',),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.black)
                  ),
                  onPressed: () async {
                    final form = _formKey1.currentState;
                    if (password == cnfrmpassword) {
                      if (form.validate()){
                      user.updatePassword(cnfrmpassword)
                          .whenComplete(() => cnfrmpassword);
                      showToast();
                    }} else {
                      showToast1();
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
  String validatePass(String value) {
    if (value.length < 5)
      return 'Password must be more than 5 charater';
     else
      return null;
}