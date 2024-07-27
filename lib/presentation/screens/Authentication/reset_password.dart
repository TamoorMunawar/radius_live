import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/cubits/forgot_password/forgot_password_cubit.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword(
      {super.key, required this.email, required this.otp, required this.isLoginWithMobile, required this.countryCode});

  final String email;
  final bool isLoginWithMobile;
  final String countryCode;
  final int otp;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  late ForgotPasswordCubit forgotPasswordCubit;

  @override
  void initState() {
    forgotPasswordCubit = BlocProvider.of<ForgotPasswordCubit>(context);

    super.initState();
  }

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.only(
          bottom: SizeConfig.height(context, 0.055),
          //  right: SizeConfig.width(context, 0.07),
        ),
        height: SizeConfig.height(context, 0.12),

        // color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.width(context, 0.07),
            right: SizeConfig.width(context, 0.07),
          ),
          child: SubmitButton(
              //    width: SizeConfig.width(context, 0.5),
              onPressed: () async {
                if (formkey.currentState!.validate()) {
                  forgotPasswordCubit.resetPassword(
                    isLoginWithMobile: widget.isLoginWithMobile,
                    countryCode: widget.countryCode,
                    email: widget.email,
                    otp: widget.otp,
                    confirmPassword: _confirmPasswordController.text.trim(),
                    password: _passwordController.text.trim(),
                  );
                }
              },
              child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                builder: (context, state) {
                  if (state is ResetPasswordLoading) {
                    return const LoadingWidget();
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
                  if (state is ResetPasswordFailure) {
                    AppUtils.showFlushBar(state.errorMessage, context);
                  }
                  if (state is ResetPasswordSuccess) {
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreenRoute, (route) => false);
                  }
                },
              )),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.width(context, 0.05),
              right: SizeConfig.width(context, 0.05),
            ),
            child: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.width(context, 0.05),
            ),
          ),
          color: Colors.white,
        ),
        title: Text(
          "Reset Password".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(context, 0.05),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.height(context, 0.04),
              ),
              RadiusTextField(
                isPassword: true,
                controller: _passwordController,
                hintText: 'New Password'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Password_Can't_be_Empty".tr();
                  }
                  if (value.length < 8) {
                    return "Password length should be more than 8".tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              RadiusTextField(
                isPassword: true,
                controller: _confirmPasswordController,
                hintText: 'Confirm Password'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Password Can't be Empty".tr();
                  }
                  if (value != _passwordController.text) {
                    return "Password should be same".tr();
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
