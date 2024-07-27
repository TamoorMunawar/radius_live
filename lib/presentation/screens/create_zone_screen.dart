import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/route_arguments.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/domain/entities/Job.dart';
import 'package:radar/domain/entities/supervisior/Supervisior.dart';
import 'package:radar/presentation/cubits/create_zone/create_zone_cubit.dart';
import 'package:radar/presentation/cubits/jobs/job_cubit.dart';
import 'package:radar/presentation/cubits/supervisior/supervisior_cubit.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';
import 'package:radar/presentation/widgets/radius_text_field.dart';

class CreateZoneScreen extends StatefulWidget {
  const CreateZoneScreen({super.key, required this.args});

  final CreateZoneScreenArgs args;

  @override
  State<CreateZoneScreen> createState() => _CreateZoneScreenState();
}

class _CreateZoneScreenState extends State<CreateZoneScreen> {
  final _zoneNameController = TextEditingController();
  final _supervisiorNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _maleMainController = TextEditingController();
  final _femaleMainController = TextEditingController();
  final _malestbyController = TextEditingController();
  final _femalestbyController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> jobList = [
    "Male",
    "Female",
  ];
  String? job;
  late SupervisiorCubit supervisiorCubit;
  late JobCubit jobCubit;
  late CreateZoneCubit createZoneCubit;
  Supervisior? supervisiorDropDownValue;
  Job? jobDropDownValue;

