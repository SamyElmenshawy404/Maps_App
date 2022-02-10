import 'package:flutter/material.dart';
import 'package:maps_app/constants/my_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

Widget buildBinCodeFields(BuildContext context, String otpCode) {
  return Container(
    child: PinCodeTextField(
      autoFocus: true,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        borderWidth: 1,
        activeFillColor: MyColors.lightGrey,
        inactiveColor: MyColors.blue,
        inactiveFillColor: Colors.white,
        activeColor: MyColors.blue,
        selectedColor: MyColors.blue,
        selectedFillColor: Colors.white,
      ),
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      enableActiveFill: true,
      onCompleted: (submittedCode) {
        otpCode = submittedCode;
        print("submittedCode");
      },
      onChanged: (value) {
        // otpCode code;
        print(value);
      },
      appContext: context,
    ),
  );
}
