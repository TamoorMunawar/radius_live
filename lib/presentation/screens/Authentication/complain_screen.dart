import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/widgets/button_widget.dart';
import 'package:radar/presentation/widgets/radius_text_field.dart';

class ComplainScreen extends StatefulWidget {
  const ComplainScreen({super.key});

  @override
  State<ComplainScreen> createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
  String? country;
  List<String> countryList = ["Special Event", "Type of Report"];
  var _currentPasswordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();

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
            padding: EdgeInsets.only(left: SizeConfig.width(context, 0.05), right: SizeConfig.width(context, 0.05)),
            child: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.width(context, 0.05),
            ),
          ),
          color: Colors.white,
        ),
        title: Text(
          "Logistics".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(context, 0.05),
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
        color: GlobalColors.primaryColor,

        // color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.width(context, 0.07),
            right: SizeConfig.width(context, 0.07),
          ),
          child: SubmitButton(

            onPressed: () {  },
            child:     Text(
              'Update'.tr(),
          style: TextStyle(
            color: GlobalColors.submitButtonTextColor,
            fontSize: SizeConfig.width(context, 0.04),
            fontWeight: FontWeight.w500,
          ),
        )
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.height(context, 0.04),
            ),
               Row(
                 children: [
                   Text(
                     'Item List',
                     style: TextStyle(
                       color: GlobalColors.goodMorningColor,
                       fontWeight: FontWeight.bold,
                       fontSize: SizeConfig.width(context, 0.040),
                     ),
                   ),
                   SizedBox(width: 10), // Add some spacing between widgets
                   Text(
                     'Qty',
                     style: TextStyle(
                       color: GlobalColors.goodMorningColor,
                       fontWeight: FontWeight.bold,
                       fontSize: SizeConfig.width(context, 0.040),
                     ),
                   ),
                 ],
               ),
               Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              'Wolkie talkie',
              style: TextStyle(
                color: GlobalColors.goodMorningColor,
                fontWeight: FontWeight.w400,
                fontSize: SizeConfig.width(context, 0.040),
              ),
            ),
            SizedBox(width: 10), // Add some spacing between widgets
            Text(
              '5',
              style: TextStyle(
                color: GlobalColors.goodMorningColor,
                fontWeight: FontWeight.w400,
                fontSize: SizeConfig.width(context, 0.040),
              ),
            ),
            SizedBox(width: 5), // Add some spacing between widgets
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Value',
                  fillColor: GlobalColors.goodMorningColor,
                  border: OutlineInputBorder(
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

            // Material(
            //   // elevation: 10.0,
            //
            //   color: Colors.transparent,
            //   shadowColor: const Color(0xff006DFC).withOpacity(0.16),
            //   child: DropdownButtonFormField<String>(
            //     dropdownColor: GlobalColors.backgroundColor,
            //     padding: EdgeInsets.only(left: SizeConfig.width(context, 0.07), right: SizeConfig.width(context, 0.07)),
            //     items: countryList.map((String item) {
            //       return DropdownMenuItem<String>(
            //         value: item,
            //         child: Text(
            //           item ?? "",
            //           style: TextStyle(color: GlobalColors.textFieldHintColor),
            //         ),
            //       );
            //     }).toList(),
            //     value: country,
            //     onChanged: (value) {
            //       setState(() => country = value);
            //     },
            //     decoration: InputDecoration(
            //       filled: false,
            //       hintText: 'Special Event'.tr(),
            //       hintStyle: TextStyle(
            //         color: GlobalColors.textFieldHintColor,
            //       ),
            //       border: OutlineInputBorder(
            //         borderSide: const BorderSide(color: GlobalColors.submitButtonColor
            //             //    color: GlobalColors.ftsTextColor,
            //             ),
            //         borderRadius: BorderRadius.circular(
            //           SizeConfig.width(context, 0.03),
            //         ),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(
            //           color: GlobalColors.hintTextColor,
            //           //    color: GlobalColors.ftsTextColor,
            //         ),
            //         borderRadius: BorderRadius.circular(
            //           SizeConfig.width(context, 0.03),
            //         ),
            //       ),
            //     ),
            //     autovalidateMode: AutovalidateMode.onUserInteraction,
            //     validator: (value) {
            //       if (value == null) {
            //         return 'Please select a country'.tr();
            //       }
            //       return null;
            //     },
            //   ),
            // ),
            // SizedBox(
            //   height: SizeConfig.height(context, 0.02),
            // ),
            // Material(
            //   // elevation: 10.0,
            //
            //   color: Colors.transparent,
            //   shadowColor: const Color(0xff006DFC).withOpacity(0.16),
            //   child: DropdownButtonFormField<String>(
            //     dropdownColor: GlobalColors.backgroundColor,
            //     padding: EdgeInsets.only(left: SizeConfig.width(context, 0.07), right: SizeConfig.width(context, 0.07)),
            //     items: countryList.map((String item) {
            //       return DropdownMenuItem<String>(
            //         value: item,
            //         child: Text(
            //           item ?? "",
            //           style: TextStyle(color: GlobalColors.textFieldHintColor),
            //         ),
            //       );
            //     }).toList(),
            //     value: country,
            //     onChanged: (value) {
            //       setState(() => country = value);
            //     },
            //     decoration: InputDecoration(
            //       filled: false,
            //       hintText: 'Type of Report'.tr(),
            //       hintStyle: TextStyle(
            //         color: GlobalColors.textFieldHintColor,
            //       ),
            //       border: OutlineInputBorder(
            //         borderSide: const BorderSide(color: GlobalColors.submitButtonColor
            //             //    color: GlobalColors.ftsTextColor,
            //             ),
            //         borderRadius: BorderRadius.circular(
            //           SizeConfig.width(context, 0.03),
            //         ),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(
            //           color: GlobalColors.hintTextColor,
            //           //    color: GlobalColors.ftsTextColor,
            //         ),
            //         borderRadius: BorderRadius.circular(
            //           SizeConfig.width(context, 0.03),
            //         ),
            //       ),
            //     ),
            //     autovalidateMode: AutovalidateMode.onUserInteraction,
            //     validator: (value) {
            //       if (value == null) {
            //         return 'Please select a country'.tr();
            //       }
            //       return null;
            //     },
            //   ),
            // ),
            // SizedBox(
            //   height: SizeConfig.height(context, 0.02),
            // ),
            // RadiusTextField(
            //   maxLength: 9,
            //   controller: _currentPasswordController,
            //   hintText: 'Type Message'.tr(),
            //   validator: (String? value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please_Enter_Email_Address'.tr();
            //     }
            //     return null;
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
