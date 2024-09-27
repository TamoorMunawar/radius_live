import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
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
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/network_utils.dart';
import '../../constants/size_config.dart';
import '../../data/reviewdropdown_service.dart';
import '../../domain/entities/lastest_event/latest_event_model.dart';
import '../../domain/entities/ushers/Department.dart';
import '../../domain/repository/logistics_repo.dart';

class ReviewScreen extends StatefulWidget {
  var usherId;
  var depertmentIdd;
  var depertmentName;
  // final Department? department;
  ReviewScreen({
    super.key,
    required this.usherId,
    required this.depertmentIdd,
    required this.depertmentName,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late TextEditingController _reviewController;
  late  List<LatestEventModel>attanfanceList;
  double _rating = 1;
  bool _isBanned = true;
  List<MyEvent> _eventList = [];
  List<Designation> _designationList = [];
  int? _selectedDesignationId;

  @override
  void initState() {
    super.initState();
    _fetchDesignations();
    _reviewController = TextEditingController();
    _futureGroups = fetchGroups();
    _getEventList();
  }

  Future<void> _fetchDesignations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('${NetworkUtils.baseUrl}/get-designation'),
      headers: authorizationHeaders(prefs),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        final List<dynamic> designations = data['data'];
        setState(() {
          _designationList =
              designations.map((item) => Designation.fromJson(item)).toList();
        });
      }
    } else {
      // Handle errors or show an error message
    }
  }

  final EventListUsecase _usecase =
      EventListUsecase(repository: RadarMobileRepositoryImpl());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? eventId;
  Future<List<Group>>? _futureGroups;
  int? selectedGroupId;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  LatestEventModel? eventValue;
  int? eventIdd;
  _getEventList() async {
    _eventList = await _usecase.getEventList();
    log(_eventList.length.toString());

    setState(() {
      eventId = _eventList[0].$1;
      eventIdd = eventValue?.id;
      print("eventId $eventIdd");
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
          "Current Event",
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
                if (widget.depertmentIdd == null) {
                  AppUtils.showFlushBar("Team is not assigned", context);
                  return;
                }
                context.read<ReviewCubit>().addReview(ReviewPayload(
                    review: _reviewController.text,
                    rating: _rating.toInt(),
                    usherId: widget.usherId,
                    teamId: widget.depertmentIdd ?? 0,
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
              if (widget.depertmentName != null)
                Padding(
                  padding: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        vertical: 0.02.sh, horizontal: 0.02.sh),
                    decoration: BoxDecoration(
                      border: Border.all(color: GlobalColors.hintTextColor),
                      borderRadius: BorderRadius.circular(0.02.sw),
                    ),
                    child: Text(widget.depertmentName ?? "",
                        style: TextStyle(
                          color: GlobalColors.hintTextColor,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ),
              SizedBox(height: 0.02.sh),
              Padding(
                padding: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
                child: DropdownButtonFormField<LatestEventModel>(
                  isExpanded: true,
                  dropdownColor: GlobalColors.backgroundColor,
                  padding: EdgeInsets.only(),
                  items:
                  attanfanceList.map((LatestEventModel item) {
                    return DropdownMenuItem<LatestEventModel>(
                      value: item,
                      child: Text(
                        item.eventName ?? "",
                        style: TextStyle(
                            color: GlobalColors.textFieldHintColor),
                      ),
                    );
                  }).toList(),
                  value: eventValue,
                  onChanged: (value) {
                    setState(() {
                      eventValue = value;
                      eventId = eventValue?.id;
                    });

                  },
                  decoration: InputDecoration(
                    filled: false,
                    hintText: 'Select Event'.tr(),
                    hintStyle: TextStyle(
                      color: GlobalColors.textFieldHintColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: GlobalColors.submitButtonColor
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
                      return 'Please select a Event';
                    }
                    return null;
                  },
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
                          'Blocked',
                          style: TextStyle(color: GlobalColors.hintTextColor),
                        ),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text(
                          'UnBlocked',
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
              FutureBuilder<List<Group>>(
                future: _futureGroups,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final groups = snapshot.data!;

                    // Set the initial value of selectedGroupId to the first group's id if it's not already set.
                    if (selectedGroupId == null && groups.isNotEmpty) {
                      selectedGroupId = groups[0].id;
                    }

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: GlobalColors.hintTextColor),
                          borderRadius: BorderRadius.circular(0.02.sw),
                        ),
                        child: DropdownButton<int?>(
                          dropdownColor: GlobalColors.backgroundColor,
                          value: selectedGroupId,
                          isExpanded: true,
                          underline: Container(),
                          padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
                          items: groups.map((group) {
                            return DropdownMenuItem<int?>(
                              value: group.id,
                              child: Text(
                                group.teamName,
                                style: TextStyle(
                                  color: GlobalColors.hintTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedGroupId = value;
                            });
                          },
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Text('No Group data available'));
                  }
                },
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
                    value: _selectedDesignationId ?? (_designationList.isNotEmpty ? _designationList[0].id : null), // Set initial value if not already selected
                    isExpanded: true,
                    underline: Container(),
                    padding: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
                    items: _designationList.map((designation) {
                      return DropdownMenuItem<int>(
                        value: designation.id,
                        child: Text(
                          designation.name,
                          style: TextStyle(
                            color: GlobalColors.hintTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedDesignationId = val;
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
                    validator: (val) =>
                        val!.isEmpty ? "This Field is Required*" : null,
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

class Designation {
  final int id;
  final String name;

  Designation({required this.id, required this.name});

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      id: json['id'],
      name: json['name'],
    );
  }
}
