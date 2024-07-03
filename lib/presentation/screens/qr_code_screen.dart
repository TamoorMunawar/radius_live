import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/main.dart';
import 'package:radar/presentation/cubits/scan_qr_code/scan_qrcode_cubit.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:no_screenshot/no_screenshot.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  Future getUserDetailsFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name = prefs.getString(
          "user_name",
        ) ??
        "";
    qrCode = prefs.getString(
          "qr_code",
        ) ??
        "";

    email = prefs.getString(
          "user_email",
        ) ??
        "Someone";

    print("qr code url $qrCode");
    setState(() {});
  }

  String email = "";
  String name = "";
  String qrCode = "";
  NoScreenshot noScreenshot = NoScreenshot.instance;

  void _preventScreenShot() async {
    noScreenshot.screenshotOff();
    //  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    //await ScreenProtector.preventScreenshotOff();
  }
late ScanQrCodeCubit scanQrCodeCubit;
  @override
  void initState() {
    getUserDetailsFromLocal();
    _preventScreenShot();
    scanQrCodeCubit=BlocProvider.of<ScanQrCodeCubit>(context);
    scanQrCodeCubit.getQrCode(latitude:"$lat" ,longitude: "$lng");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        //GlobalColors.backgroundColor,
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
            padding: EdgeInsets.only(left: SizeConfig.width(context, 0.05),right:  SizeConfig.width(context, 0.05)),
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
      }, builder: (context, state) {
        if (state is ScanQrcodeLoading) {
          return const LoadingWidget();
        }
        if (state is GetQrcodeSuccess) {
          print("sdffffffffffffffffffffff ${state.qrCode}'");
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.height(context, 0.15),
                ),
                Center(
                  child: SvgPicture.network(
                    state.qrCode ?? "",

                    //     semanticsLabel: 'A shark?!',
                    placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(30.0),
                        child: const CircularProgressIndicator()),
                  ),
                )
              ],
            ),
          );
        }
        return LoadingWidget();
      }),
    );
  }
}
