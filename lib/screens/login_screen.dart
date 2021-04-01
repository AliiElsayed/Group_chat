import'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class LogInScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _auth = FirebaseAuth.instance;
  bool  showLoading = false ;
  String email ;
  String password ;
  bool passVisibility = true;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showLoading,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Image(
                      image: AssetImage('assets/images/flash_logo.png'),
                      height: 100.0,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Material(
                    child: TextField(
                      onChanged: (val){
                        setState(() {
                          email = val;
                        });
                      },
                      controller: _nameController,
                      decoration: kEmailTextFieldStyle,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Material(
                    child: TextField(
                      onChanged: (val){
                        setState(() {
                          password = val;
                        });
                      },
                      controller: _passController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Colors.blue),
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Colors.blue),
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        labelText: '  Password',
                        labelStyle: TextStyle(fontSize: 20.0),
                        hintText: 'Enter Password',
                        icon: Icon(Icons.lock, color: Colors.lightBlueAccent,),
                        suffixIcon: IconButton(
                          icon: passVisibility ? Icon(Icons.visibility):Icon(Icons.visibility_off) ,
                          onPressed:(){
                            setState(() {
                              passVisibility = !passVisibility;
                            });
                          },
                        ),

                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: passVisibility,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  FlatButton(
                    height: 50.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    color: Colors.blueAccent,
                    onPressed: () {
                      setState(() {
                        showLoading = true;
                      });
                      try {
                        final signedUser = _auth.signInWithEmailAndPassword(
                            email: email, password: password );
                        if (signedUser != null) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, ChatScreen.id, (route) => false);
                        }
                        setState(() {
                          showLoading = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
