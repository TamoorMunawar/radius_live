import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/widgets/button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/network_utils.dart';
import '../../../domain/entities/logictis/logistics.dart';
import '../../../domain/repository/logistics_repo.dart';
import '../job_dashboard_screen.dart';

class ComplainScreen extends StatefulWidget {
  const ComplainScreen({super.key});

  @override
  State<ComplainScreen> createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
  List<Data> assetlist = [];
  List<TextEditingController> controllers = [];
  bool isLoading = true;
  bool isLoading1 = true;
  @override
  void initState() {
    super.initState();
    fetchassets();
  }

  Future<void> fetchassets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('${NetworkUtils.baseUrl}/get-user-logistics'),
      headers: authorizationHeaders(prefs),
    );
    print("https://radiusapp.online/api/v1/get-accepted-event");
    print(authorizationHeaders(prefs));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      final List<dynamic> data = jsonResponse['data'];
      print("accept event");
      setState(() {
        assetlist = data.map((item) => Data.fromJson(item)).toList();
        // Initialize controllers with existing returnQty values
        controllers = assetlist.map((asset) {
          return TextEditingController(text: asset.returnQty?.toString() ?? "");
        }).toList();
        isLoading = false;
      });
    } else {
      // Handle the error
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> sendPostRequest(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String url = '${NetworkUtils.baseUrl}/return-logistics-qty';

    // Construct the JSON body with the ids and quantities
    Map<String, dynamic> jsonBody = {
      "id": assetlist.map((asset) => asset.id).toList(),
      "quantity": controllers.map((controller) => int.tryParse(controller.text) ?? 0).toList(),
    };

    setState(() {
      isLoading1 = true;
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: authorizationHeaders(prefs),
        body: jsonEncode(jsonBody),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update successful!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() {
        isLoading1 = false;
      });
    }
  }
  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
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
            padding: EdgeInsets.only(
                left: SizeConfig.width(context, 0.05),
                right: SizeConfig.width(context, 0.05)),
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: SizeConfig.height(context, 0.02),
                left: SizeConfig.width(context, 0.05),
                right: SizeConfig.width(context, 0.05)),
            height: SizeConfig.height(context, 0.07),
            color: GlobalColors.backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Item List'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: SizeConfig.width(
                            context,
                            0.035,
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'QTY'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: SizeConfig.width(
                            context,
                            0.035,
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Return Quantity'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: SizeConfig.width(
                            context,
                            0.035,
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          buildDividerWidget(context: context),
          Expanded(
            child: ListView.builder(
              itemCount: assetlist.length,
              itemBuilder: (context, index) {
                final asset = assetlist[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Center(
                          child: Text(
                            asset.asset?.name ?? "",
                            style: TextStyle(
                              color: GlobalColors.goodMorningColor,
                              fontWeight: FontWeight.w400,
                              fontSize: SizeConfig.width(context, 0.040),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Center(
                          child: Text(
                            "${asset.quantity ?? ""}",
                            style: TextStyle(
                              color: GlobalColors.goodMorningColor,
                              fontWeight: FontWeight.w400,
                              fontSize: SizeConfig.width(context, 0.040),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: controllers[index],
                          onChanged: (value) {
                            int? inputValue = int.tryParse(value);
                            if (inputValue != null && inputValue > asset.quantity ) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Value cannot be greater than available quantity')),
                              );
                            }
                            assetlist[index].returnQty = inputValue ?? 0;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Value',
                            fillColor: GlobalColors.goodMorningColor,
                            border: const OutlineInputBorder(),
                          ),
                          style: TextStyle(
                            color: Colors.white, // Set text color to white
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.only(
          bottom: SizeConfig.height(context, 0.055),
        ),
        height: SizeConfig.height(context, 0.12),
        color: GlobalColors.primaryColor,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.width(context, 0.07),
            right: SizeConfig.width(context, 0.07),
          ),
          child: SubmitButton(
              onPressed: () async {
                await sendPostRequest(context);
              },
              child: Text(
                'Update'.tr(),
                style: TextStyle(
                  color: GlobalColors.submitButtonTextColor,
                  fontSize: SizeConfig.width(context, 0.04),
                  fontWeight: FontWeight.w500,
                ),
              )),
        ),
      ),
    );
  }
}

