import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:radar/constants/extensions.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/generate_route.dart';
import '../../../../constants/router.dart';
import '../../../../constants/size_config.dart';
import '../../../widgets/LoadingWidget.dart';
import 'otp_cubit.dart';

class VerificationDialog extends StatefulWidget {
  final String email;
  final String countryCode;
  final OtpCubit cubit;
  const VerificationDialog({super.key, required this.email, required this.countryCode,required this.cubit});

  @override
  State<VerificationDialog> createState() => _VerificationDialogState();
}

class _VerificationDialogState extends State<VerificationDialog> {
   TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _otpController ;
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(color: GlobalColors.backgroundColor, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Verify Now',
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
              child: Material(
                color: GlobalColors.backgroundColor,
                child: PinCodeTextField(
                  hintCharacter: "",
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
                    selectedFillColor: GlobalColors.primaryColor,
                    activeFillColor: GlobalColors.primaryColor,
                    inactiveFillColor: GlobalColors.primaryColor,
                    selectedColor: GlobalColors.submitButtonColor,
                  ),
                  cursorColor: GlobalColors.whiteColor,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: GlobalColors.submitButtonColor, // Set the button color here
                    ),
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
                  child: _isLoading
                      ? const LoadingWidget()
                      : ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: GlobalColors.submitButtonColor, // Set the button color here
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      setState(() {
                        _isLoading = true;
                      });

                      _formKey.currentState!.save();
                      widget.cubit
                          .checkOtp(
                          email: widget.email, otp: _otpController.text, countryCode: "+966")
                          .then((val) {
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.loginScreenRoute,
                              (route) => false,
                        );
                      });
                    },
                    child: Text(
                      "Verify",
                      style: TextStyle(
                        color: GlobalColors.submitButtonTextColor,
                        fontSize: SizeConfig.width(context, 0.04),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
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

