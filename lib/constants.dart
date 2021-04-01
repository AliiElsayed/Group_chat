import 'package:flutter/material.dart';

const kButtonsTextStyle = TextStyle(
  fontSize: 17.0,
  color: Colors.white,
);
const kTitleTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 40.0,
  fontWeight: FontWeight.w800,
);

const kEmailTextFieldStyle = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
  floatingLabelBehavior: FloatingLabelBehavior.always,
  labelText: 'Uesr Email',
  labelStyle: TextStyle(fontSize: 20.0, color: Colors.lightBlueAccent),
  hintText: 'Enter E_mail',
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(60.0),
    ),
    borderSide: BorderSide(width: 2.0, color: Colors.blueAccent),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(60.0),
    ),
    borderSide: BorderSide(width: 3.0, color: Colors.lightBlueAccent),
  ),
);

const kBottomContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(
      color: Colors.lightBlue,
      width: 2.0,
    ),
  ),
);
const kInputFieldStyle = InputDecoration(
  contentPadding: EdgeInsets.only(left: 15.0),
  border: InputBorder.none,
  hintText: 'Type a new Message...',
);
