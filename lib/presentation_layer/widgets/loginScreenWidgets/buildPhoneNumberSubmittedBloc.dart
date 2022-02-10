import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bussines_logic_layer/phone_auth/phone_auth_cubit.dart';
import 'package:maps_app/constants/strings.dart';

Widget buildPhoneNumberSubmittedBloc(var phoneNumber) {
  return BlocListener<PhoneAuthCubit, PhoneAuthState>(
    listenWhen: (previous, current) {
      return previous != current;
    },
    listener: (context, state) {
      if (state is Loading) {
        print('Loading');
        showProgressIndicator(context);
      }
      if (state is PhoneNumberSubmitted) {
        print('PhoneNumberSubmitted');
        Navigator.pop(context);
        Navigator.of(context).pushNamed(otpScreen, arguments: phoneNumber);
      }
      if (state is ErrorOccurred) {
        print('ErrorOccurred');
        Navigator.pop(context);
        String errMsg = (state).errMsg;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errMsg),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 3),
          ),
        );
      }
    },
    child: Container(),
  );
}

void showProgressIndicator(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    ),
  );
  showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) => alertDialog);
}
