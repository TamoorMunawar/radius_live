import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/cubits/scan_qr_code/scan_qrcode_cubit.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:no_screenshot/no_screenshot.dart';

import '../../main.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String email = "";
  String name = "";
  String qrCode = "";
  NoScreenshot noScreenshot = NoScreenshot.instance;
  late ScanQrCodeCubit scanQrCodeCubit;

  @override
  void initState() {
    super.initState();
    getUserDetailsFromLocal();
    _preventScreenShot();
    scanQrCodeCubit = BlocProvider.of<ScanQrCodeCubit>(context);
    scanQrCodeCubit.getQrCode(latitude: "$lat", longitude: "$lng");

    // Initialize the animation controller and animation for the blinking effect
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 4), () {
          _controller.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        Future.delayed(const Duration(seconds: 4), () {
          _controller.forward();
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> getUserDetailsFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("user_name") ?? "";
    qrCode = prefs.getString("qr_code") ?? "";
    email = prefs.getString("user_email") ?? "Someone";
    print("qr code url $qrCode");
    setState(() {});
  }

  void _preventScreenShot() {
    noScreenshot.screenshotOff();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "QR Code".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(context, 0.05),
            fontWeight: FontWeight.w600,
          ),
        ),
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
      ),
      body: BlocConsumer<ScanQrCodeCubit, ScanQrCodeState>(
        listener: (context, state) {
          if (state is ScanQrcodeFailure) {
            AppUtils.showFlushBar(state.errorMessage, context);
          }
        },
        builder: (context, state) {
          if (state is ScanQrcodeLoading) {
            return const LoadingWidget();
          }
          if (state is GetQrcodeSuccess) {
            print("QR Code URL: ${state.qrCode}");
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: SizeConfig.height(context, 0.15),
                  ),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Animated border
                        FadeTransition(
                          opacity: _animation,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.orangeAccent, // Desired border color
                                width: 8.0,                 // Border width
                              ),
                            ),
                            // This container serves as the border.
                            // Padding ensures the border appears around the QR code image.
                            width: 230, // Adjust to fit the QR code size
                            height: 230, // Adjust to fit the QR code size
                          ),
                        ),
                        // QR code image without animation
                        SvgPicture.network(
                          state.qrCode ?? "",
                          width: 210, // Adjust these values to fit within the border
                          height: 210, // Adjust these values to fit within the border
                          placeholderBuilder: (BuildContext context) =>
                              Container(
                                padding: const EdgeInsets.all(30.0),
                                child: const CircularProgressIndicator(),
                              ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            );
          }
          return LoadingWidget();
        },
      ),
    );
  }
}
