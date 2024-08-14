import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../constants/colors.dart';
import '../../../constants/network_utils.dart';
import '../../../constants/size_config.dart';
import '../../../domain/repository/logistics_repo.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/radius_text_field.dart';

class UpdateGroupCode extends StatefulWidget {
  const UpdateGroupCode({super.key});

  @override
  State<UpdateGroupCode> createState() => _UpdateGroupCodeState();
}

class _UpdateGroupCodeState extends State<UpdateGroupCode> {
  final formkey = GlobalKey<FormState>();
  var groupCodeController = TextEditingController();
  bool _isLoading = false;

  Future<void> updateGroupCode() async {
    if (formkey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      final String groupCode = groupCodeController.text;
      var url = Uri.parse('${NetworkUtils.baseUrl}/update-user-group');

      try {
        final response = await http.post(
          url,
          headers: authorizationHeaders(prefs),
          body: jsonEncode(<String, dynamic>{
            'group_code': groupCode,
          }),
        );

        if (response.statusCode == 200) {
          // If the server returns an OK response, parse the response body.
          final responseData = json.decode(response.body);
          // Handle the response data as needed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Group code updated successfully!')),
          );
           // Clear the input field
        } else {
          // If the server did not return a 200 OK response, throw an error.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update group code')),
          );
        }
      } catch (e) {
        // Handle any errors that occurred during the request
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      }
    }
  }
@override
  void dispose() {
    // TODO: implement dispose
  groupCodeController.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.only(
          bottom: SizeConfig.height(context, 0.055),
        ),
        height: SizeConfig.height(context, 0.12),
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.width(context, 0.07),
            right: SizeConfig.width(context, 0.07),
          ),
          child: _isLoading
              ? Center(child: CircularProgressIndicator()) // Show loading indicator
              : SubmitButton(
            onPressed: updateGroupCode,
            child: Text(
              'Update Group'.tr(),
              style: TextStyle(
                color: GlobalColors.submitButtonTextColor,
                fontSize: SizeConfig.width(context, 0.04),
                fontWeight: FontWeight.w500,
              ),
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
          "Group Code".tr(),
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
              RadiusTextField(
                controller: groupCodeController,
                hintText: 'Group Code'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please_group_code'.tr();
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
