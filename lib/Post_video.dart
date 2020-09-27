import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Navigation_bar.dart';
import 'listitem.dart';

class upload_docutment extends StatefulWidget {
  @override
  _upload_docutmentState createState() => _upload_docutmentState();
}

List<String> docPaths;

class _upload_docutmentState extends State<upload_docutment> {
  String filename;
  bool uploadvedio = false;
  bool type = false;
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  VideoPlayerController _controller;

  Future<void> _initializeVideoPlayerFuture;
  File videoFile;
  var docPaths;
  String _uploadedFileURL;
  final controllertitle = TextEditingController();
  final controllerdescr = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllertitle.dispose();
    controllerdescr.dispose();
    super.dispose();
  }

  String _selectedLocation;
  String title, descrption, vediotype, link;
  var user = FirebaseAuth.instance.currentUser;
  String dropdownValue = 'Beginner Carriculum';
  List<String> _dropdownValues = [
    "Beginner Carriculum",
    "Kids Space",
    "Drills"
  ];
  void _getDocuments() async {
    docPaths = await ImagePicker.pickVideo(source: ImageSource.gallery);
    File file = File(docPaths.path);
    filename = basename(file.path);
  }
  Future Upload() async {
    uploadvedio = true;
    videoFile = docPaths;
    _controller = VideoPlayerController.file(videoFile);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('videos/' + filename);
    StorageUploadTask uploadTask = await firebaseStorageRef.putFile(
        videoFile, StorageMetadata(contentType: 'video/mp4'));
    StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
    _uploadedFileURL = await firebaseStorageRef.getDownloadURL();
    print(_uploadedFileURL);
    print("upload successfully");
  }

  void showtoast2() {
    Fluttertoast.showToast(
        msg: 'Select vedio type',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.black);
  }

  void showtoast() {
    Fluttertoast.showToast(
        msg: 'no vedio uploaded ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.black);
  }

  void showToast1() {
    Fluttertoast.showToast(
        msg: 'save successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white);
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
                height: height / 5.5,
                width: width / 1,
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
                            MaterialPageRoute(
                                builder: (context) => navigation_bar()));
                      },
                    ),
                    SizedBox(
                      width: width / 4.5,
                    ),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'asseds/Areslogo.png',
                          width: width / 3,
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height / 25,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text(
                      "Title",
                      style: TextStyle(
                          color: Color(0XFFCECCCF),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: height / 70,
              ),
              Column(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      width: width / 1.2,
                      height: height / 12,
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Title';
                            }
                            return null;
                          },
                          onChanged: (value) {
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
                              hintText: "Enter video title",
                              fillColor: Color(0XFFCECCCF)),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: height / 70,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text(
                      "Descrption",
                      style: TextStyle(
                          color: Color(0XFFCECCCF),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: height / 70,
              ),
              Column(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      width: width / 1.2,
                      height: height / 12,
                      child: Form(
                        key: _formKey1,
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter descrption';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            descrption = value;
                          },
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(30.0),
                                ),
                                borderSide: BorderSide(
                                  width: width / 20,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.white),
                              hintText: "Enter vedio Description",
                              fillColor: Color(0XFFCECCCF)),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: height / 70,
              ),

              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text(
                      "video",
                      style: TextStyle(
                          color: Color(0XFFCECCCF),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: height / 70,
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: width / 12,
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
                        height: height / 11.8,
                        width: width / 1.2,
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: width / 20,
                            ),
                            Text(
                              "Enter type",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            SizedBox(
                              width: width / 25,
                            ),
                            DropdownButton(
                              value: _selectedLocation,
                              onChanged: (String value) {
                                setState(() {
                                  _selectedLocation = value;
                                  type = true;
                                });
                              },
                              items: _dropdownValues
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
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
                    ],
                  ),
                  SizedBox(
                    height: height / 70,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                        child: Text(
                          "File browser",
                          style: TextStyle(
                              color: Color(0XFFCECCCF),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / 60,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: width / 12,
                      ),
                      Container(
                        decoration: new BoxDecoration(
                            color: Color(0XFFCECCCF),
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(25.0),
                              topRight: const Radius.circular(25.0),
                              bottomRight: const Radius.circular(25.0),
                              bottomLeft: const Radius.circular(25.0),
                            )),
                        height: height / 11.5,
                        width: width / 1.2,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Container(
                                child: Icon(
                                  Icons.insert_drive_file,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width / 1.8,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.file_upload,
                                    ),
                                    iconSize: 30.0,
                                    color: Colors.white,
                                    onPressed: () async {
                                      print("helo");
                                      // _getDocuments();
                                      print("Uploading....");
                                      // getVideo();
                                      await _getDocuments();
                                    },
                                  ),
                                  if (docPaths != null)
                                    Text(
                                      docPaths.join('\n'),
                                    )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height / 30,
              ),
              Container(
                width: width / 2.7,
                height: height / 14,
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.black,
                  child: Text(
                    'save',
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.black)),
                  onPressed: () async {
                    showLoaderDialog(context);
                    if (_formKey.currentState.validate()) {
                      if (_formKey1.currentState.validate()) {
                        if (type == false) {
                          showtoast2();
                        } else {
                          await Upload();
                          if (uploadvedio == false) {
                            showtoast();
                          } else {

                            print("uploading.....");
                            print(_uploadedFileURL);
                            FirebaseFirestore firebaseFirestore =
                                FirebaseFirestore.instance;
                            firebaseFirestore
                                .collection("Vedio")
                                .document()
                                .setData(
                                    // print('vedio');
                                    {
                                  "title": title,
                                  "descrption": descrption,
                                  "type": _selectedLocation,
                                  "file": _uploadedFileURL,
                                });
                            showToast1();
                            Navigator.pop(context);
                          }
                        }
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ));
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
