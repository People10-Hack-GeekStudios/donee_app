import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fud_app/view/constants/constants.dart';
import 'package:fud_app/view/screens/registration/login/login.dart';
import 'package:get/route_manager.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class Api {
  final timeout = const Duration(seconds: 8);
  Function(BuildContext context)? onLogout;
  static Future<CustomResponse> get(String endpoint,
      {bool useToken = true}) async {
    Uri url = Uri.parse(kBaseUrl + endpoint);
    log(kBaseUrl);
    log(endpoint);
    FlutterSecureStorage storage = const FlutterSecureStorage();

    String token = "Bearer ${await storage.read(key: kAccessToken)}";
    Map<String, String> header = useToken
        ? {"Content-Type": "application/json", "Authorization": token}
        : {"Content-Type": "application/json"};

    try {
      http.Response response = await http.get(url, headers: header);
      log(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        if (responseMap["response_code"] == 200 ||
            responseMap["response_code"] == 201) {
          return CustomResponse(state: true, response: responseMap);
        }
      } else if (response.statusCode == 401) {
        Get.offAll(const LoginPage());
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        MotionToast.error(
                position: MotionToastPosition.top,
                animationType: AnimationType.fromTop,
                title: Text("Error"),
                description: Text(responseMap["message"]))
            .show(Get.overlayContext!);
      }
    } on SocketException {
      MotionToast.error(
              position: MotionToastPosition.top,
              animationType: AnimationType.fromTop,
              title: Text("Error"),
              description: Text("Couldnt connect to server"))
          .show(Get.overlayContext!);
    } on TimeoutException {
      MotionToast.error(
              position: MotionToastPosition.top,
              animationType: AnimationType.fromTop,
              title: Text("Error"),
              description: Text("Connection Timeout"))
          .show(Get.overlayContext!);
    } catch (e) {
      MotionToast.error(
              position: MotionToastPosition.top,
              animationType: AnimationType.fromTop,
              title: Text("Error"),
              description: Text("Unexpected Error Occured"))
          .show(Get.overlayContext!);
    }

    return CustomResponse(state: false);
  }

  static Future<CustomResponse> post(String endpoint,
      {bool useToken = true,
      required Map<String, dynamic> body,
      bool showSuccessToast = false,
      bool showErrorToast = true,
      bool ignoreServerError = false}) async {
    Uri url = Uri.parse(kBaseUrl + endpoint);
    FlutterSecureStorage storage = const FlutterSecureStorage();
    print(body);
    String token = "Bearer ${await storage.read(key: kAccessToken)}";

    Map<String, String> header = useToken
        ? {"Content-Type": "application/json", "Authorization": token}
        : {"Content-Type": "application/json"};
    try {
      http.Response response =
          await http.post(url, headers: header, body: jsonEncode(body));
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        if (responseMap["response_code"] == 200 ||
            responseMap["response_code"] == 201) {
          if (showSuccessToast) {
            MotionToast.success(
                    position: MotionToastPosition.top,
                    animationType: AnimationType.fromTop,
                    title: Text("Success"),
                    description: Text(responseMap["message"]))
                .show(Get.overlayContext!);
          }
          return CustomResponse(state: true, response: responseMap);
        } else {
          if (showErrorToast) {
            MotionToast.error(
                    position: MotionToastPosition.top,
                    animationType: AnimationType.fromTop,
                    title: Text("Error"),
                    description: Text(responseMap["message"]))
                .show(Get.overlayContext!);
          }
        }
      }
    } on SocketException {
      if (showErrorToast) {
        MotionToast.error(
                position: MotionToastPosition.top,
                animationType: AnimationType.fromTop,
                title: Text("Error"),
                description: Text("Couldnt connect to server"))
            .show(Get.overlayContext!);
      }
    } on TimeoutException {
      if (showErrorToast) {
        MotionToast.error(
                position: MotionToastPosition.top,
                animationType: AnimationType.fromTop,
                title: Text("Error"),
                description: Text("Connection Timeout"))
            .show(Get.overlayContext!);
      }
    } catch (e) {
      if (showErrorToast) {
        MotionToast.error(
                position: MotionToastPosition.top,
                animationType: AnimationType.fromTop,
                title: Text("Error"),
                description: Text("Unexpected Error Occured"))
            .show(Get.overlayContext!);
      }
    }
    return CustomResponse(state: false);
  }

  static Future<CustomResponse> sendFormData(String endpoint,
      {Map<String, dynamic>? fields,
      required Map<String, dynamic> media,
      bool useToken = true,
      Function(int sendProgress, int totalProgress)? onSendProgress}) async {
    Map<String, dynamic> formFields = fields ?? {};
    Dio dio = Dio();
    dio.options.headers["Content-Type"] = "multipart/form-data";
    for (var key in media.keys) {
      final value = media[key];
      if (value is List) {
        List a = [];
        for (var item in value) {
          String? mimeType = mime(basename(item.fileName));
          String mimee = mimeType!.split('/')[0];
          String type = mimeType.split('/')[1];
          a.add(MultipartFile.fromBytes(item.data,
              filename: mimee, contentType: MediaType(mimee, type)));
        }

        formFields[key] = a;
      } else {
        String? mimeType = mime(basename(value.fileName));
        String mimee = mimeType!.split('/')[0];
        String type = mimeType.split('/')[1];

        formFields[key] = MultipartFile.fromBytes(value.data,
            filename: mimee, contentType: MediaType(mimee, type));
      }
    }
    print(formFields);
    FormData formData = FormData.fromMap(formFields);

    if (useToken) {
      FlutterSecureStorage storage = const FlutterSecureStorage();

      final accessToken = await storage.read(key: kAccessToken);

      dio.options.headers["Authorization"] = "Bearer $accessToken";
    }
    late Response response;
    try {
      response = await dio.post(kBaseUrl + endpoint, data: formData,
          onSendProgress: (a, b) {
        if (onSendProgress != null) {
          onSendProgress(a, b);
        }
      }).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        if (response.data["response_code"] == 200 ||
            response.data["response_code"] == 201) {
          return CustomResponse(state: true, response: response.data);
        } else {
          print(response.data);
          MotionToast.error(
                  position: MotionToastPosition.top,
                  animationType: AnimationType.fromTop,
                  title: Text("Error"),
                  description: Text(response.data["message"]))
              .show(Get.overlayContext!);
        }
      }
    } on DioError catch (e) {
      if (useToken && (e.response != null && e.response?.statusCode == 401)) {
        Get.to(LoginPage());
        MotionToast.error(
                position: MotionToastPosition.top,
                animationType: AnimationType.fromTop,
                title: Text("Error"),
                description: Text(response.data["message"]))
            .show(Get.overlayContext!);
      }
    } catch (e) {
      print(e.toString());
      MotionToast.error(
              position: MotionToastPosition.top,
              animationType: AnimationType.fromTop,
              title: Text("Error"),
              description: Text(e.toString()))
          .show(Get.overlayContext!);
    }
    return CustomResponse(state: false);
  }
}

class CustomResponse {
  final bool state;
  final Map<String, dynamic>? response;

  CustomResponse({required this.state, this.response});
}
