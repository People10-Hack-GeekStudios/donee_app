import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fud_app/api/api.dart';
import 'package:fud_app/database/user_database.dart';
import 'package:fud_app/view/constants/constants.dart';
import 'package:geolocator/geolocator.dart';

class AuthApi {
  static Future<bool> login({required String mobile}) async {
    CustomResponse response = await Api.post('/auth/v1/login',
        body: {"phone": mobile, "type": "donee"});
    return response.state;
  }

  static Future<int> validate(
      {required String mobile, required String otp}) async {
    final fcm = await FirebaseMessaging.instance.getToken();

    CustomResponse response = await Api.post('/auth/v1/validate/otp', body: {
      "phone": mobile,
      "otp": otp,
      "device": {"fcm": fcm}
    });
    if (response.state) {
      FlutterSecureStorage storage = const FlutterSecureStorage();

      await storage.write(
          key: kAccessToken,
          value: response.response!["response"]["accessToken"]);
      accessToken = response.response!["response"]["accessToken"];

      int profileCompletion =
          response.response!["response"]["user"]["profile_completion"];
      return profileCompletion;
    }

    return -1;
  }

  static Future<bool> profileCompletion(
      {required String fullName,
      required String orgName,
      required String orgAddress,
      required int orgCapacity,
      required String orgKyc,
      required String orgKycType}) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    CustomResponse response =
        await Api.post('/user/v1/donee/profile/complete/1/', body: {
      "name": fullName,
      "org_name": orgName,
      "org_capacity": orgCapacity,
      "org_address": orgAddress,
      "org_kyc": orgKyc,
      "org_kyc_type": orgKycType,
      "lat": position.latitude,
      "lon": position.longitude
    });
    return response.state;
  }
}
