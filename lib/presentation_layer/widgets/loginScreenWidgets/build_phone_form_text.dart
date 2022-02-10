import 'package:flutter/material.dart';
import 'package:maps_app/constants/my_colors.dart';

Widget buildPhoneFormText(var phoneNumber, GlobalKey<FormState> phoneFormKey) {
  return SingleChildScrollView(
    child: Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: MyColors.lightGrey),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Text(
                generateCountryFlag() + '+02',
                style: TextStyle(fontSize: 18, letterSpacing: 2),
              ),
            )),
        SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: MyColors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
              child: TextFormField(
                key: phoneFormKey,
                autofocus: true,
                style: TextStyle(letterSpacing: 2, fontSize: 18),
                decoration: InputDecoration(border: InputBorder.none),
                cursorColor: Colors.black,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your phone number';
                  } else if (value.length < 11) {
                    return 'Too short for a phone number!';
                  }
                  return null;
                },
                onSaved: (value) {
                  phoneNumber = value!;
                },
              )),
        ),
      ],
    ),
  );
}

String generateCountryFlag() {
  String countryCode = 'eg';
  String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

  return flag;
}
