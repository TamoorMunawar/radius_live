import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/entities/login/Login.dart';

import 'package:radar/domain/usecase/login/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase usecase;

  LoginCubit(this.usecase) : super(LoginInitial());

  void login(
      {String? lat,
      String? lng,
      String? email,
      String? password,
      String? deviceToken,
      String? deviceId,
      String? deviceName,
      bool? isLoginWithMobile,
      String? countryCode}) async {
    try {
      emit(LoginLoading());
      Login login = await usecase.login(
        lng: lng,
        lat: lat,
        password: password,
        email: email,
        deviceToken: deviceToken,
        deviceId: deviceId,
        deviceName: deviceName,
        isLoginWithMobile: isLoginWithMobile,
        countryCode: countryCode,
      );
      log(login.isVerified.toString());
      emit(LoginSuccess(loginModel: login));
    } on Exception catch (e) {
      emit(
        LoginFailed(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void appUpdate({
    String? appVersion,
  }) async {
    try {
      emit(LoginLoading());
      bool result = await usecase.appUpdate(appVersion: appVersion);
      emit(AppUpdateSuccess(result: result));
    } on Exception catch (e) {
      emit(
        LoginFailed(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
