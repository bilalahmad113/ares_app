import 'package:flutter/material.dart';
import 'Navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'Navigation_bar.dart';


class notification extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<notification> {
  final items =List<String>.generate(51, (i) => "item $i");
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
          child: Column(
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

                height: height/5,
                width: width/1,
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.center,
             // mainAxisAlignment: MainAxisAlignment.start,
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
              SizedBox(height: height/35,),

              SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  height: height / 1,
                  width: width / 1.01,
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, position) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            decoration: new BoxDecoration(
                                color: Color(0XFFFFFAFA),
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(10.0),
                                  topRight: const Radius.circular(30.0),
                                  bottomRight: const Radius.circular(30.0),
                                  bottomLeft: const Radius.circular(15.0),
                                )
                            ),
                            height: height/8,
                            width: width/1.5,


                            child:  Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20,0,0,0),

                                  child: CircleAvatar(
                                    radius: 18.0,
                                    backgroundImage: AssetImage("asseds/images1.jpg"),
                                  ) ,
                                ),
                                SizedBox(
                                  width: width/20,
                                ),
                                Container(
                                  color: Color(0XFFFFFAFA),
                                  width: width/2.5,
                                  height: height/10,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Align(alignment: Alignment.centerLeft, child: new Text("Sohail Ahmad",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),),
                                      SizedBox(height: height/95,),
                                      new Align(alignment: Alignment.centerLeft, child: new Text("Hi ! what are you doing",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.0,
                                        ),
                                      ),),

                                    ],

                                  ),
                                ),
                                SizedBox(width: width/5,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text('nov 2',style: TextStyle(
                                          fontSize: 8,
                                        ),),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0,0,0,0),

                                          child: CircleAvatar(
                                            radius: 5.0,
                                            backgroundImage: AssetImage("asseds/logo.jpeg"),
                                          ) ,
                                        ),

                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                        ),
                      );

                    },
                  ),
                ),
              )



            ],
          ),

      ),

    );
  }
}
