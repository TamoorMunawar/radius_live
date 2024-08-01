import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/extensions.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:radar/data/radar_mobile_repository_impl.dart';
import 'package:radar/domain/entities/review_payload/review_playload.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';
import 'package:radar/domain/usecase/event/event_list/event_list_usecase.dart';
import 'package:radar/presentation/cubits/review/review_cubit.dart';
import 'package:radar/presentation/cubits/review/review_state.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';
import 'package:radar/presentation/widgets/text_field.dart';
import '../../domain/entities/ushers/Department.dart';

class ReviewScreen extends StatefulWidget {
  final int usherId;

  final Department? department;
  const ReviewScreen({
    super.key,
    required this.usherId,
    required this.department,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late TextEditingController _reviewController;
  double _rating = 1;
  bool _isBanned = true;
  List<MyEvent> _eventList = [];

  final EventListUsecase _usecase = EventListUsecase(repository: RadarMobileRepositoryImpl());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? eventId;
  @override
  void initState() {
    _reviewController = TextEditingController();
    _getEventList();
    super.initState();
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  _getEventList() async {
    _eventList = await _usecase.getEventList();
    log(_eventList.length.toString());

    setState(() {
      eventId = _eventList[0].$1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
            child: Icon(
              Icons.arrow_back_ios,
              size: 0.05.sw,
            ),
          ),
          color: Colors.white,
        ),
        title: Text(
          "Review",
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: 0.05.sw,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      persistentFooterButtons: [
        BlocConsumer<ReviewCubit, ReviewState>(
          listener: (ctx, state) {
            if (state is ReviewSuccess) {
              AppUtils.showFlushBar("Reviewed Successfully", context);
            }
            if (state is ReviewFailure) {
              AppUtils.showFlushBar(state.errorMessage, context);
            }
          },
          builder: (ctx, state) {
            if (state is ReviewLoading) {
              return const LoadingWidget();
            }
            return SubmitButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                _formKey.currentState!.save();
                if (widget.department == null) {
                  AppUtils.showFlushBar("Team is not assigned", context);
                  return;
                }
                context.read<ReviewCubit>().addReview(ReviewPayload(
                    review: _reviewController.text,
                    rating: _rating.toInt(),
                    usherId: widget.usherId,
                    teamId: widget.department?.id ?? 0,
                    isBanned: _isBanned,
                    eventId: eventId ?? 0));
              },
              height: 0.06.sh,
              child: Text(
                'Update'.tr(),
              ),
            );
          },
        ),
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 0.02.sh),
              if (widget.department != null)
                Padding(
                  padding: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 0.02.sh),
                    decoration: BoxDecoration(
                      border: Border.all(color: GlobalColors.hintTextColor),
                      borderRadius: BorderRadius.circular(0.02.sw),
                    ),
                    child: Text(widget.department?.teamName ?? "",
                        style: TextStyle(
                          color: GlobalColors.hintTextColor,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ),
              SizedBox(height: 0.02.sh),
              Padding(
                padding: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: GlobalColors.hintTextColor),
                    borderRadius: BorderRadius.circular(0.02.sw),
                  ),
                  child: DropdownButton(
                    dropdownColor: GlobalColors.backgroundColor,
                    value: _isBanned,
                    isExpanded: true,
                    underline: Container(),
                    padding: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
                    items: [
                      DropdownMenuItem(
                        value: true,
                        child: Text(
                          'Banned',
                          style: TextStyle(color: GlobalColors.hintTextColor),
                        ),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text(
                          'Not Banned',
                          style: TextStyle(color: GlobalColors.hintTextColor),
                        ),
                      ),
                    ],
                    onChanged: (val) {
                      setState(() {
                        _isBanned = val!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 0.02.sh),
              Padding(
                padding: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: GlobalColors.hintTextColor),
                    borderRadius: BorderRadius.circular(0.02.sw),
                  ),
                  child: DropdownButton<int?>(
                    dropdownColor: GlobalColors.backgroundColor,
                    value: eventId,
                    isExpanded: true,
                    underline: Container(),
                    padding: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
                    items: [
                      for (int i = 0; i < _eventList.length; i++)
                        DropdownMenuItem(
                          value: _eventList[i].$1,
                          child: Text(
                            _eventList[i].$2,
                            style: TextStyle(color: GlobalColors.hintTextColor),
                          ),
                        ),
                    ],
                    onChanged: (val) {
                      setState(() {
                        eventId = val;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 0.02.sh),
              Padding(
                padding: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
                child: SizedBox(
                  height: 0.15.sh,
                  child: RadiusTextField(
                    controller: _reviewController,
                    hintText: 'Type Message',
                    validator: (val) => val!.isEmpty ? "This Field is Required*" : null,
                    maxLength: null,
                    leftPadding: 0,
                    rightPadding: 0,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                  ),
                ),
              ),
              SizedBox(height: 0.02.sh),
              RatingBar(
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                alignment: Alignment.center,
                filledColor: GlobalColors.submitButtonColor,
                size: 0.08.sh,
                onRatingChanged: (value) {
                  setState(() {
                    _rating = value;
                  });
                  log(_rating.toString());
                },
                initialRating: _rating,
                maxRating: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
