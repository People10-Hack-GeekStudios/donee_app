import 'package:fud_app/models/hotel_model.dart';

import '../api.dart';

class HotelApi {
  static Future<List<HotelModel>> nearby() async {
    CustomResponse response =
        await Api.get('/user/v1/donee/profile/donations/');
    if (response.state) {
      return List.from(
          response.response!["response"].map((e) => HotelModel.fromJson(e)));
    }
    return [];
  }
}
