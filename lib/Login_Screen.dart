import 'package:aresapp/Forgot_Password.dart';
import 'package:aresapp/Home_Screen.dart';
import 'package:aresapp/Navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<LoginPage> {
  String email;
  String password;
  String CnPassword;
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool isLoading = false;
  TextEditingController controllerEmail;
  TextEditingController controllerPass;
  TextEditingController controllerCnPass;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  Future Init() async
  {

    await Firebase.initializeApp();
    // User user = await FirebaseAuth.instance.currentUser;
    // if(user!=null)
    // {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => navigation_bar()));
    // }
    // else
    // {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => LoginPage()));
    // }
  }

  @override

  initState(){
    Init();
    super.initState();
    controllerEmail = new TextEditingController(text: "");
    controllerPass = new TextEditingController(text: "");
    controllerCnPass = new TextEditingController(text: "");
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
                height: height/21,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child:Image.asset('asseds/logo.jpeg')
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: (
                Text('Sign in', textAlign: TextAlign.center,style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                ),)
                ),
              ),
             Form(
               key: _formKey,
               child:Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Text('Email', textAlign: TextAlign.right,style: TextStyle(
                   color: Color(0XFFCECCCF),
                   fontSize: 15.0,
                 ),),
                 SizedBox(
                   height: height/90,
                 ),
                   Container(
                   alignment: Alignment.center,
                   width: width/1.2,
                   height: height/12,
                   child: TextFormField(
                     keyboardType: TextInputType.emailAddress,
                     decoration: new InputDecoration(
                         border: new OutlineInputBorder(
                           borderRadius: const BorderRadius.all(
                             const Radius.circular(30.0),
                           ),
                           borderSide: BorderSide(
                             width: width/20,
                             style: BorderStyle.none,
                           ),
                         ),
                         filled: true,
                         hintStyle: new TextStyle(color: Colors.white),
                         hintText: "johen@gmail.com",
                         fillColor: Color(0XFFCECCCF)),
                     validator: validateEmail,
                     controller: controllerEmail,

                     onSaved: (val) =>
                         setState(() => email=val),
                   ),),
                 SizedBox(
                   height: height/90,
                 ),

                 Text('Password', textAlign: TextAlign.start,style: TextStyle(
                   color: Color(0XFFCECCCF),
                   fontSize: 15.0,
                 ),),
                 SizedBox(
                   height: height/90,
                 ),

                 Container(
                     alignment: Alignment.center,
                     width: width/1.2,
                     height: height/12,
                     child : TextFormField(
                       obscureText: true,
                       decoration: new InputDecoration(
                           border: new OutlineInputBorder(
                             borderRadius: const BorderRadius.all(
                               const Radius.circular(30.0),
                             ),
                           ),
                           filled: true,

                           hintStyle: new TextStyle(color: Colors.white),
                           hintText: "Password",
                           fillColor: Color(0XFFCECCCF)),
                       validator: validatePass,
                       controller: controllerPass,
                       onSaved: (val) =>
                           setState(() => password=val),
                     )
                 )
               ],
             ),
             ),



              Row(
                children: <Widget>[
                  SizedBox(width: width/2,),
                  FlatButton(

                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Forogetpassword()));
                    },
                    textColor: Colors.black45,
                    child: Text('Forgot Password ?',
                        textAlign: TextAlign.end,style: TextStyle(
                          color: Color(0XFFCECCCF),
                          fontSize: 15.0,
                        ),
                    ),

                  ),
                ],
              ),
              Container(
                width: width/2.2,
                height: height/16,
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.black,
                  child: Text('Login', ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.black)
                  ),
                  onPressed: () {
                    final form = _formKey.currentState;

                    if (form.validate()) {
                      isLoading=true;
                      form.save();
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(email: email, password: password)
                          .then(( auth){
                        isLoading=false;
                        clearControllers();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => navigation_bar()));

                      }).catchError((e){
                        isLoading=false;
                        Fluttertoast.showToast(msg: "Sign in fail");
                        this.setState(() {
                          isLoading = false;
                        });
                        print(e);
                      });

                    }
                    },
                ),
              ),
            ],
          ),
        ));
  }

clearControllers()
{

  controllerEmail = new TextEditingController(text: "");
  controllerPass = new TextEditingController(text: "");
  controllerCnPass = new TextEditingController(text: "");
}
}

String validatePass(String value) {
  if (value.length < 5)
    return 'Password must be more than 5 charater';
  else
    return null;
}
String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}
