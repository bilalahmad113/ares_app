import 'package:aresapp/Post_Document.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'constnt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final firestore = FirebaseFirestore.instance;
User loggedInUser;
String name = '';
class ChatScreen extends StatefulWidget
{
  final String email,uname;
  const ChatScreen({Key key, this.uname, this.email}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState(email);
}
class _ChatScreenState extends State<ChatScreen>
{
  final email;
  final messageTextController=TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messagetext;
  _ChatScreenState(this.email);



  Future Init() async
  {
    if(email!="admin@gmail.com") {
      User user =await FirebaseAuth.instance.currentUser;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      DocumentReference documentReference = await firestore.collection("Users")
          .document(email);
      documentReference.get().then((value) {
        name = value.get("name");
        setState(() {});
      });
    }
  }

  Future getData() async
  {
    User user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference collectionReference = firebaseFirestore.collection("messages");
    QuerySnapshot documentSnapshot = await collectionReference.getDocuments();
    List<QueryDocumentSnapshot> dataSnapshot = documentSnapshot.docs;

    setState(() {

    });
  }
  @override
  void initState()
  {
    getCurrentUser();
    Init();
    getData();
    super.initState();
  }
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
              }),
        ],
        title: Text(
          'Chat',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(email: email,),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messagetext = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      messageTextController.clear();
                      //Implement send functionality.
                      await firestore.collection('messages').doc(email).collection("admin").doc().setData(
                          {'text': messagetext, 'sender': loggedInUser.email,
                            'date': DateTime.now().toIso8601String().toString(),});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MessagesStream extends StatelessWidget
{
  final email;
  const MessagesStream({Key key, this.email}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('messages').doc(email).collection("admin").orderBy('date').snapshots(),
      builder: (context, snapshots)
      {
        if (!snapshots.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Color(0XFFCECCCF),
            ),
          );
        }
        final messages = snapshots.data.documents.reversed;
        List<MessageBubble> messageWidgets = [];
        for (var message in messages)
        {
          final datetime = message.get("date");
          final messageText = message.get("text");
          final messageSender = message.get("sender");
          final currentUser=loggedInUser.email;
          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            time: datetime,
          isme:  currentUser==messageSender,);
          messageWidgets.add(messageBubble);
        }
        return  Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}
class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender,this.text,this.time,this.isme});
   final String sender;
   final String text;
  final String time;
   final bool isme;
  @override
  Widget build(BuildContext context) {
    return 
      Padding(
        padding: EdgeInsets.all(10.0),
        child:
        Column(
          crossAxisAlignment:isme ? CrossAxisAlignment.end:CrossAxisAlignment.start,
          children:[

            Text(
              sender == "admin@gmail.com" ? "Admin" : '${name}',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54
            ),),
            Material(
              borderRadius:isme ? BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight:Radius.circular(30.0)):
              BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight:Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              elevation: 5.0,
              color:isme ? Color(0XFFCECCCF):Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                child: Text('$text ',
                style:TextStyle
                  (fontSize: 15.0,
                  color:isme ? Colors.white:Colors.black54
                )
                ,  ),
              ),
            ),
            Row(
              mainAxisAlignment:isme ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('${time.substring(11,19)}',
                      style:TextStyle
                        (fontSize: 15.0,
                          color:Colors.black
                      )
                      ,  ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );;
  }
}

