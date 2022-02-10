import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bussines_logic_layer/phone_auth/phone_auth_cubit.dart';
import 'package:maps_app/constants/strings.dart';
import 'package:maps_app/presentation_layer/screens/login_screen.dart';
import 'package:maps_app/presentation_layer/screens/map_screen.dart';
import 'package:maps_app/presentation_layer/screens/otp_screen.dart';

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case otpScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<PhoneAuthCubit>.value(
                  child: OtpScreen(phoneNumber: phoneNumber),
                  value: phoneAuthCubit!,
                ));
      case loginScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<PhoneAuthCubit>.value(
                  child: LoginScreen(),
                  value: phoneAuthCubit!,
                ));
      case mapScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<PhoneAuthCubit>.value(
                  child: MapScreen(),
                  value: phoneAuthCubit!,
                ));
    }
  }
}
