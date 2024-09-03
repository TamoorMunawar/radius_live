import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/logger.dart';
import 'package:radar/constants/route_arguments.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/cubits/forgot_password/forgot_password_cubit.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var _emailController = TextEditingController();
  late ForgotPasswordCubit forgotPasswordCubit;
  String loginCountryCode = '+966';
  final formkey = GlobalKey<FormState>();
  final _loginMobileController = TextEditingController();
  String loginPhoneNumber = '';

  @override
  void initState() {
    //_emailController.text = "test@gmail.com";
    forgotPasswordCubit = BlocProvider.of<ForgotPasswordCubit>(context);
    // TODO: implement initState
    super.initState();
  }

  bool isLoginWithMobile = true;

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
                forgotPasswordCubit.forgotPassword(
                  countryCode: loginCountryCode,
                  isLoginWithMobile: isLoginWithMobile,
                  email:
                      (isLoginWithMobile ?? false) ? _loginMobileController.text.trim() : _emailController.text.trim(),
                );
              }
            },
            child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
              builder: (context, state) {
                if (state is ForgotPasswordLoading) {

                  return LoadingWidget();
                }
                return Text(
                  'Verify'.tr(),
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
                  print("sssssssssssssssssssssssss ${state.otp}");
                  Navigator.pushNamed(context, AppRoutes.otpScreenRoute,
                      arguments: OtpScreenRoute(
                        otp: state.otp,
                        isLoginWithMobile: isLoginWithMobile ?? false,
                        countryCode: loginCountryCode,
                        email: (isLoginWithMobile) ? _loginMobileController.text.trim() : _emailController.text.trim(),
                      ));
                }
              },
            ),
          ),
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
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.height(context, 0.04),
              ),
              (isLoginWithMobile ?? false)
                  ? Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.width(context, 0.07),
                        right: SizeConfig.width(context, 0.07),
                      ),
                      child: Container(
                        child: IntlPhoneField(
                          keyboardType: TextInputType.numberWithOptions(
                            signed: true,
                            decimal: true,
                          ),
                          showDropdownIcon: false,
                          showCountryFlag: false,
                          controller: _loginMobileController,
                          dropdownTextStyle: TextStyle(
                            color: GlobalColors.textFieldHintColor,
                          ),
                          decoration: InputDecoration(
                            isDense: false,
                            contentPadding: const EdgeInsets.symmetric(vertical: 20),
                            counterText: "",
                            filled: false,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: GlobalColors.hintTextColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                SizeConfig.width(context, 0.02),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: GlobalColors.hintTextColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                SizeConfig.width(context, 0.02),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: GlobalColors.hintTextColor,
                                // width: SizeConfig.width(context, 0.005),
                              ),
                              borderRadius: BorderRadius.circular(
                                SizeConfig.width(context, 0.02),
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: GlobalColors.hintTextColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                SizeConfig.width(context, 0.02),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: GlobalColors.hintTextColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                SizeConfig.width(context, 0.02),
                              ),
                            ),
                            hintText: "Mobile_Number".tr(),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: GlobalColors.textFieldHintColor,
                            ),
                          ),
                          style: TextStyle(
                            color: GlobalColors.textFieldHintColor,
                            //    GlobalColors.textFieldHintColor,
                            //     fontSize: SizeConfig.width(context, 0.04),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            // height: 0.09,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialCountryCode: 'SA',
                          onChanged: (phone) {
                            loginCountryCode = phone.countryCode;
                            loginPhoneNumber = phone.completeNumber;

                            // print(phone.completeNumber);
                          },
                          onCountryChanged: (country) {
                            loginCountryCode = country.code;
                            _loginMobileController.clear();
                          },
                          validator: (PhoneNumber? value) {
                            if (value == null || value.number.isEmpty) {
                              return 'Mobile_number_is_required'.tr();
                            }

                            return null;
                          },
                        ),
                      ),
                    )
                  : RadiusTextField(
                      controller: _emailController,
                      hintText: 'Email_Address'.tr(),
                      validator: (String? value) {
                        if (value == null || value.isEmpty || !EmailValidator.validate(value)) {
                          return 'Please_Enter_Valid_Email_Address'.tr();
                        }
                        return null;
                      },
                    ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.width(context, 0.07),
                  right: SizeConfig.width(context, 0.07),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLoginWithMobile = !isLoginWithMobile;
                        });
                        //Navigator.pushNamed(context, AppRoutes.forgotScreenRoute);
                      },
                      child: Text(
                        isLoginWithMobile ? "Forgot with email".tr() : "Forgot with mobile".tr(),
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.w500, color: GlobalColors.forgetPasswordColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
