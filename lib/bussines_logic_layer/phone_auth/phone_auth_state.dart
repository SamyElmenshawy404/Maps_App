part of 'phone_auth_cubit.dart';

@immutable
abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class Loading extends PhoneAuthState {}

class ErrorOccurred extends PhoneAuthState {
  final String errMsg;

  ErrorOccurred({required this.errMsg});
}

class PhoneNumberSubmitted extends PhoneAuthState {}

class PhoneOtbVerified extends PhoneAuthState {}
