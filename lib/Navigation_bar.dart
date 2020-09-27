import 'dart:core';
import 'package:aresapp/Chat.dart';
import 'package:aresapp/Description.dart';
import 'package:aresapp/Home_Screen.dart';
import 'package:aresapp/Profile_Update.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'Notification.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_friends.dart';


//void main() => runApp(MaterialApp(home: BottomNavBar()));
class navigation_bar extends StatefulWidget {
  static const String id ='navigation_bar';
  @override
  //_BottomNavBarState createState() => _BottomNavBarState();
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BottomNavBarState();
  }
}
class _BottomNavBarState extends State<navigation_bar> {
  int selectedpage = 2;
  final pageoption = [
    Descrption(),
    chatlist(),
    Home_screen(),
    notification(),
    Profileupdate(),
  ];

  GlobalKey _bottomNavigationKey = GlobalKey();


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: pageoption[selectedpage],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.send, size: 30, color: Colors.white,),
          Icon(Icons.message, size: 30,  color: Colors.white,),
          Icon(Icons.home, size: 30,  color: Colors.white,),
          Icon(Icons.notifications_none, size: 30,  color: Colors.white,),
          Icon(Icons.person, size: 30,  color: Colors.white,),
        ],
        color: Color(0xffe6e6e6),
        buttonBackgroundColor:  Color(0xff16001f),
        backgroundColor:      Colors.transparent,
        animationCurve: Curves.easeInOut,
        //animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            selectedpage = index;
          });
        },
      ),
//        Container(
//          color: Colors.blueAccent,
//          child: Center(
//            child: Column(
//              children: <Widget>[
//                Text(_page.toString(), textScaleFactor: 10.0),
//                RaisedButton(
//                  child: Text('Go To Page of index 1'),
//                  onPressed: () {
//                    final CurvedNavigationBarState navBarState =
//                        _bottomNavigationKey.currentState;
//                    navBarState.setPage(1);
//                  },
//                )
//              ],
//            ),
//          ),
//        )
    );
  }
}