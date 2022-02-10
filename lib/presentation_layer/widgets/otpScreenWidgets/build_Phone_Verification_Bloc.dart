import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bussines_logic_layer/phone_auth/phone_auth_cubit.dart';
import 'package:maps_app/constants/strings.dart';
import 'package:maps_app/presentation_layer/widgets/loginScreenWidgets/buildPhoneNumberSubmittedBloc.dart';

Widget buildPhoneVerificationBloc() {
  return BlocListener<PhoneAuthCubit, PhoneAuthState>(
    listenWhen: (previous, current) {
      return previous != current;
    },
    listener: (context, state) {
      if (state is Loading) {
        showProgressIndicator(context);
      }
      if (state is PhoneOtbVerified) {
        print('in PhoneOtbVerified');
        Navigator.pop(context);
        Navigator.of(context).pushReplacementNamed(
          mapScreen,
        );
      }
      if (state is ErrorOccurred) {
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
