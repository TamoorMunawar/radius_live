// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:radar/constants/network_utils.dart';
import 'package:radar/domain/entities/Job.dart';
import 'package:radar/domain/entities/announcement/Announcement.dart';
import 'package:radar/domain/entities/attandance/Attandance.dart';
import 'package:radar/domain/entities/dashboard/dashboard_detail.dart';
import 'package:radar/domain/entities/dashboard_attandace_data/Dashboard_attandace_data.dart';
import 'package:radar/domain/entities/department/Department.dart';
import 'package:radar/domain/entities/events/event_detail/Event_detail.dart';
import 'package:radar/domain/entities/events/initial_event/Initial_event.dart';
import 'package:radar/domain/entities/job_dashboard/job_dashboard.dart';
import 'package:radar/domain/entities/lastest_event/latest_event_model.dart';
import 'package:radar/domain/entities/login/Login.dart';
import 'package:radar/domain/entities/outside_event_usher/outside_event_usher.dart';
import 'package:radar/domain/entities/profile/profile_model.dart';
import 'package:radar/domain/entities/register/Register.dart';
import 'package:radar/domain/entities/register_payload/Register_payload.dart';
import 'package:radar/domain/entities/review_payload/review_playload.dart';
import 'package:radar/domain/entities/scan_qr_code/Scan_qr_code_payload.dart';
import 'package:radar/domain/entities/supervisior/Supervisior.dart';
import 'package:radar/domain/entities/user_detail/User_detail.dart';
import 'package:radar/domain/entities/ushers/Ushers.dart';
import 'package:radar/domain/entities/zone/Zone.dart';
import 'package:radar/domain/entities/zone_dashboard/zone_dashboard.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class RadarMobileRepositoryImpl implements RadarMobileRepository {
  String noInternetConnectivityMsg = 'Please check your internet connection  and try again.'.tr();
  String noTimeOutMsg = 'Time out try again'.tr();

  @override
  Future<Login> login(
      {String? email,
      String? password,
      String? deviceToken,
      String? deviceId,
      String? deviceName,
      String? lat,
      String? lng,
      bool? isLoginWithMobile,
      String? countryCode}) async {
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/auth/login');

      String jsonBody = (isLoginWithMobile ?? false)
          ? jsonEncode(<String, dynamic>{
              "email": email,
              "country_code": countryCode,
              "password": password,
              "device_token": deviceToken,
              "device_id": deviceId,
              "device_name": deviceName,
              "latitude": lat,
              "longitude": lng
            })
          : jsonEncode(<String, dynamic>{
              "email": email,
              "password": password,
              "device_token": deviceToken,
              "device_id": deviceId,
              "device_name": deviceName,
              "latitude": lat,
              "longitude": lng
            });
      print("repository::login::jsonBody: $jsonBody\n");

      http.Response response = await http.post(url, headers: NetworkUtils.headers, body: jsonBody);

      log("repository::login::url: $url \n");
      log("repository::login::body: $jsonBody \n");
      log("repository::login::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);
      log("repository::login::responseBody[success]: ${responseBody["success"]}\n");
      if (responseBody["success"] == false) {
        print("inside exception condition ");
        throw Exception(responseBody["message"]);
      }

      print("not inside exception condition ${responseBody["data"]["user"]}");
      print("not inside exception condition ${responseBody["data"]["token"]}");
      Login login = Login.fromJson(responseBody["data"]["user"]);
      //   if (login != null) {
      saveUserDetailsToLocal(token: responseBody["data"]["token"], login: login);
      print("user role ${login.role?.displayName}");
      log("user Token ${responseBody["token"]} ");
      //  }
      return login;
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::login::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<bool> createAlert({
    String? heading,
    String? to,
    String? departmentId,
    String? description,
  }) async {
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/notice/store');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonBody = jsonEncode(<String, dynamic>{
        "heading": heading,
        "to": to,
        "department_id": departmentId,
        "description": description,
      });
      print("repository::createAlert::jsonBody: $jsonBody\n");

      http.Response response = await http.post(url, headers: authorizationHeaders(prefs), body: jsonBody);

      log("repository::createAlert::responseBody: ${response.body}\n");

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
      print('repository::createAlert::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<bool> createJob(
      {int? eventId,
      String? jobName,
      String? totalMaleSalary,
      String? totalFemaleSalary,
      String? dailyMaleSalary,
      String? dailyFemaleSalary}) async {
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/events/job/create');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonBody = jsonEncode(<String, dynamic>{
        "job_name": jobName,
        "event_model_id": eventId,
        "total_male_salary": totalMaleSalary,
        "daily_male_salary": dailyMaleSalary,
        "total_female_salary": totalFemaleSalary,
        "daily_female_salary": dailyFemaleSalary,
      });
      print("repository::createJob::jsonBody: $jsonBody\n");

      http.Response response = await http.post(url, headers: authorizationHeaders(prefs), body: jsonBody);

      log("repository::createJob::responseBody: ${response.body}\n");

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
      print('repository::createJob::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<bool> createZone({
    int? eventId,
    int? supervisiorId,
    String? location,
    int? jobId,
    String? maleMainSeats,
    String? femaleMainSeats,
    String? malestbySeats,
    String? femalestbySeats,
    String? description,
    String? zoneName,
  }) async {
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/events/zone/create');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonBody = jsonEncode(<String, dynamic>{
        "zone_name": zoneName,
        "event_id": eventId,
        "supervisor_id": supervisiorId,
        "location": location,
        "job_id": jobId,
        "male_main_seats": maleMainSeats,
        "female_main_seats": femaleMainSeats,
        "male_stby_seats": malestbySeats,
        "female_stby_seats": femalestbySeats,
        "description": description,
      });
      print("repository::createZone::jsonBody: $jsonBody\n");

      http.Response response = await http.post(url, headers: authorizationHeaders(prefs), body: jsonBody);

      log("repository::createZone::url: $url\n");
      log("repository::createZone::responseBody: ${response.body}\n");

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
      print('repository::createZone::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<bool> acceptInvitation({
    int? eventId,
    int? status,
  }) async {
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/events/take_job');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonBody = jsonEncode(<String, dynamic>{
        "invitation_id": eventId,
        "status": status,
      });
      print("repository::acceptInvitation::jsonBody: $jsonBody\n");

      http.Response response = await http.post(url, headers: authorizationHeaders(prefs), body: jsonBody);

      log("repository::acceptInvitation::responseBody: ${response.body}\n");

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
      print('repository::acceptInvitation::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  final dio = Dio();

  @override
  Future<Register> register({RegisterPayload? registerPayload, String? documentPath}) async {
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/auth/register');
      print("repository::register::url: $url\n");
      Map<String, String> jsonBody = <String, String>{
        'email': registerPayload?.email ?? "",
        'name': registerPayload?.name ?? "",
        'password': registerPayload?.password ?? "",
        'gender': registerPayload?.gender ?? "",
        'country_phonecode': registerPayload?.countryPhonecode ?? "",
        'mobile': registerPayload?.mobile ?? "",
        'iqama_expiry': registerPayload?.iqamaExpiry ?? "",
        "iqama_id": registerPayload?.iqamaId ?? "",
        "date_of_birth": registerPayload?.dateOfBirth ?? "",
        "city": registerPayload?.city ?? "",
        "device_token": registerPayload?.deviceToken ?? "",
        "device_name": registerPayload?.deviceName ?? "",
        "device_id": registerPayload?.deviceId ?? "",
        "whatsapp_number": registerPayload?.whatsappNumber ?? "",
        "whatsapp_number_country_code": registerPayload?.whatsappCountryCode ?? "",
      };
      var headers2 = <String, String>{
        "Content-Type": "multipart/form-data",
        // "Content-Type": "application/json",
      };
      print("document path $documentPath");
      print("repository::register::jsonBody: ${jsonBody.toString()}\n");

      http.MultipartRequest request = http.MultipartRequest('POST', url)
        ..fields.addAll(jsonBody)
        ..headers.addAll(headers2)
        ..files.add(await http.MultipartFile.fromPath('image', documentPath ?? ""));

      final http.StreamedResponse response = await request.send();

      final respStr = await response.stream.bytesToString();

      log("repository::register::response.body: $respStr");

      var responseBody = jsonDecode(respStr);
      log("repository::register::responseBody[success]: ${responseBody["success"]}\n");
      if (responseBody["success"] == false) {
        print("inside exception condition ");
        throw Exception(responseBody["message"]);
      }
      print("not inside exception condition ");
      Register register = Register.fromJson(responseBody["user"]);

      // saveUserDetailsToLocalRegister(register, responseBody["token"]);

      return register;
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::register::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<bool?> scanQrCode({
    ScanQrCodePayload? scanQrCodePayload,
    int? userId,
    bool? isCheckout,
    double? latitude,
    double? longitude,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = Uri.parse('${NetworkUtils.baseUrl}/qr/scan');
      String jsonBody = (isCheckout ?? false)
          ? jsonEncode(<String, dynamic>{
              "user_id": prefs.getInt("user_id"),
              "type": "checkOut",
              "latitude": "$latitude",
              "longitude": "$longitude",
              "mydata": jsonEncode(
                scanQrCodePayload?.toJson(),
              )
            })
          : jsonEncode(<String, dynamic>{
              "user_id": prefs.getInt("user_id"),
              "latitude": "$latitude",
              "longitude": "$longitude",
              "type": "checkIn",
              "mydata": jsonEncode(
                scanQrCodePayload?.toJson(),
              )
            });
      /*String jsonBody =
          jsonEncode(scanQrCodePayload?.toJson());*/
      print("repository::scanQrCode::url: $url\n");
      print("repository::scanQrCode::jsonBody: $jsonBody\n");

      http.Response response = await http.post(
        url,
        headers: NetworkUtils.headers,
        body: jsonBody,
      );

      log("repository::scanQrCode::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);
      if (responseBody["status"] == "success") {
        return true;
      } else {
        throw Exception(responseBody["message"]);
      }
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::scanQrCode::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<bool?> scanQrCodeByEventId({
    ScanQrCodePayload? scanQrCodePayload,
    int? userId,
    bool? isCheckout,
    double? latitude,
    double? longitude,
    int? eventModelId,
    int? zoneId,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = Uri.parse('${NetworkUtils.baseUrl}/qr/attendance');
      String jsonBody = (isCheckout ?? false)
          ? jsonEncode(<String, dynamic>{
              "user_id": prefs.getInt("user_id"),
              "type": "checkOut",
              "latitude": "$latitude",
              "longitude": "$longitude",
              "event_model_id": "$eventModelId",
              "zone_id": "$zoneId",
              "mydata": jsonEncode(
                scanQrCodePayload?.toJson(),
              )
            })
          : jsonEncode(<String, dynamic>{
              "user_id": prefs.getInt("user_id"),
              "latitude": "$latitude",
              "longitude": "$longitude",
              "type": "checkIn",
              "event_model_id": "$eventModelId",
              "zone_id": "$zoneId",
              "mydata": jsonEncode(
                scanQrCodePayload?.toJson(),
              )
            });
      /*String jsonBody =
          jsonEncode(scanQrCodePayload?.toJson());*/
      print("repository::scanQrCodeByEventId::url: $url\n");
      print("repository::scanQrCodeByEventId::jsonBody: $jsonBody\n");

      http.Response response = await http.post(
        url,
        headers: authorizationHeaders(prefs),
        body: jsonBody,
      );

      log("repository::scanQrCodeByEventId::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);
      if (responseBody["status"] != "fail") {
        return true;
      } else {
        print("iniside else condition");
        throw Exception(responseBody["message"]);
      }
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::scanQrCodeByEventId::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<bool?> scanQrCodeForUsherInvite({
    ScanQrCodeUsherInvitePayload? scanQrCodePayload,
    int? zoneId,
    int? jobId,
    int? eventId,
    String? latitude,
    String? longitude,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = Uri.parse('${NetworkUtils.baseUrl}/final/invites/event/$eventId');
      String jsonBody = jsonEncode(<String, dynamic>{
        "zone_id": zoneId,
        "event_zone_job_id": jobId,
        "latitude": latitude,
        "longitude": longitude,
        "mydata": jsonEncode(
          scanQrCodePayload?.toJson(),
        ),
      });
      /*String jsonBody =
          jsonEncode(scanQrCodePayload?.toJson());*/
      print("repository::scanQrCodeForUsherInvite::url: $url\n");
      print("repository::scanQrCodeForUsherInvite::jsonBody: $jsonBody\n");

      http.Response response = await http.post(
        url,
        headers: authorizationHeaders(prefs),
        body: jsonBody,
      );

      log("repository::scanQrCodeForUsherInvite::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);
      if (responseBody["success"]) {
        return true;
      } else {
        print("iniside else condition");
        throw Exception(responseBody["message"]);
      }
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::scanQrCodeForUsherInvite::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
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

  @override
  Future<bool?> sendOtp({String? email, String? number, String? countryCode}) async {
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/auth/send-verification');
      String jsonBody = jsonEncode(<String, dynamic>{
        "email": email,
        "whatsapp_number": "$number",
        "country_code": countryCode,
      });

      log("repository::sendOtp::url: $url\n");
      log("repository::sendOtp::jsonBody: $jsonBody\n");

      http.Response response = await http.post(url, headers: NetworkUtils.headers, body: jsonBody);

      log("repository::sendOtp::responseBody: ${response.body}\n");

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
      log('repository::sendOtp::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<bool?> resetPassword(
      {String? email,
      int? otp,
      String? password,
      String? countryCode,
      required bool isLoginWithMobile,
      String? confirmPassword}) async {
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/auth/reset-password');
      String jsonBody = isLoginWithMobile
          ? jsonEncode(<String, dynamic>{
              "email": email,
              "country_code": countryCode,
              "otp": "$otp",
              "password": password,
              "password_confirmation": confirmPassword
            })
          : jsonEncode(<String, dynamic>{
              "email": email,
              "otp": "$otp",
              "password": password,
              "password_confirmation": confirmPassword
            });

      print("repository::resetPassword::url: $url\n");
      print("repository::resetPassword::jsonBody: $jsonBody\n");

      http.Response response = await http.post(url, headers: NetworkUtils.headers, body: jsonBody);

      log("repository::resetPassword::responseBody: ${response.body}\n");

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
      print('repository::resetPassword::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<int?> forgetPassword({String? email, String? countryCode, bool? isLoginWithMobile}) async {
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/auth/forget-password');
      String jsonBody = (isLoginWithMobile ?? false)
          ? jsonEncode(<String, dynamic>{"email": email, "country_code": countryCode})
          : jsonEncode(<String, dynamic>{"email": email});
      /*String jsonBody =
          jsonEncode(scanQrCodePayload?.toJson());*/
      print("repository::forgetPassword::url: $url\n");
      print("repository::forgetPassword::jsonBody: $jsonBody\n");

      http.Response response = await http.post(url, headers: NetworkUtils.headers, body: jsonBody);

      log("repository::forgetPassword::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);
      if (responseBody["success"]) {
        return responseBody["otp_token"] ?? 00;
      } else {
        throw Exception(responseBody["message"]);
      }
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::forgetPassword::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<UserDetail> userDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url =
          Uri.parse('${NetworkUtils.baseUrl}/client/${prefs.getInt("user_id")}/?fields=id,name,email,status,qr_image');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );

      log("repository::userDetails::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);

      UserDetail userDetails = UserDetail.fromJson(responseBody["data"]);

      return userDetails;
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::userDetails::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<List<Attandance>> getAttandance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/attendance/view_attendance/${prefs.getInt("user_id")}');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );

      log("repository::getAttandance::responseBody: $url\n");
      log("repository::getAttandance::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);

      List list = responseBody["data"]['data'] as List;
      List<Attandance> attandanceList = [];

      if (list.isNotEmpty) {
        list.forEach((t) => attandanceList.add(Attandance.fromJson(t)));
      }

      return attandanceList;
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::getAttandance::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  Future<List<LatestEventModel>> latestEvent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/latest/events/');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );

      log("repository::latestEvent::responseBody: $url\n");
      log("repository::latestEvent::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);

      List list = responseBody['data'] as List;
      List<LatestEventModel> attandanceList = [];

      if (list.isNotEmpty) {
        list.forEach((t) => attandanceList.add(LatestEventModel.fromJson(t)));
      }

      return attandanceList;
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::latestEvent::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<ProfileModel> getProfileDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/auth/me');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );

      log("repository::getProfileDetails::responseBody: $url\n");
      log("repository::getProfileDetails::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);

      if (responseBody["success"] != true) {
        throw Exception(responseBody["message"]);
      }
      ProfileModel profileModel = ProfileModel.fromJson(responseBody['data']);

      return profileModel;
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::getProfileDetails::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<List<Supervisior>> getSuperVisior() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/get_supervisors');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );

      log("repository::getSupervisior::url: $url\n");
      log("repository::getSupervisior::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);
      if (responseBody["success"] != true) {
        throw Exception(responseBody["message"]);
      }
      List list = responseBody["data"] as List;

      List<Supervisior> supervisorList = [];

      if (list.isNotEmpty) {
        list.forEach((t) => supervisorList.add(Supervisior.fromJson(t)));
      }

      return supervisorList;
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::getSupervisior::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<List<Zone>> getZone({
    int? eventId,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/zone/byEvent/$eventId');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );

      log("repository::getZone::url: $url");
      log("repository::getZone::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);

      List list = responseBody["data"]["data"] as List;
      List<Zone> zoneList = [];

      if (list.isNotEmpty) {
        list.forEach((t) => zoneList.add(Zone.fromJson(t)));
      }

      return zoneList;
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::getZone::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<List<Zone>> getZoneByUserId({int? eventId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/get/zones/');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );

      log("repository::getZoneByUserId::url: $url");
      log("repository::getZoneByUserId::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);

      List list = responseBody["data"] as List;
      List<Zone> zoneList = [];

      if (list.isNotEmpty) {
        list.forEach((t) => zoneList.add(Zone.fromJson(t)));
      }

      return zoneList;
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::getZoneByUserId::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<DashboardAttandanceData> getAttandanceData({int? userId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url =
          // Uri.parse('${NetworkUtils.baseUrl}/get_attendence_data/114');
          Uri.parse('${NetworkUtils.baseUrl}/get_attendence_data/${prefs.getInt("user_id")}');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );

      log("repository::getAttandaceData::url: $url");
      log("repository::getAttandaceData::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);
      if (responseBody["success"] != true) {
        throw Exception(responseBody["message"]);
      }
      return DashboardAttandanceData.fromJson(responseBody["data"]);
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::getAttandaceData::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<List<Job>> getJob({int? eventModelId, bool? isZone, int? zoneId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = (isZone ?? false)
          ? Uri.parse('${NetworkUtils.baseUrl}/get_jobs/$eventModelId/$zoneId')
          : Uri.parse('${NetworkUtils.baseUrl}/get_jobs/$eventModelId');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );

      log("repository::getJob::url: $url\n");
      log("repository::getJob::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);
      if (responseBody["success"] != true) {
        throw Exception(responseBody["message"]);
      }
      List list = responseBody["data"] as List;
      List<Job> jobList = [];

      if (list.isNotEmpty) {
        list.forEach((t) => jobList.add(Job.fromJson(t)));
      }

      return jobList;
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::getJob::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<List<Announcement>> getAnnouncement({int? page}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/notices?page=$page');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );
      log("repository::getAnnouncement::url: $url \n");

      log("repository::getAnnouncement::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);

      List list = responseBody["0"]['data'] as List;
      List<Announcement> annoucementList = [];

      if (list.isNotEmpty) {
        list.forEach((t) => annoucementList.add(Announcement.fromJson(t)));
      }

      return annoucementList;
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::getAnnouncement::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<DashboardDetail> dashboardDetail({int? eventId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/dashboard?event_id=$eventId');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );
      log("repository::dashboardDetail::url: $url \n");

      log("repository::dashboardDetail::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);

      return DashboardDetail.fromJson(responseBody["data"]);
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::dashboardDetail::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<bool?> zoneSeats({int? zoneId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/check/zone/seats/$zoneId');

      print("repository::zoneSeats::url: $url\n");

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );

      log("repository::zoneSeats::responseBody: ${response.body}\n");

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
      print('repository::zoneSeats::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<List<JobDashboard>> dashboardJob({int? eventId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/get_jobs/$eventId');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );
      log("repository::dashboardJob::url: $url \n");

      log("repository::dashboardJob::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);
      if (responseBody["success"] != true) {
        throw Exception(responseBody["message"]);
      }
      List list = responseBody['data'] as List;

      List<JobDashboard> itemList = [];

      if (list.isNotEmpty) {
        list.forEach((t) => itemList.add(JobDashboard.fromJson(t)));
      }

      return itemList;
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::dashboardJob::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<List<ZoneDashboard>> dashboardZone({int? eventId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/zone/byEvent/$eventId');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );
      log("repository::dashboardZone::url: $url \n");

      log("repository::dashboardZone::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);
      if (responseBody["success"] != true) {
        throw Exception(responseBody["message"]);
      }
      List list = responseBody['data']['data'] as List;

      List<ZoneDashboard> itemList = [];

      if (list.isNotEmpty) {
        list.forEach((t) => itemList.add(ZoneDashboard.fromJson(t)));
      }

      return itemList;
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::dashboardZone::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<List<InitialEvent>> getInitialEvents({int? page}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/events/initial?page=$page');
      //   '${NetworkUtils.baseUrl}/events/initial/${prefs.getInt("user_id")}?page=$page');
      //   '${NetworkUtils.baseUrl}/events/initial/18');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );
      log("repository::getInitialEvents::url: $url \n");

      log("repository::getInitialEvents::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);
      if (responseBody["success"] != true) {
        throw Exception(responseBody["message"]);
      }
      List list = responseBody['data']["data"]['data'] as List;
      print("imagepath repo ${responseBody['data']['event_img_path']}");
      prefs.setString("event_image_path", "${responseBody['data']['event_img_path']}");
      List<InitialEvent> itemList = [];

      if (list.isNotEmpty) {
        list.forEach((t) => itemList.add(InitialEvent.fromJson(t)));
      }

      return itemList;
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::getInitialEvents::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<EventDetail> getEventDetailById({int? eventId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse(
          // '${NetworkUtils.baseUrl}/events/event_details/${prefs.getInt("user_id")}');
          '${NetworkUtils.baseUrl}/events/event_details/$eventId');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );
      log("repository::getEventDetailById::url: $url \n");

      log("repository::getEventDetailById::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);

      if (responseBody["success"] != true) {
        throw Exception(responseBody["message"]);
      }
      prefs.setString("event_image_path", "${responseBody['data']['event_img_path']}");
      return EventDetail.fromJson(responseBody["data"]["data"]);
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::getEventDetailById::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<List<InitialEvent>> getFinalEvents({int? page}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse(
          //   '${NetworkUtils.baseUrl}/events/final/${prefs.getInt("user_id")}?page=$page');
          '${NetworkUtils.baseUrl}/events/final?page=$page');
      //'${NetworkUtils.baseUrl}/events/final/18');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );
      log("repository::getFinalEvents::url: $url \n");

      log("repository::getFinalEvents::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);
      if (responseBody["success"] != true) {
        throw Exception(responseBody["message"]);
      }
      List list = responseBody['data']["data"]['data'] as List;
      print("imagepath repo ${responseBody['data']['event_img_path']}");
      prefs.setString("event_image_path", "${responseBody['data']['event_img_path']}");
      List<InitialEvent> itemList = [];

      if (list.isNotEmpty) {
        list.forEach((t) => itemList.add(InitialEvent.fromJson(t)));
      }

      return itemList;
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::getFinalEvents::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  Future<bool> changePassword({
    String? currentPassword,
    String? password,
    String? confirmPassword,
  }) async {
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/change_password');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonBody = jsonEncode(<String, dynamic>{
        "current_password": currentPassword,
        "password": password,
        "password_confirmation": confirmPassword,
      });
      print("repository::changePassword::jsonBody: $jsonBody\n");

      http.Response response = await http.post(url, headers: authorizationHeaders(prefs), body: jsonBody);

      log("repository::changePassword::responseBody: ${response.body}\n");

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
      print('repository::changePassword::exception = ${e.toString()}');
      throw Exception(
        e.toString().substring(11),
      );
    }
  }

  @override
  Future<bool> updateProfile({
    String? name,
    String? image,
    String? number,
  }) async {
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/user/profile/update');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonBody = jsonEncode(<String, dynamic>{
        "user_id": prefs.getInt("user_id"),
        "name": name,
        "image": image,
        "mobile": number,
      });
      print("repository::updateProfile::jsonBody: $jsonBody\n");

      http.Response response = await http.post(url, headers: authorizationHeaders(prefs), body: jsonBody);

      log("repository::updateProfile::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);
      log("repository::updateProfile::responseBody: ${responseBody["user"]["image_url"]}\n");

      if (responseBody["success"]) {
        prefs.setString("user_name", responseBody["user"]["name"] ?? "");

        prefs.setString("user_image", responseBody["user"]["image_url"] ?? "");
        prefs.setString("user_phonenumber", responseBody["user"]["mobile"] ?? "");
        return true;
      } else {
        throw Exception(responseBody["message"]);
      }
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::updateProfile::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<bool> updateProfileV1({
    String? name,
    String? image,
    String? number,
    String? whatsappNumber,
    String? iqamaId,
    String? email,
    String? mobileNumberCountryCode,
    String? whatsappNumberCountryCode,
    String? deviceId,
    String? deviceName,
  }) async {
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/profile/update');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var responseBody;
      if (image != null && image != '') {
        Map<String, String> jsonBody = <String, String>{
          "name": name ?? "",
          "email": email ?? "",
          "iqama_id": iqamaId ?? "",
          "mobile": number ?? "",
          "whatsapp_number": whatsappNumber ?? "",
          "country_phonecode": mobileNumberCountryCode ?? "",
          "whatsapp_number_country_code": whatsappNumberCountryCode ?? "",
          "device_id": deviceId ?? "",
          "device_name": deviceName ?? "",
        };
        print("repository::updateProfileV1::url: $url\n");
        print("repository::updateProfileV1::jsonBody: $jsonBody\n");

        var headers2 = <String, String>{
          "Content-Type": "multipart/form-data",
          "Content-Type": "application/json",
          "Authorization": "Bearer ${prefs.getString("token")}"
        };
        print("document path $image");
        print("repository::register::jsonBody: ${jsonBody.toString()}\n");

        http.MultipartRequest request = http.MultipartRequest('POST', url)
          ..fields.addAll(jsonBody)
          ..headers.addAll(headers2)
          ..files.add(await http.MultipartFile.fromPath('image', image ?? ""));

        final http.StreamedResponse response = await request.send();

        final respStr = await response.stream.bytesToString();

        log("repository::updateProfileV1::response.body: $respStr");

        responseBody = jsonDecode(respStr);
      } else {
        String jsonBody = jsonEncode(<String, dynamic>{
          "name": name ?? "",
          "email": email ?? "",
          "iqama_id": iqamaId ?? "",
          "mobile": number ?? "",
          "whatsapp_number": whatsappNumber ?? "",
          "country_phonecode": mobileNumberCountryCode ?? "",
          "whatsapp_number_country_code": whatsappNumberCountryCode ?? "",
        });
        print("repository::updateProfileV1::url: $url\n");
        print("repository::updateProfileV1::jsonBody: $jsonBody\n");

        http.Response response = await http.post(url, headers: authorizationHeaders(prefs), body: jsonBody);

        log("repository::updateProfileV1::responseBody: ${response.body}\n");

        responseBody = jsonDecode(response.body);
      }
      log("repository::updateProfileV1::responseBody[success]: ${responseBody["success"]}\n");
      if (responseBody["success"]) {
        prefs.setString("user_name", responseBody["data"]["name"] ?? "");
        prefs.setString("user_email", responseBody["data"]["email"] ?? "");
        prefs.setString("user_whatsappNumberCountryCode", responseBody["data"]["whatsapp_number"] ?? "");
        prefs.setString("user_phonenumber", responseBody["data"]["mobile"] ?? "");
        prefs.setString("user_image", responseBody["data"]["image_url"] ?? "");

        return true;
      }

      throw Exception(responseBody["message"]);
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::updateProfileV1::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<List<Department>> getDepartment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/departments?page=1');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );

      log("repository::getDepartment::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);

      // UserDetail userDetails = UserDetail.fromJson(responseBody["data"]);
      List list = responseBody["0"]['data'] as List;
      List<Department> departmentList = [];

      if (list.isNotEmpty) {
        list.forEach((t) => departmentList.add(Department.fromJson(t)));
      }
      return departmentList;
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::getDepartment::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<List<Ushers>> getUshers({int? zoneId, bool? isZoneSelected, int? page}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = isZoneSelected == true
          ? Uri.parse('${NetworkUtils.baseUrl}/get/zones/ushers?zone_id=$zoneId&page=$page')
          : Uri.parse('${NetworkUtils.baseUrl}/get/zones/ushers?page=$page');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );

      log("repository::getUshers::url: $url");
      log("repository::getUshers::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);
      if (responseBody["success"]) {
        List list = responseBody['data']['data'] as List;
        List<Ushers> usherList = [];

        if (list.isNotEmpty) {
          list.forEach((t) => usherList.add(Ushers.fromJson(t)));
        }
        return usherList;
      } else {
        throw Exception(responseBody["message"]);
      }
      // UserDetail userDetails = UserDetail.fromJson(responseBody["data"]);
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::getUshers::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<List<OutsideEventUsher>> getUshersByEvent({int? eventId, int? page}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/get/users/by_zone_manager/$eventId');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );

      log("repository::getUshersByEvent::url: $url");
      log("repository::getUshersByEvent::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);

      // UserDetail userDetails = UserDetail.fromJson(responseBody["data"]);
      if (responseBody["success"]) {
        List list = responseBody['data']['data'] as List;
        print("inside  getUshersByEvent  ${responseBody['data']['data']}");
        List<OutsideEventUsher> usherList = [];

        if (list.isNotEmpty) {
          list.forEach((t) => usherList.add(OutsideEventUsher.fromJson(t)));
        }
        return usherList;
      } else {
        throw Exception(responseBody["message"]);
      }
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::getUshersByEvent::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  Future<String> getQrCode({String? latitude, String? longitude}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse(
          '${NetworkUtils.baseUrl}/user/qrcode/${prefs.getInt("user_id")}?latitude=$latitude&longitude=$longitude');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );

      log("repository::getQrCode::url: $url");
      log("repository::getQrCode::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);

      // UserDetail userDetails = UserDetail.fromJson(responseBody["data"]);

      if (responseBody["success"]) {
        String result = responseBody['data']['qr_image'] ?? "";
        return result;
      } else {
        throw Exception(responseBody["message"]);
      }
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::getQrCode::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  Future<bool> appUpdate({String? appVersion}) async {
    try {
      var url = Uri.parse(
          '${NetworkUtils.baseUrl}/app/version?device_type=${(Platform.isAndroid) ? "android" : "ios"}&current_version=$appVersion');
      log("repository::appUpdate::url: $url");
      http.Response response = await http.get(
        url,
        headers: NetworkUtils.headers,
      );

      log("repository::appUpdate::responseBody: ${response.body}\n");

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
      print('repository::appUpdate::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  Map<String, String> authorizationHeaders(SharedPreferences prefs) {
    return <String, String>{"Content-Type": "application/json", "Authorization": "Bearer ${prefs.getString("token")}"};
  }

  Future saveUserDetailsToLocal({Login? login, String? token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("user token $token");
    print("iqama id ${login?.iqamaId}");
    print("user_name ${login?.name} ");
    print("role_name repos ${login?.role?.name} ");
    print("login?.countryPhonecode ${login?.countryPhonecode} ");
    prefs.setString("token", token ?? "");
    prefs.setString("user_name", login?.name ?? "");
    prefs.setString("user_email", login?.email ?? "");
    prefs.setString("qr_code", login?.qrImage ?? "");
    prefs.setInt("user_id", login?.id ?? 0);
    prefs.setString("user_image", login?.imageUrl ?? "");
    if (login?.role?.name == "employee") {
      print("inside login?.role?.name ");
      prefs.setString("role_name", "Usher");
    }
    if (login?.role?.name == "client") {
      prefs.setString("role_name", "Client");
    }
    if (login?.role?.name != "client" && login?.role?.name != "employee") {
      prefs.setString("role_name", "admin");
    }

    prefs.setString("user_phonenumber", "${login?.mobile}" ?? "");
    prefs.setString("iqama_id", "${login?.iqamaId}" ?? "");
    prefs.setString("user_phonenumberCountryCode", login?.countryPhonecode.toString() ?? "");
    prefs.setString("user_whatsappNumberCountryCode", login?.whatsappNumber ?? "");
    if (login?.whatsappNumber != null) {
      prefs.setBool("isProfileUpdated", true);
    } else {
      prefs.setBool("isProfileUpdated", false);
    }

    print("user role ${login?.role?.name}");
    print("user role ${login?.qrImage}");
    print("user id from saveUserDetailsToLocal ${prefs.getString(
      "role_name",
    )}");
    print("user idddd ${login?.id}");
  }

  Future saveUserDetailsToLocalRegister(Register register, String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("user_name ${register.name} ");
    prefs.setString("token", token ?? "");
    prefs.setString("user_name", register.name ?? "");
    prefs.setString("user_email", register.email ?? "");
    prefs.setString("qr_code", register.qrImage ?? "");
    prefs.setString("user_image", register.imageUrl ?? "");
    prefs.setString("user_phonenumber", register?.mobile ?? "");
    prefs.setInt("user_id", register.id ?? 0);
    print("user role ${register?.role?.displayName}");
  }

  @override
  Future<bool> addReview(ReviewPayload reviewPayload) async {
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/add-review');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonBody = jsonEncode(<String, dynamic>{
        "review": reviewPayload.review,
        "review_no": reviewPayload.rating,
        "review_to": reviewPayload.usherId,
        "is_banned": reviewPayload.isBanned,
        "team_id": reviewPayload.teamId,
        "event_id": reviewPayload.eventId,
      });
      log("repository::addReview::jsonBody: $jsonBody\n");

      http.Response response = await http.post(url, headers: authorizationHeaders(prefs), body: jsonBody);

      log("repository::addReview::responseBody: ${response.body}\n");

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
      print('repository::addReview::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<List<MyEvent>> getEventList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse('${NetworkUtils.baseUrl}/get-events-list');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );

      log("repository::getEventsList::url: $url");

      var responseBody = jsonDecode(response.body);
      log("repository::getEventsList::responseBody: $responseBody\n");

      // UserDetail userDetails = UserDetail.fromJson(responseBody["data"]);
      if (responseBody["message"] == "Success") {
        List list = responseBody['data']['data'] as List;
        log("inside  getEventsList  ${responseBody['data']['data']}");
        List<MyEvent> eventList = [];

        if (list.isNotEmpty) {
          for (int i = 0; i < list.length; i++) {
            eventList.add((list[i]["id"], list[i]["event_name"]));
          }
        }
        return eventList;
      } else {
        throw Exception(responseBody["message"]);
      }
    } on TimeoutException catch (_) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (_) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      log('repository::getUshersByEvent::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }
}
