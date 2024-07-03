import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/extensions.dart';
import 'package:radar/constants/generate_route.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/data/radar_mobile_repository_impl.dart';
import 'package:radar/domain/usecase/verification/verification_usecase.dart';
import 'package:radar/presentation/cubits/verification/verification_cubit.dart';
import 'package:radar/presentation/cubits/verification/verification_state.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';

class VerificationDialog extends StatefulWidget {
  final String email;
  final String countryCode;
  final bool fromLogin;
  const VerificationDialog({super.key, required this.email, required this.countryCode, required this.fromLogin});

  @override
  State<VerificationDialog> createState() => _VerificationDialogState();
}

class _VerificationDialogState extends State<VerificationDialog> {
  late final TextEditingController _otpController;
  @override
  void initState() {
    log(widget.email);
    log(widget.countryCode);
    _otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _otpController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerificationCubit(VerificationUsecase(repository: RadarMobileRepositoryImpl())),
      child: Container(
        decoration: BoxDecoration(color: GlobalColors.backgroundColor, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Verify phone number',
              style: TextStyle(color: GlobalColors.whiteColor),
            ),
            const SizedBox(height: 12),
            const Text(
              'To verify, enter the One-time passcode.',
              textAlign: TextAlign.center,
              style: TextStyle(color: GlobalColors.whiteColor),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: PinCodeTextField(
                hintCharacter: "0",
                hintStyle: const TextStyle(color: Colors.grey),
                controller: _otpController,

                appContext: context,
                textStyle: const TextStyle(color: GlobalColors.whiteColor),
                pastedTextStyle: const TextStyle(
                  color: GlobalColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,

                animationType: AnimationType.fade,
                validator: (v) {
                  if (v!.length < 6) {
                    return "Please enter your code";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                errorTextSpace: 24,

                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 0.055.sh,
                    fieldWidth: 0.05.sh,
                    activeColor: GlobalColors.submitButtonColor,
                    inactiveColor: GlobalColors.whiteColor,
                    disabledColor: GlobalColors.whiteColor,
                    selectedFillColor: GlobalColors.profileButtonColor,
                    activeFillColor: GlobalColors.profileButtonColor,
                    inactiveFillColor: GlobalColors.profileButtonColor,
                    selectedColor: GlobalColors.submitButtonColor),
                cursorColor: GlobalColors.whiteColor,

                // boxShadows: AppDecorations.commonShadow,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                //errorAnimationController: errorController,
                // controller: textEditingController,
                keyboardType: TextInputType.number,
                onChanged: (value) {},
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: SubmitButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: GlobalColors.submitButtonTextColor,
                        fontSize: SizeConfig.width(context, 0.04),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: BlocConsumer<VerificationCubit, VerificationState>(
                  listener: (context, state) {
                    if (state is CheckOtpFailure) {
                      AppUtils.showFlushBar(state.errorMessage, context);
                    }
                    if (state is CheckOtpSuccess) {
                      if (widget.fromLogin) {
                        AppUtils.showFlushBar("Account Verified Successfully", context);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => splashScreen(isProfile: true)),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  },
                  builder: (context, state) {
                    return SubmitButton(
                      onPressed: () {
                        context
                            .read<VerificationCubit>()
                            .checkOtp(email: widget.email, otp: _otpController.text, countryCode: widget.countryCode);
                      },
                      child: state is CheckOtpLoading
                          ? const LoadingWidget()
                          : Text(
                              "Verify".tr(),
                              style: TextStyle(
                                color: GlobalColors.submitButtonTextColor,
                                fontSize: SizeConfig.width(context, 0.04),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    );
                  },
                )),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
