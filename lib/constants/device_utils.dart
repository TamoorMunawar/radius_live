import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceUtils {
  static Future<(String, String)> getDeviceIdentifier() async {
    String deviceIdentifier = "unknown";
    String deviceName = "unknown";

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.id;
      deviceName = androidInfo.device;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor ?? deviceIdentifier;
      deviceName = iosInfo.name;
    }

    return (deviceName, deviceIdentifier);
  }
}
