part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {
  String errorMessage;
  final bool needOtp;
  final bool loading;
  String errorcode;
  LoginInitial(
      {this.errorMessage = "",
      this.loading = false,
      this.needOtp = false,
      this.errorcode = ""});

  LoginInitial copyWith({String? error, bool? loading, bool? otp}) {
    return LoginInitial(
        errorMessage: error ?? "",
        loading: loading ?? false,
        needOtp: otp ?? needOtp);
  }
}

class LoginLoading extends LoginState {}
