import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bussines_logic_layer/phone_auth/phone_auth_cubit.dart';
import 'package:maps_app/constants/my_colors.dart';
import 'package:maps_app/presentation_layer/widgets/otpScreenWidgets/build_Phone_Verification_Bloc.dart';
import 'package:maps_app/presentation_layer/widgets/otpScreenWidgets/question_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  final phoneNumber;
  String otpCode = '';

  OtpScreen({this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildQuestionText(phoneNumber),
                  SizedBox(height: 45),
                  Container(
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
                        print("otpCode" + otpCode);
                      },
                      onChanged: (value) {
                        this.otpCode = value;
                        // otpCode code;
                        print(value);
                      },
                      appContext: context,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Align(
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          padding: EdgeInsets.symmetric(horizontal: 35)),
                    ),
                  ),
                  buildPhoneVerificationBloc(),
                ],
              ),
            ),
          ),
        ),
      ),
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

  void login(BuildContext context, String otpCode) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOtp(otpCode);
  }
}
