
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  ReusableButton({this.btnColor, this.title, @required this.onPress});
  final Color btnColor;
  final String title;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3.0,
      color: btnColor,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        minWidth: 200.0,
        height: 40.0,
        onPressed: onPress,
        child: Text(
          title,
          style: kButtonsTextStyle,
        ),
      ),
    );
  }
}
