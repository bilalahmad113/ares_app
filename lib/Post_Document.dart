import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'Navigation_bar.dart';
import 'package:documents_picker/documents_picker.dart';
import 'package:flutter/services.dart';
//import 'package:firebase_storage/firebase_storage.dart';
class docutment extends StatefulWidget {
  @override
  _docutmentState createState() => _docutmentState();
}
String _uploadedFileURL;
List<String> docPaths;
final _text = TextEditingController();
@override
void dispose() {
  _text.dispose();
}
class _docutmentState extends State<docutment>
{
  File file;
  var docPaths;

  bool uploaddocument=false;
  bool type=false;
  final _formKey = GlobalKey<FormState>();
  String _selectedLocation;
  String title , documenttype , link;
  String filename;
  var user = FirebaseAuth.instance.currentUser;
  // Default Drop Down Item.
  final List<String> _dropdownValues = [
    'Nutritional Plan',
    'Kids Space',
  ];

  void _getDocuments() async {
    docPaths = await DocumentsPicker.pickDocuments;
    file = File(docPaths[0]);
   filename = basename(file.path);
   //uploaddocument=true;
    // StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
    // StorageUploadTask uploadTask = firebaseStorageRef.putFile(file);
    // StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    // if (!mounted) return;
    // setState(() async{
    //   filename =  basename(file.path);
    //   link = await firebaseStorageRef.getDownloadURL();
    // });
  }
  void upload() async
  {
    uploaddocument=true;
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = await firebaseStorageRef.putFile(file);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    link = await firebaseStorageRef.getDownloadURL();
  }
  void showtoast1() {
    Fluttertoast.showToast(
        msg: 'select tpe of document ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.black
    );
  }
  void showtoast2() {
    Fluttertoast.showToast(
        msg: 'no document uploaded ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.black
    );
  }
  void showToast() {
    Fluttertoast.showToast(
        msg: 'saved successfully ',
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
                height:height/5.5,
                width: width/1,
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
                    Row(
                      children: <Widget>[
                        Image.asset('asseds/Areslogo.png',
                          width: width/3,)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: height/25,),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30,0,0,0),
                    child: Text("Title",style: TextStyle(
                        color: Color(0XFFCECCCF),fontWeight: FontWeight.bold
                    ),),
                  ),
                ],
              ),
              SizedBox(height: height/70,),
              Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: width/1.2,
                    height: height/12,
                    child: Form(
                      key: _formKey,
                      child:TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Title';
                          }
                          return null;
                        },
                        onChanged: (value)
                        {
                          title = value;
                        },
                      decoration: new InputDecoration(
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
                          hintText: "Enter Docutment title",
                          fillColor: Color(0XFFCECCCF)),
                    ),)),
                ],
              ),
              SizedBox(height: height/70,),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30,0,0,0),

                    child: Text("Documents Type",style: TextStyle(
                        color: Color(0XFFCECCCF),fontWeight: FontWeight.bold
                    ),),
                  ),
                ],
              ),
              SizedBox(height: height/70,),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: width/13,
                      ),
                      Container(
                        decoration: new BoxDecoration(
                          color: Color(0XFFCECCCF),
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(50.0),
                            topRight: const Radius.circular(40.0),
                            bottomLeft: const Radius.circular(40.0),
                            bottomRight: const Radius.circular(40.0),
                          ),
                        ),
                        width: width/1.17,
                        height: height/12,
                        alignment: Alignment.centerLeft,
                     padding: EdgeInsets.fromLTRB(0,0,0,0),

                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width:width/25,
                            ),
                            Text("Enter type",style: TextStyle(
                                color: Colors.white,fontSize: 16
                            ),),
                            SizedBox(
                              width: width/5,
                            ),
                            DropdownButton(
                              value: _selectedLocation,
                              onChanged: (String value)
                              {
                                setState(() {
                                  _selectedLocation = value;
                                  type=true;
                                });

                                //documenttype = value;
                              },
                              items: _dropdownValues.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              isExpanded: false,
                            ),
                          ],
                        ),
                      ),
                    ],),
                  SizedBox(
                    height: height/70,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25,0,0,0),

                        child: Text("File browser",style: TextStyle(
                            color: Color(0XFFCECCCF),fontWeight: FontWeight.bold
                        ),),
                      ),

                    ],
                  ),
                  SizedBox(height: height/60,),
                  Container(
                    decoration: new BoxDecoration(
                        color: Color(0XFFCECCCF),
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(25.0),
                          topRight: const Radius.circular(25.0),
                          bottomRight: const Radius.circular(25.0),
                          bottomLeft: const Radius.circular(25.0),
                        )
                    ),

                    height: height/11.8,
                    width: width/1.179,

                    child: Row(
                      children: <Widget>[


                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Icon(Icons.insert_drive_file, size: height/30, color: Colors.white,),
                        ),
                        SizedBox(
                          width: width/1.6,
                        ),
                        Flexible(
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.file_upload,
                                  ),
                                  iconSize: 30.0,
                                  color: Colors.white,
                                  onPressed: () async {
                                    await _getDocuments();
                                  }

                                ),
                                if (docPaths != null)
                                  Text(docPaths.join('\n'),

                                  )
                              ],),
                          ),
                        )],),),],
              ),

              SizedBox(height: height/30,),
              Container(
                width: width/2.7,
                height: height/14,
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.black,
                  child: Text('save', ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.black)
                  ),
                  onPressed: () async {
                    showLoaderDialog(context);
                    if (_formKey.currentState.validate()) {
                      if (type == false) {
                        showtoast1();
                      }
                      else {
                        await upload();
                        if (uploaddocument == false) {
                          showtoast2();
                        }

                        else {
                          print(link);
                          FirebaseFirestore firebaseFirestore = FirebaseFirestore
                              .instance;
                          firebaseFirestore.collection("Documents")
                              .document()
                              .setData(
                              {
                                "name": title,
                                "title": filename,
                                "type": _selectedLocation,
                                "file": link,
                              }

                          );
                          showToast();
                          Navigator.pop(context);
                        }
                      }

                    }
                  }
                ),
              ),
            ],
          ),
        )
    );
  }
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("UpLoading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

}
