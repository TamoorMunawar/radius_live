import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/route_arguments.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/cubits/forgot_password/forgot_password_cubit.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen(
      {super.key, required this.email, required this.otp, required this.countryCode, required this.isLoginWithMobile});

  final String countryCode;
  final bool isLoginWithMobile;
  final String email;
  final int otp;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var _emailController = TextEditingController();
  int counter = 45;
  late Timer _timer;

  double percentValue = 1;

  bool showResendCode = false;

  void startTimer() {
    print("aaaaaaaaaaaaaaaaaa");
    counter = 30;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (counter > 0) {
        if (mounted) {
          //  setState(() {
          counter--;
          // });
          if (counter == 27) {
            percentValue = 0.9;
          }
          if (counter == 24) {
            percentValue = 0.8;
          }
          if (counter == 21) {
            percentValue = 0.7;
          }
          if (counter == 18) {
            percentValue = 0.6;
          }
          if (counter == 15) {
            percentValue = 0.5;
          }
          if (counter == 12) {
            percentValue = 0.4;
          }
          if (counter == 9) {
            percentValue = 0.3;
          }
          if (counter == 6) {
            percentValue = 0.2;
          }
          if (counter == 3) {
            percentValue = 0.1;
          }
          if (counter == 0) {
            percentValue = 0.0;
            showResendCode = true;
          }
        }
      } else {
        _timer.cancel();
      }
    });
  }

  int numberOfFields = 6;
  String currentCode = '';
  late ForgotPasswordCubit forgotPasswordCubit;
  int otp = 0;
  @override
  void initState() {
    otp = widget.otp;
    print("widget.otp ${widget.email}");
    //  AppUtils.showFlushBar("OTP is ${widget.otp}", context);
    forgotPasswordCubit = BlocProvider.of<ForgotPasswordCubit>(context);
    // startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.backgroundColor,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.only(
          bottom: SizeConfig.height(context, 0.055),
          //  right: SizeConfig.width(context, 0.07),
        ),
        height: SizeConfig.height(context, 0.23),
        color: GlobalColors.backgroundColor,

        // color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.width(context, 0.07),
            right: SizeConfig.width(context, 0.07),
          ),
          child: Column(
            children: [
              SubmitButton(
                //    width: SizeConfig.width(context, 0.5),
                onPressed: () async {
                  forgotPasswordCubit.checkOtp(
                      isLoginWithMobile: widget.isLoginWithMobile,
                      countryCode: widget.countryCode,
                      email: widget.email,
                      otp: currentCode);
                  //   Navigator.pushNamed(context, AppRoutes.resetScreenRoute);
                },
                child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                  builder: (context, state) {
                    if (state is CheckOtpLoading) {
                      return LoadingWidget();
                    }
                    return Text(
                      'Reset Password'.tr(),
                      style: TextStyle(
                        color: GlobalColors.submitButtonTextColor,
                        fontSize: SizeConfig.width(context, 0.04),
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                  listener: (context, state) {
                    if (state is CheckOtpFailure) {
                      AppUtils.showFlushBar(state.errorMessage, context);
                    }
                    if (state is CheckOtpSuccess) {
                      Navigator.pushNamed(context, AppRoutes.resetScreenRoute,
                          arguments: ResetPasswordScreenRoute(
                              otp: int.parse(currentCode),
                              email: widget.email,
                              countryCode: widget.countryCode,
                              isLoginWithMobile: widget.isLoginWithMobile));
                    }
                  },
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              SubmitButton(
                //    width: SizeConfig.width(context, 0.5),
                onPressed: () async {
                  forgotPasswordCubit.forgotPassword(
                      countryCode: widget.countryCode,
                      email: widget.email,
                      isLoginWithMobile: widget.isLoginWithMobile);
                  //   Navigator.pushNamed(context, AppRoutes.resetScreenRoute);
                },
                child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                  builder: (context, state) {
                    if (state is ForgotPasswordLoading) {
                      return LoadingWidget();
                    }
                    return Text(
                      'Resend Code'.tr(),
                      style: TextStyle(
                        color: GlobalColors.submitButtonTextColor,
                        fontSize: SizeConfig.width(context, 0.04),
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                  listener: (context, state) {
                    if (state is ForgotPasswordFailure) {
                      AppUtils.showFlushBar(state.errorMessage, context);
                    }
                    if (state is ForgotPasswordSuccess) {
                      setState(() {
                        otp = state.otp;
                      });
                      AppUtils.showFlushBar("Otp Resend Successfully".tr(), context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: GlobalColors.backgroundColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: EdgeInsets.only(left: SizeConfig.width(context, 0.05), right: SizeConfig.width(context, 0.05)),
            child: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.width(context, 0.05),
            ),
          ),
          color: Colors.white,
        ),
        title: Text(
          "Forgot_Password".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(context, 0.05),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.height(context, 0.04),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.width(context, 0.13),
                  right: SizeConfig.width(context, 0.13),
                  bottom: SizeConfig.height(context, 0.02)),
              child: Text(
                "You’ll get an Email Address. Open the Message and find the verification code".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: GlobalColors.whiteColor,
                  fontSize: SizeConfig.width(context, 0.032),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.width(context, 0.13),
                right: SizeConfig.width(context, 0.13),
                bottom: SizeConfig.height(context, 0.06),
              ),
              child: RichText(
                  text: TextSpan(
                //style: DefaultTextStyle.of(context).style,
                children: [
                  (widget.isLoginWithMobile)
                      ? TextSpan(
                          text: "${widget.countryCode}${widget.email}  ",
                          style: TextStyle(
                              fontSize: SizeConfig.width(context, 0.035),
                              color: GlobalColors.whiteColor,
                              fontWeight: FontWeight.w400),
                        )
                      : TextSpan(
                          text: "${widget.email}  ",
                          style: TextStyle(
                              fontSize: SizeConfig.width(context, 0.035),
                              color: GlobalColors.whiteColor,
                              fontWeight: FontWeight.w400),
                        ),
                  TextSpan(
                    text: "Not You?".tr(),
                    style: TextStyle(
                        fontSize: SizeConfig.width(context, 0.04),
                        color: GlobalColors.whiteColor,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              )),
            ),
/*            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.width(context, 0.13),
                  right: SizeConfig.width(context, 0.13),
                  bottom: SizeConfig.height(context, 0.02)),
              child: Text(
                "${'OTP is'.tr()} $otp",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: GlobalColors.whiteColor,
                  fontSize: SizeConfig.width(context, 0.04),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),*/
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.width(context, 0.13),
                  right: SizeConfig.width(context, 0.13),
                  bottom: SizeConfig.height(context, 0.02)),
              child: Text(
                "Enter this Otp to forgot password".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: GlobalColors.whiteColor,
                  fontSize: SizeConfig.width(context, 0.036),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.width(context, 0.05),
                right: SizeConfig.width(context, 0.05),
                bottom: SizeConfig.height(context, 0.04),
              ),
              child: PinFieldAutoFill(
                codeLength: numberOfFields,
                autoFocus: true,
                decoration: BoxLooseDecoration(
                  textStyle: TextStyle(
                    color: GlobalColors.textFieldHintColor,
                    fontSize: SizeConfig.width(context, 0.05),
                  ),
                  strokeColorBuilder: PinListenColorBuilder(
                    GlobalColors.textFieldHintColor,
                    GlobalColors.textFieldHintColor,
                  ),
                ),
                onCodeSubmitted: (String verificationCode) {
                  // otp = verificationCode;
                  // currentCode = verificationCode;

                  // if (otp.length == numberOfFields) {
                  /* if (verificationCode.length == numberOfFields) {
                    forgotPasswordCubit.checkOtp(isLoginWithMobile: widget.isLoginWithMobile,
                        countryCode:widget.countryCode,
                        email: widget.email, otp: int.parse(currentCode));
                  }*/
                },
                onCodeChanged: (String? code) {
                  if (code?.length == 6) {
                    FocusManager.instance.primaryFocus?.unfocus();

                    currentCode = code ?? '';
                    forgotPasswordCubit.checkOtp(
                        isLoginWithMobile: widget.isLoginWithMobile,
                        countryCode: widget.countryCode,
                        email: widget.email,
                        otp: currentCode);
                  }
                },
                currentCode: currentCode,
              ),
            ),
/*            CircularPercentIndicator(
              radius: 80.0,
              lineWidth: 15.0,
              animation: true,
              percent: percentValue,
              backgroundColor: const Color(0xFFEF4A4A).withOpacity(0.2),
              center: Text(
                "${counter.toString()}:00",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: SizeConfig.width(context, 0.05)),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Color(0xFFC79E52),
            ),*/
          ],
        ),
      ),
    );
  }
}
