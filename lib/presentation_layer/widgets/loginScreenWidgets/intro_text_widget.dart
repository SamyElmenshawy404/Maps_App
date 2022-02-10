import 'package:flutter/material.dart';

Widget buildIntroText() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'What is your phone number?',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
      ),
      SizedBox(
        height: 30,
      ),
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 2,
        ),
        child: Text(
          'Please enter your phone number to verify your account',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    ],
  );
}
