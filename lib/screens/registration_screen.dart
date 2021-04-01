import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/components/reusable_button.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'register_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool passVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showLoading,

        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
               // mainAxisAlignment: MainAxisAlignment.center,
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
                      controller: emailController,
                      decoration: kEmailTextFieldStyle,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Material(
                    child: TextField(
                      controller: passController,
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
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 20.0),
                        hintText: 'Enter Password',
                        icon: Icon(
                          Icons.lock,
                          color: Colors.lightBlueAccent,
                        ),
                        suffixIcon: IconButton(
                          icon: passVisibility
                              ? Icon(
                                  Icons.visibility,
                                  color: Colors.lightBlueAccent,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: Colors.lightBlueAccent,
                                ),
                          onPressed: () {
                            setState(() {
                              passVisibility = !passVisibility;
                            });
                          },
                        ),
                      ),
                      obscureText: passVisibility,
                      obscuringCharacter: '*',

                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Material(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Colors.blue),
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3.0, color: Colors.blue),
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        labelText: '  Confirm Password',
                        labelStyle: TextStyle(fontSize: 20.0),
                        hintText: 'ReEnter Password',
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ReusableButton(
                    title: 'Register',
                    btnColor: Colors.lightBlueAccent,
                    onPress: () async {
                      setState(() {
                        showLoading = true;
                      });
                      try {
                        final authorizedUser = await _auth.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text);
                        if (authorizedUser != null) {
                           await Navigator.pushNamedAndRemoveUntil(
                              context, ChatScreen.id, (route) => false);
                        }
                        setState(() {
                          showLoading = false ;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
