import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

final _fireStore = FirebaseFirestore.instance;
User loggedInUser ;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String message='';
  var _messageController = TextEditingController();
  String mail ='';
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }


  void getCurrentUser()  {
    try {
      final User user =  _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

//  void getMessages() async {
//    final allCollection =
//        await _fireStore.collection('Messages').get(); // future
//    for (var eachDocument in allCollection.docs) {
//      print(eachDocument.data());
//    }
//  }

//  void getMessagesStream() async {
//    await for (var snapshot in _fireStore.collection('Messages').snapshots()) {
//      for (var eachDocument in snapshot.docs) {
//        print(eachDocument.data());
//      }
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, WelcomeScreen.id, (route) => false);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MessagesStream(),
              Container(
                decoration: kBottomContainerDecoration,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            message = val;
                          });
                        },
                        decoration: kInputFieldStyle,
                      ),
                    ),
                     TextButton(
                      onPressed: message.trim().isEmpty? null:() {
                        setState(() {
                           mail = loggedInUser.email;
                        });
                        _fireStore.collection('Messages').add({
                          'text': message,
                          'email': mail,
                          'time' : FieldValue.serverTimestamp(),
                        });
                        _messageController.clear();
                        setState(() {
                          _messageController.text='';
                        });
                      },
                      child: Text(
                        'Send',
                        style: TextStyle(
                            fontSize: 20.0, color: Colors.lightBlueAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('Messages').orderBy('time',descending: false).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<BubbleWidget> messagesBubblesWidgets = [];
          for (var eachDocument in snapshot.data.docs.reversed) {
            final String uemail = eachDocument.get('email');
            final String messageText = eachDocument.get('text');
            final time = eachDocument.get('time') as Timestamp;
            String currentUseEmail =loggedInUser.email;
            final messageBubble = BubbleWidget(
              message: messageText,
              email: uemail,
              isMe: uemail == currentUseEmail ? true : false,
              msgTime: time,
            );
            messagesBubblesWidgets.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: messagesBubblesWidgets,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class BubbleWidget extends StatelessWidget {
  BubbleWidget({
    @required this.message,
    @required this.email,
    this.isMe,
    this.msgTime,
  });

  final String message;
  final String email;
  final bool isMe;
  final Timestamp msgTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(
            '$email ',  // ${DateTime.fromMillisecondsSinceEpoch(msgTime.seconds * 1000)}
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black54,
            ),
          ),
          Material(
            color: isMe ? Colors.lightBlueAccent:Colors.white,
            elevation: 5.0,
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(30.0):Radius.circular(0.0),
              bottomLeft: Radius.circular(30.0),
              topRight: isMe ? Radius.circular(0.0): Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                message,
                style: TextStyle(fontSize: 17.0, color:isMe ? Colors.white: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
