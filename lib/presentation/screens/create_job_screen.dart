import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/route_arguments.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/cubits/events/create_job/create_job_cubit.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';
import 'package:radar/presentation/widgets/radius_text_field.dart';

class CreateJobScreen extends StatefulWidget {
  const CreateJobScreen({super.key, required this.args});

  final CreateJobScreenArgs args;

  @override
  State<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final _jobNameController = TextEditingController();
  final _totalMaleSalaryController = TextEditingController();
  final _totalFemaleSalaryController = TextEditingController();
  final _dailyMaleSalaryController = TextEditingController();
  final _dailyFemaleSalaryController = TextEditingController();
  late CreateJobCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of<CreateJobCubit>(context);
    // TODO: implement initState
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
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
        automaticallyImplyLeading: false,
        //  backgroundColor: GlobalColors.backgroundColor,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Create Job".tr(),
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
                cubit.createJob(
                    totalMaleSalary: _totalMaleSalaryController.text,
                    totalFemaleSalary: _totalFemaleSalaryController.text.trim(),
                    jobName: _jobNameController.text.trim(),
                    dailyMaleSalary: _dailyMaleSalaryController.text.trim(),
                    dailyFemaleSalary: _dailyFemaleSalaryController.text.trim(),
                    eventId: widget.args.id);
                /*forgotPasswordCubit.forgotPassword(
                    email: _emailController.text);*/
                //  Navigator.pushNamed(context, AppRoutes.otpScreenRoute);
              }
            },
            child: BlocConsumer<CreateJobCubit, CreateJobState>(
              builder: (context, state) {
                if (state is CreateJobLoading) {
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
                if (state is CreateJobFailed) {
                  AppUtils.showFlushBar(state.errorMessage, context);
                }if (state is CreateJobSuccess) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.pagesScreenRoute, (route) => false,
                      arguments: 0);
                  AppUtils.showFlushBar("Job Created SuccessFully".tr(), context);

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
                controller: _jobNameController,
                hintText: 'Job Name'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Job Name'.tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              RadiusTextField(
                textInputType: TextInputType.number,
                controller: _totalMaleSalaryController,
                hintText: 'Total Male Salary'.tr(),
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
                controller: _dailyMaleSalaryController,
                hintText: 'Daily Male Salary'.tr(),
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
                controller: _totalFemaleSalaryController,
                hintText: 'Total Female Salary'.tr(),
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
                controller: _dailyFemaleSalaryController,
                hintText: 'Daily Female Salary'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Can't be Empty".tr();
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