  @override
  void initState() {
    supervisiorCubit = BlocProvider.of<SupervisiorCubit>(context);
    jobCubit = BlocProvider.of<JobCubit>(context);
    createZoneCubit = BlocProvider.of<CreateZoneCubit>(context);
    supervisiorCubit.getSupervisior();
    jobCubit.getJob(eventModelId: widget.args.eventId, isZone: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        elevation: 0,
        automaticallyImplyLeading: false,
        //  backgroundColor: GlobalColors.backgroundColor,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Create Zone".tr(),
          style: TextStyle(
            fontSize: SizeConfig.width(context, 0.05),
            color: GlobalColors.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
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
                createZoneCubit.createZone(
                  zoneName: _zoneNameController.text.trim(),
                  supervisiorId: supervisiorDropDownValue?.id,
                  malestbySeats: _malestbyController.text.trim(),
                  maleMainSeats: _maleMainController.text.trim(),
                  location: _locationController.text.trim(),
                  jobId: jobDropDownValue?.id,
                  femalestbySeats: _femalestbyController.text.trim(),
                  femaleMainSeats: _femaleMainController.text.trim(),
                  description: _descriptionController.text.trim(),
                  eventId: widget.args.eventId,
                );
              }
            },
            child: BlocConsumer<CreateZoneCubit, CreateZoneState>(
              builder: (context, state) {
                if (state is CreateZoneLoading) {
                  return LoadingWidget();
                }
                return Text(
                  'Create'.tr(),
                  style: TextStyle(
                    color: GlobalColors.submitButtonTextColor,
                    fontSize: SizeConfig.width(context, 0.04),
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
              listener: (context, state) {
                if (state is CreateZoneFailed) {
                  AppUtils.showFlushBar(state.errorMessage, context);
                }
                if (state is CreateZoneSuccess) {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.pagesScreenRoute, (route) => false,
                      arguments: 0);
                  AppUtils.showFlushBar("Zone Created SuccessFully".tr(), context);
                }
              },
            ),
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
              RadiusTextField(
                controller: _zoneNameController,
                hintText: 'Zone Name'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Zone Name'.tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              Padding(
                padding: EdgeInsets.only(
                  //  top: SizeConfig.height(context, 0.05),
                  //bottom: SizeConfig.height(context, 0.05),
                  left: SizeConfig.width(context, 0.07),
                  right: SizeConfig.width(context, 0.07),
                ),
                child: Material(
                  color: Colors.transparent,
                  shadowColor: const Color(0xff006DFC).withOpacity(0.16),
                  child: BlocConsumer<SupervisiorCubit, SupervisiorState>(
                    builder: (context, state) {
                      if (state is SupervisiorLoading) {
                        return LoadingWidget();
                      }
                      if (state is SupervisiorSuccess) {
                        return DropdownButtonFormField<Supervisior>(
                          dropdownColor: GlobalColors.backgroundColor,
                          padding: EdgeInsets.only(),
                          items: state.result.map((Supervisior item) {
                            return DropdownMenuItem<Supervisior>(
                              value: item,
                              child: Text(
                                item.name ?? "",
                                style: TextStyle(color: GlobalColors.textFieldHintColor),
                              ),
                            );
                          }).toList(),
                          value: supervisiorDropDownValue,
                          onChanged: (value) {
                            setState(() => supervisiorDropDownValue = value);
                          },
                          decoration: InputDecoration(
                            filled: false,
                            hintText: 'Select Supervsior'.tr(),
                            hintStyle: TextStyle(
                              color: GlobalColors.textFieldHintColor,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: GlobalColors.submitButtonColor
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
                              return 'Please select a Supervisior'.tr();
                            }
                            return null;
                          },
                        );
                      }
                      return Container();
                    },
                    listener: (context, state) {
                      if (state is SupervisiorFailure) {
                        AppUtils.showFlushBar(state.errorMessage, context);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              Padding(
                padding: EdgeInsets.only(
                  //  top: SizeConfig.height(context, 0.05),
                  //bottom: SizeConfig.height(context, 0.05),
                  left: SizeConfig.width(context, 0.07),
                  right: SizeConfig.width(context, 0.07),
                ),
                child: Material(
                  color: Colors.transparent,
                  shadowColor: const Color(0xff006DFC).withOpacity(0.16),
                  child: BlocConsumer<JobCubit, JobState>(
                    builder: (context, state) {
                      if (state is JobLoading) {
                        return LoadingWidget();
                      }
                      if (state is JobSuccess) {
                        return DropdownButtonFormField<Job>(
                          dropdownColor: GlobalColors.backgroundColor,
                          padding: EdgeInsets.only(),
                          items: state.result.map((Job item) {
                            return DropdownMenuItem<Job>(
                              value: item,
                              child: Text(
                                item.name ?? "",
                                style: TextStyle(color: GlobalColors.textFieldHintColor),
                              ),
                            );
                          }).toList(),
                          value: jobDropDownValue,
                          onChanged: (value) {
                            setState(() => jobDropDownValue = value);
                          },
                          decoration: InputDecoration(
                            filled: false,
                            hintText: 'Select Job'.tr(),
                            hintStyle: TextStyle(
                              color: GlobalColors.textFieldHintColor,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: GlobalColors.submitButtonColor
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
                              return 'Please select a Job'.tr();
                            }
                            return null;
                          },
                        );
                      }
                      return Container();
                    },
                    listener: (context, state) {
                      if (state is JobFailure) {
                        AppUtils.showFlushBar(state.errorMessage, context);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              RadiusTextField(
                textInputType: TextInputType.name,
                controller: _locationController,
                hintText: 'Enter Location'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Can't be Empty".tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              RadiusTextField(
                textInputType: TextInputType.name,
                controller: _descriptionController,
                hintText: 'Description'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Can't be Empty".tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              RadiusTextField(
                textInputType: TextInputType.number,
                controller: _maleMainController,
                hintText: 'Male main Salary'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Can't be Empty".tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              RadiusTextField(
                textInputType: TextInputType.number,
                controller: _malestbyController,
                hintText: 'Male (STBY)'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Can't be Empty".tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              RadiusTextField(
                textInputType: TextInputType.number,
                controller: _femaleMainController,
                hintText: 'Female Main'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Can't be Empty".tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              RadiusTextField(
                textInputType: TextInputType.number,
                controller: _femalestbyController,
                hintText: 'Female (STBY)'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Can't be Empty".tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
