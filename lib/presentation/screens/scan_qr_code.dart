/*
import 'dart:io';
import 'dart:typed_data';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/size_config.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
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

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: EdgeInsets.only(left: SizeConfig.width(context, 0.05)),
            child: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.width(context, 0.05),
            ),
          ),
          color: Colors.white,
        ),
        title: Text(
          "Scan",
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(context, 0.05),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: SizeConfig.width(context, 0.3),
            ),
            Center(
              child: Container(
                color: Colors.red,
                height: SizeConfig.height(context, 0.3),
                width: SizeConfig.width(context, 0.8),
                      child: MobileScanner(
                        fit: BoxFit.cover,
                        controller: MobileScannerController(
                          // facing: CameraFacing.back,
                          // torchEnabled: false,
                          returnImage: true,
                        ),
                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;
                          final Uint8List? image = capture.image;
                          for (final barcode in barcodes) {
                            debugPrint('Barcode found! ${barcode.rawValue}');
                          }
                          if (image != null) {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  Image(image: MemoryImage(image)),
                            );
                            Future.delayed(const Duration(seconds: 5), () {
                              Navigator.pop(context);
                            });
                          }
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
