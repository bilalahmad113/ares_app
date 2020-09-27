import 'package:aresapp/Post_Document.dart';
import 'package:aresapp/Schedule.dart';
import 'package:aresapp/User_Request.dart';
import 'package:aresapp/User_management.dart';
import 'package:aresapp/Post_video.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Login_Screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//void main() => runApp(MaterialApp(home: BottomNavBar()));

class Home_screen extends StatefulWidget {


  @override
  _Home_screenState createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,

        body:SingleChildScrollView(
          child: Column(
          children: <Widget>[
            SizedBox(
              height:height/24,
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
        ],
      ),

      height: height/5.5,
      width: width,
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
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          SizedBox(
            width: width/5,
          ),
          Center(
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
            SizedBox(height: height/25,),

            Row(
           children: <Widget>[
             Container(
               height: height/5.3,
               width: width/2.1,
               child: Container(
                 margin: EdgeInsets.all(20.0),
                 decoration: BoxDecoration(
                     color: Color(0XFFCECCCF),
                   borderRadius: BorderRadius.circular(10.0)
                 ),
                 child: GestureDetector(onTap: (){
                   Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => user_request()));
                 },
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[

                       Icon(Icons.person_add,),
                       Text("User Request",style: TextStyle(
                         fontWeight: FontWeight.bold,


                       ),)
                     ],
                   ),
                 ),

               ),
             ),
             Row(
               children: <Widget>[
                 Container(
                   height: height/8.3,
                   width: width/2.7,
                   margin: EdgeInsets.all(20.0),
                   decoration: BoxDecoration(
                       color: Color(0XFFCECCCF),
                       borderRadius: BorderRadius.circular(10.0)
                   ),
                   child: GestureDetector(onTap: (){
                     Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => User_management()));
                   },
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Icon(Icons.people,),
                         Text("User Management",style: TextStyle(
                             fontWeight: FontWeight.bold
                         ),)
                       ],
                     ),
                   ),

                 ),
               ],
             )
           ],
         ),
            Row(
              children: <Widget>[
                Container(
                  height: height/5.3,
                  width: width/2.1,
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        color: Color(0XFFCECCCF),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: GestureDetector(onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => upload_docutment()));
                    },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Icon(Icons.missed_video_call, ),
                          Text("Post Videos",style: TextStyle(
                            fontWeight: FontWeight.bold,


                          ),)
                        ],
                      ),
                    ),

                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: height/8.3,
                      width: width/2.7,
                      margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: Color(0XFFCECCCF),
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: GestureDetector(onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => docutment()));
                      },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.receipt,),
                            Text("Post Document",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      ),

                    ),
                  ],
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  height: height/5.3,
                  width: width/2.1,
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        color: Color(0XFFCECCCF),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: GestureDetector(onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => post_docutment()));
                    },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Icon(Icons.today,),
                          Text("Schedule",style: TextStyle(
                            fontWeight: FontWeight.bold,


                          ),)
                        ],
                      ),
                    ),

                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: height/8.3,
                      width: width/2.7,
                      margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: Color(0XFFCECCCF),
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: GestureDetector(
                        onTap: ()
                        {
                          FirebaseAuth.instance.signOut();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.swap_horizontal_circle,),
                            Text("Logout",style: TextStyle(

                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      ),

                    ),
                  ],
                )
              ],
            ),





          ],

    ),),);
  }
}