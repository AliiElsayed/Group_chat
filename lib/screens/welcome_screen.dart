import 'package:flash_chat/components/reusable_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'Welcome_Screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(
        seconds: 1,
      ),
      vsync: this,
    );
    _animation = ColorTween(begin: Colors.grey, end: Colors.white).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.decelerate,
      ),
    );
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _animation.value,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage('assets/images/flash_logo.png'),
                    height: 65.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  speed: Duration(
                    milliseconds: 300,
                  ),
                  text: [
                    'Flash Chat',
                  ],
                  //repeatForever: false,
                  textStyle: kTitleTextStyle,
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            ReusableButton(
              btnColor: Colors.lightBlueAccent,
              title: 'LogIn',
              onPress: () {
                Navigator.pushNamed(context, LogInScreen.id);
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            ReusableButton(
              btnColor: Colors.blueAccent,
              title: 'Registr',
              onPress: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

