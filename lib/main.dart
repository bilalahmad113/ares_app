import 'package:aresapp/Chat.dart';
import 'package:aresapp/Post_Document.dart';
import 'package:aresapp/Home_Screen.dart';
import 'package:aresapp/Notification.dart';
import 'package:aresapp/Schedule.dart';
import 'package:aresapp/Splash_Screen.dart';
import 'package:aresapp/User_Request.dart';
import 'package:aresapp/User_management.dart';
import 'package:aresapp/Post_video.dart';
import 'package:flutter/material.dart';
import 'Login_Screen.dart';
import 'Forgot_Password.dart';
import 'Description.dart';
import 'package:aresapp/Profile_Update.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:splashscreen/splashscreen.dart';
import 'Navigation_bar.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue), home:splash_screen(),

     routes: <String, WidgetBuilder>
     {
       '/Home': (BuildContext context) => new LoginPage()
     },
    );
  }
}
