import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/cubits/change_password/change_password_cubit.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var _currentPasswordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  late ChangePasswordCubit changePasswordCubit;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    changePasswordCubit = BlocProvider.of<ChangePasswordCubit>(context);
    // TODO: implement initState
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
        height: SizeConfig.height(context, 0.12),
        color: GlobalColors.backgroundColor,

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
              if (formKey.currentState!.validate()) {
                changePasswordCubit.changePassword(
                    password: _newPasswordController.text.trim(),
                    confirmPassword: _confirmPasswordController.text.trim(),
                    currentPassword: _currentPasswordController.text.trim());
              }
            },
            child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
              listener: (context, state) {
                if (state is ChangePasswordFailure) {
                  AppUtils.showFlushBar(state.errorMessage, context);
                }
                if (state is ChangePasswordSuccess) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.loginScreenRoute, (route) => false);
                  AppUtils.showFlushBar(
                      "Password Has been change Successfully".tr(), context);
                }
              },
              builder: (context, state) {
                if (state is ChangePasswordLoading) {
                  return LoadingWidget();
                }
                return Text(
                  'Update'.tr(),
                  style: TextStyle(
                    color: GlobalColors.submitButtonTextColor,
                    fontSize: SizeConfig.width(context, 0.04),
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
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
            padding: EdgeInsets.only(left: SizeConfig.width(context, 0.05),right:  SizeConfig.width(context, 0.05)),
            child: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.width(context, 0.05),
            ),
          ),
          color: Colors.white,
        ),
        title: Text(
          "Change Password".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(context, 0.05),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.height(context, 0.04),
              ),
              RadiusTextField(isPassword: true,
                controller: _currentPasswordController,
                hintText: 'Current Password'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Current Password'.tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              RadiusTextField(isPassword: true,
                controller: _newPasswordController,
                hintText: 'New Password'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter New Password'.tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              RadiusTextField(isPassword: true,
                controller: _confirmPasswordController,
                hintText: 'Confirm New Password'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Confirm Password'.tr();
                  }if (value!=_newPasswordController.text) {
                    return 'Password should be same'.tr();
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
