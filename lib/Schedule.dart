import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:documents_picker/documents_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'Navigation_bar.dart';

class post_docutment extends StatefulWidget {
  @override
  _post_docutmentState createState() => _post_docutmentState();
}
final _text = TextEditingController();
final _formKey = GlobalKey<FormState>();
final _formKey1 = GlobalKey<FormState>();
class _post_docutmentState extends State<post_docutment>
{
  File file;
  var docPaths;
  bool uploaddocument=false;
  String link,title;
  String filename;
  void _getDocuments() async {
    docPaths = await DocumentsPicker.pickDocuments;
    file = File(docPaths[0]);
    filename = basename(file.path);
    // uploaddocument=true;
    // filename = basename(file.path);
    // StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
    // StorageUploadTask uploadTask = firebaseStorageRef.putFile(file);
    // StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    // link = await firebaseStorageRef.getDownloadURL();
    // if (!mounted) return;
    // setState(()async{
    //   filename =  basename(file.path);
    //   link = await firebaseStorageRef.getDownloadURL();
    // });
  }
  void upload()async{
    uploaddocument=true;
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = await firebaseStorageRef.putFile(file);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    link = await firebaseStorageRef.getDownloadURL();
  }
  void showtoast() {
    Fluttertoast.showToast(
        msg: 'no document uploaded ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.black
    );
  }
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

                height: height/6,
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


              SizedBox(
                height: height/20,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                    child: Text('file browse',style: TextStyle(
                      color: Color(0XFFCECCCF),
                    ),),
                  )
                ],
              ),
              SizedBox(height: height/40,),
              Container(
                decoration: new BoxDecoration(
                    color: Colors.black26,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0),
                      bottomRight: const Radius.circular(20.0),
                      bottomLeft: const Radius.circular(20.0),
                    )
                ),

          width: width/1.1,
                height: height/12,

                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,0,0),
                      child: Icon(Icons.insert_drive_file, size: 30, color: Colors.white,),
                    ),

                    SizedBox(
                      width: width/1.6,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,0,0),
                          child: IconButton(
                            icon: Icon(
                              Icons.file_upload,
                            ),
                            iconSize: 30.0,
                            color: Colors.white,
                            onPressed: () async {
                              await _getDocuments();

                            },
                          ),
                        ),


                      ],
                    )
                  ],

                ),
              ),
              SizedBox(height: height/20,),
              Container(
                width: width/2.2,
                height: height/16,
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.black,
                  child: Text('save', ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.black)
                  ),

                  onPressed: ()async {
                    showLoaderDialog(context);
                    await upload();
                    if(uploaddocument==false)
                    {
                  showtoast();
                    }else {
                      showToast1();
                      Navigator.pop(context);
                      print(link);
                      FirebaseFirestore firebaseFirestore = FirebaseFirestore
                          .instance;
                      firebaseFirestore.collection("Schedule")
                          .document()
                          .setData(
                          {
                            "file": link,
                            "title":filename
                            // 'title': filename,
                          }
                      );
                    }
                  },
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
