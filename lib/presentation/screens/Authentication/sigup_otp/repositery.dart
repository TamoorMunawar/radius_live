import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../constants/network_utils.dart';

class AuthService {
  String noTimeOutMsg = 'Time out try again'.tr();
  String noInternetConnectivityMsg = 'Please check your internet connection  and try again.'.tr();

  Future<bool?> checkOtp({String? email, String? otp, String? countryCode, required bool isLoginWithMobile}) async {
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/auth/check_otp');
      String jsonBody = (isLoginWithMobile)
          ? jsonEncode(<String, dynamic>{"email": email, "country_code": countryCode, "otp": "$otp"})
          : jsonEncode(<String, dynamic>{"email": email, "otp": "$otp"});

      print("repository::checkOtp::url: $url\n");
      print("repository::checkOtp::jsonBody: $jsonBody\n");

      http.Response response = await http.post(url, headers: NetworkUtils.headers, body: jsonBody);

      log("repository::checkOtp::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);
      if (responseBody["success"]) {
        return true;
      } else {
        throw Exception(responseBody["message"]);
      }
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::checkOtp::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }


}
