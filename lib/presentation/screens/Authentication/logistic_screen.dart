import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/widgets/button_widget.dart';
import '../../cubits/logistics/logistics_state.dart';
import '../job_dashboard_screen.dart';

class ComplainScreen extends StatefulWidget {
  const ComplainScreen({super.key});

  @override
  State<ComplainScreen> createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BuyAssetCubit>().fetchAssets();
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
              onPressed: () {},
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
                      'Input Field'.tr(),
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
          BlocBuilder<BuyAssetCubit, BuyAssetState>(
            builder: (context, state) {
              if (state is BuyAssetLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is BuyAssetLoaded) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.assets.length,
                    itemBuilder: (context, index) {
                      print(state.assets.length);
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  state.assets[index].assetName,
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
                                  "${state.assets[index].quantity}",
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
                                onChanged: (value) {
                                  // Handle value input here
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter Value',
                                  fillColor: GlobalColors.goodMorningColor,
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else if (state is BuyAssetError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
