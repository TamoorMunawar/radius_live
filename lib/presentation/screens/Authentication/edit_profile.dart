import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

//import 'package:intl_phone_field/intl_phone_field.dart';
//import 'package:intl_phone_field/phone_number.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/generate_route.dart';
import 'package:radar/constants/logger.dart';
import 'package:radar/constants/route_arguments.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/domain/entities/country_code_model/country_code_model.dart';
import 'package:radar/presentation/cubits/change_password/change_password_cubit.dart';
import 'package:radar/presentation/cubits/profile/profile_cubit.dart';
import 'package:radar/presentation/cubits/verification/verification_cubit.dart';
import 'package:radar/presentation/cubits/verification/verification_state.dart';
import 'package:radar/presentation/screens/Authentication/verification_dialog.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, this.isBack = false, required this.phoneCode, this.isFromLogin = false});

  final bool isBack;
  final bool isFromLogin;
  final String phoneCode;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _whatsappNumberController = TextEditingController();
  final _idController = TextEditingController();
  String phoneNumber = "";
  String countryCode = "";

  String whatsappPhoneNumber = "";
  String whatsappCountryCode = "";
  String? imagePath;

  final ImagePicker _picker = ImagePicker();
  XFile? image;

  File? newImage;

  CountryCodeModel? whatappCode;
  CountryCodeModel? mobileCode;

  Future getUserDetailsFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("user_phonenumber ${_phoneNumberController.text}");
    print("user_phonenumberCountryCode $countryCode");

    setState(() {});
  }

  String email = "";
  String name = "";
  String imageUrl = "";
  // late ChangePasswordCubit changePasswordCubit;
  late ProfileCubit profileCubit;
  bool isLoading = false;
  List<CountryCodeModel> countryList = [];
  List<CountryCodeModel> stcpayList = [
    CountryCodeModel(code: "SA", label: "Saudi Arabia", phone: "966", phoneLength: 9),
    CountryCodeModel(code: "PR", label: "Puerto Rico", phone: "1", phoneLength: 10),
  ];

  Future getCountryListData() async {
    setState(() {
      isLoading = true;
    });

    for (int i = 0; i < AppUtils.countryList.length; i++) {
      countryList.add(CountryCodeModel.fromJson(AppUtils.countryList[i]));
    }
    print("outside condtion for each  ${whatsappCountryCode.replaceFirst("+", '')}");
    print("outside condtion for each  $whatsappCountryCode");
    print("outside condtion for each  ${countryCode.replaceFirst("+", '')}");
    if (whatsappCountryCode == null || whatsappCountryCode == "") {
      print("inside whatsappCountryCode == null ");
      whatappCode = countryList[181];
    }

    //  mobileCode = countryList[181];
    for (int i = 0; i < countryList.length; i++) {
      if (countryList[i].phone == "966") {
        print("element length ${countryList[i]}  index is $i");
      }

      /*   if (countryCode != null) {
        if (countryList[i].phone == countryCode.replaceFirst("+", '')) {
          print("inside if condtion for each");
          mobileCode = countryList[i];
        }
      }*/
      if (whatsappCountryCode != null) {
        if (countryList[i].phone == whatsappCountryCode.replaceFirst("+", '')) {
          print("inside if condtion for each");
          whatappCode = countryList[i];
        }
      }
    }
    mobileCode = countryList[181];
    setState(() {
      isLoading = false;
    });
    print("whatsapp code for each ${whatappCode?.phone}");
    print("mobile code for each ${mobileCode?.phone}");
    print("Country Code length ${countryList.length}");
  }

  @override
  void initState() {
    print("widget.phoneCode1 ${widget.phoneCode}");
    // changePasswordCubit = BlocProvider.of<ChangePasswordCubit>(context);
    profileCubit = BlocProvider.of<ProfileCubit>(context);
    profileCubit.getProfileDetails();
    //  getUserDetailsFromLocal();
    // TODO: implement initState
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

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
          child: BlocConsumer<VerificationCubit, VerificationState>(
            listener: (context, v) {
              if (v is SendOtpFailure) {
                AppUtils.showFlushBar(v.errorMessage, context);
              }
              if (v is SendOtpSuccess) {
                AppUtils.showFlushBar("Otp Sent successfully", context);
                showDialog(
                    builder: (c) => Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Material(
                            color: Colors.transparent,
                            child: VerificationDialog(
                              email: profileCubit.result?.email ?? _emailController.text,
                              countryCode: profileCubit.result?.email ?? _emailController.text,
                              fromLogin: false,
                              cubit: context.read<VerificationCubit>(),
                            ),
                          ),
                        ),
                    context: context);
              }

              if (v is CheckOtpFailure) {
                AppUtils.showFlushBar(v.errorMessage, context);
              }
              if (v is CheckOtpSuccess) {
                context.read<ChangePasswordCubit>().updateProfileV1(
                    mobileNumberCountryCode: "+966",
                    email: _emailController.text.trim(),
                    iqamaId: _idController.text.trim(),
                    name: _nameController.text.trim(),
                    image: newImage?.path ?? "",
                    number: _phoneNumberController.text.trim(),
                    whatsappNumberCountryCode: "+${whatappCode?.phone ?? "966"}",
                    whatsappNumber: _whatsappNumberController.text.trim());
              }
            },
            builder: (context, vState) {
              return SubmitButton(
                //    width: SizeConfig.width(context, 0.5),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    context.read<VerificationCubit>().sendOtp(
                          email: profileCubit.result?.email ?? _emailController.text,
                          countryCode: profileCubit.result?.countryPhonecode ?? "+966",
                          number: profileCubit.result?.mobile ?? _phoneNumberController.text,
                        );
                  }
                  //     Navigator.pushNamed(context, AppRoutes.resetScreenRoute);
                },
                child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                  listener: (context, state) async {
                    if (state is ChangePasswordFailure) {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool("isProfileUpdated", false);
                      AppUtils.showFlushBar(state.errorMessage, context);
                    }
                    if (state is UpdateProfileSuccess) {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool("isProfileUpdated", true);
                      AppUtils.showFlushBar("Profile Updated Successfully".tr(), context);

                      if (widget.isFromLogin) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => splashScreen(isProfile: false)),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.pagesScreenRoute, (route) => false,
                            arguments: 0);
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is ChangePasswordLoading) {
                      return const LoadingWidget();
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
              );
            },
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: GlobalColors.backgroundColor,
        centerTitle: true,
        leading: !(widget.isFromLogin)
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Padding(
                  padding:
                      EdgeInsets.only(left: SizeConfig.width(context, 0.05), right: SizeConfig.width(context, 0.05)),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: SizeConfig.width(context, 0.05),
                  ),
                ),
                color: Colors.white,
              )
            : Container(),
        title: Text(
          "Edit Profile".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(context, 0.05),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccess) {
            _emailController.text = state.profileModel.email ?? "";
            _nameController.text = state.profileModel.name ?? "";
            _whatsappNumberController.text = state.profileModel.whatsappNumber ?? "";

            _idController.text = state.profileModel.iqamaId ?? "";
            countryCode = state.profileModel.countryPhonecode ?? "";
            whatsappCountryCode = state.profileModel.whatsappCountryCode ?? "";
            _phoneNumberController.text = state.profileModel.mobile ?? "";
            imageUrl = state.profileModel.imageUrl ?? "";
            name = state.profileModel.name ?? "";
            email = state.profileModel.email ?? "Someone";

            print("profie image url $imageUrl");
            print("profie email ${state.profileModel.email}");
            print("profie whatsapp ${state.profileModel.whatsappNumber}");
            print("profie Whatsapp code ${state.profileModel.whatsappCountryCode}");
            print("profie mobile ${state.profileModel.mobile}");
            print("profie mobile country code ${state.profileModel.countryPhonecode}");
            getCountryListData();
            //  setState(() {});
          }
        },
        builder: (context, state) {
          if (state is ProfilLoading) {
            return LoadingWidget();
          }
          if (state is ProfileSuccess) {
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: SizeConfig.height(context, 0.02),
                    ),
                    Text(
                      "Please Upload  your clear image".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: SizeConfig.width(context, 0.035),
                        fontWeight: FontWeight.w800,
                        color: GlobalColors.textFieldHintColor,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.height(context, 0.04),
                    ),
                    InkWell(
                      onTap: () async {
                        var rng = math.Random();
                        var code = rng.nextInt(900000) + 100000;
                        image = await _picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        print("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv ${image?.path}");
                        if (!mounted) return;
                        imagePath = image?.path ?? "";

                        final bytes = await image?.readAsBytes();
                        final kb = bytes?.length ?? 0 / 1024;
                        final mb = kb / 1024;
                        print("original image size ${mb.toString()}");
                        final dir = await path_provider.getTemporaryDirectory();
                        final targetPath = "${dir.absolute.path}/temp$code.jpg";
                        final result = await FlutterImageCompress.compressAndGetFile(image!.path, targetPath,
                            minHeight: 1080, minWidth: 1080, quality: 70);
                        final data = await result!.readAsBytes();
                        final newkb = data.length / 1024;
                        final newMb = newkb / 1024;

                        setState(() {
                          newImage = File(result.path);
                        });
                        print("new image size ${newMb.toString()}   ${newImage?.path}");
                      },
                      child: (imagePath?.isNotEmpty ?? false)
                          ? CircleAvatar(
                              backgroundImage: FileImage(File(
                                newImage?.path ?? "",
                              )),
                              radius: SizeConfig.width(context, 0.15),
                            )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(imageUrl),

                              //                backgroundColor: Colors.red,
                              radius: SizeConfig.width(context, 0.15),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  //                  backgroundColor: Colors.red,
                                  radius: SizeConfig.width(context, 0.05),
                                  backgroundImage: AssetImage("assets/icons/edit_icon.png"),
                                ),
                              )),
                    ),
                    SizedBox(
                      height: SizeConfig.height(context, 0.04),
                    ),
                    SizedBox(
                      height: SizeConfig.height(context, 0.04),
                    ),
                    (widget.isFromLogin)
                        ? Text(
                            "Please Update Your Profile ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: SizeConfig.width(context, 0.045),
                              fontWeight: FontWeight.w800,
                              color: GlobalColors.textFieldHintColor,
                            ),
                          )
                        : Container(),
                    !(widget.isFromLogin)
                        ? Container()
                        : SizedBox(
                            height: SizeConfig.height(context, 0.04),
                          ),
                    RadiusTextField(
                      controller: _nameController,
                      hintText: 'Name'.tr(),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Name'.tr();
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.height(context, 0.02),
                    ),
                    RadiusTextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      textInputType: TextInputType.number,
                      controller: _idController,
                      hintText: 'Iqama Id'.tr(),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Iqama Id'.tr();
                        }
                        if (value.length != 10) {
                          return "Id Number Should  be of 10 digit ".tr();
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.height(context, 0.02),
                    ),
                    RadiusTextField(
                      readOnly: true,
                      controller: _emailController,
                      hintText: 'Email_Address'.tr(),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please_Enter_Email_Address'.tr();
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.height(context, 0.01),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.width(context, 0.07),
                        right: SizeConfig.width(context, 0.07),
                      ),
                      child: Text(
                        "Please_STCPAY".tr(),
                        style:
                            TextStyle(color: GlobalColors.submitButtonColor, fontSize: SizeConfig.width(context, 0.03)),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.height(context, 0.01),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.width(context, 0.07),
                        right: SizeConfig.width(context, 0.02),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: SizeConfig.width(context, 0.22),
                            //  color: Colors.transparent,
                            //shadowColor: const Color(0xff006DFC).withOpacity(0.16),
                            child: DropdownButtonFormField<CountryCodeModel>(
                              isExpanded: true,
                              dropdownColor: GlobalColors.backgroundColor,
                              items: countryList.map((CountryCodeModel item) {
                                return DropdownMenuItem<CountryCodeModel>(
                                  value: item,
                                  child: Text(
                                    "${item.phone}",
                                    style: TextStyle(color: GlobalColors.textFieldHintColor),
                                  ),
                                );
                              }).toList(),
                              value: mobileCode,
                              onChanged: (value) {
                                setState(() => mobileCode = value);
                              },
                              decoration: InputDecoration(
                                enabled: false,
                                filled: false,
                                hintText: ''.tr(),
                                hintStyle: TextStyle(
                                  color: GlobalColors.textFieldHintColor,
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.yellow
                                      //    color: GlobalColors.ftsTextColor,
                                      ),
                                  borderRadius: BorderRadius.circular(
                                    SizeConfig.width(context, 0.03),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.yellow
                                      //    color: GlobalColors.ftsTextColor,
                                      ),
                                  borderRadius: BorderRadius.circular(
                                    SizeConfig.width(context, 0.03),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: GlobalColors.hintTextColor,
                                    //    color: GlobalColors.ftsTextColor,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    SizeConfig.width(context, 0.03),
                                  ),
                                ),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                return null;
                              },
                            ),
                          ),
                          Expanded(
                            child: RadiusTextField(
                              textInputType: TextInputType.number,
                              controller: _phoneNumberController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(mobileCode?.phoneLength),
                              ],
                              hintText: 'STCPAY Number'.tr(),
                              validator: (String? value) {
                                if (value!.length != mobileCode!.phoneLength!) {
                                  return "Please enter correct number".tr();
                                }

                                if (value!.contains("+") || value == null || value.isEmpty) {
                                  return 'Enter_valid_stcpay_number'.tr();
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.height(context, 0.02),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.width(context, 0.07),
                        right: SizeConfig.width(context, 0.00),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: SizeConfig.width(context, 0.27),
                            //  color: Colors.transparent,
                            //shadowColor: const Color(0xff006DFC).withOpacity(0.16),
                            child: DropdownButtonFormField<CountryCodeModel>(
                              isExpanded: true,
                              dropdownColor: GlobalColors.backgroundColor,
                              items: countryList.map((CountryCodeModel item) {
                                return DropdownMenuItem<CountryCodeModel>(
                                  value: item,
                                  child: Text(
                                    "${item.code} ${item.phone}",
                                    style: TextStyle(color: GlobalColors.textFieldHintColor),
                                  ),
                                );
                              }).toList(),
                              value: whatappCode,
                              onChanged: (value) {
                                setState(() => whatappCode = value);
                              },
                              decoration: InputDecoration(
                                filled: false,
                                hintText: ''.tr(),
                                hintStyle: TextStyle(
                                  color: GlobalColors.textFieldHintColor,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.yellow
                                      //    color: GlobalColors.ftsTextColor,
                                      ),
                                  borderRadius: BorderRadius.circular(
                                    SizeConfig.width(context, 0.03),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: GlobalColors.hintTextColor,
                                    //    color: GlobalColors.ftsTextColor,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    SizeConfig.width(context, 0.03),
                                  ),
                                ),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select whatsapp Number Country Code'.tr();
                                }
                                return null;
                              },
                            ),
                          ),
                          Expanded(
                            child: RadiusTextField(
                              textInputType: TextInputType.number,
                              controller: _whatsappNumberController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(whatappCode?.phoneLength),
                              ],
                              hintText: 'Whatsapp_Number'.tr(),
                              validator: (String? value) {
                                if (value!.length != whatappCode!.phoneLength!) {
                                  return "Please enter correct number".tr();
                                }

                                if (value!.contains("+") || value == null || value.isEmpty) {
                                  return 'Enter_valid_whatsapp_number'.tr();
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.height(context, 0.02),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class CountryList {
  final String code;
  final String phone;
  final String label;
  final int phoneLength;

  CountryList({required this.phone, required this.label, required this.phoneLength, required this.code});
}
