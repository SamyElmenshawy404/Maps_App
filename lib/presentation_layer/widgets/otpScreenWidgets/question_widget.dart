import 'package:flutter/material.dart';
import 'package:maps_app/constants/my_colors.dart';

Widget buildQuestionText(String phoneNumber) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Verify your phone number',
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
        child: RichText(
          text: TextSpan(
              text: 'Enter your 6 digit code numbers send to',
              style: TextStyle(color: Colors.black, fontSize: 18, height: 1.4),
              children: <TextSpan>[
                TextSpan(
                  text: '$phoneNumber',
                  style: TextStyle(color: MyColors.blue),
                ),
              ]),
        ),
      ),
    ],
  );
}
