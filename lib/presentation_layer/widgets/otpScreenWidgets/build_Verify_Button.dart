import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bussines_logic_layer/phone_auth/phone_auth_cubit.dart';
import 'package:maps_app/presentation_layer/widgets/loginScreenWidgets/buildPhoneNumberSubmittedBloc.dart';

Widget buildVerifyButton(BuildContext context, String otpCode) {
  return Align(
    alignment: Alignment.centerRight,
    child: ElevatedButton(
      onPressed: () {
        print('otpcode' + otpCode);
        showProgressIndicator(context);
        login(context, otpCode);
      },
      child: Text(
        'Verify',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(10, 50),
          primary: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: EdgeInsets.symmetric(horizontal: 35)),
    ),
  );
}

void login(BuildContext context, String otpCode) {
  BlocProvider.of<PhoneAuthCubit>(context).submitOtp(otpCode);
}
