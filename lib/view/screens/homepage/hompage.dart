import 'package:flutter/material.dart';
import 'package:fud_app/api/hotel/hotel.dart';
import 'package:fud_app/models/hotel_model.dart';
import 'package:fud_app/view/screens/order/order_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../helper_widget/mapview/mapview_widget.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<HotelModel>>(
      future: HotelApi.nearby(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        return FutureBuilder<Position>(
            future: Geolocator.getCurrentPosition(),
            builder: ((context, snapshot1) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot1.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot1.hasError) {
                return const Center(
                  child: Text("Couldn't get the GPS values"),
                );
              }

              return MapViewWidget(
                onClicked: (hotel) {
                  Get.to(DonationOrderPage(hotel: hotel));
                },
                hotelModel: snapshot.data!,
                location:
                    LatLng(snapshot1.data!.latitude, snapshot1.data!.longitude),
              );
            }));
      },
    ));
  }
}
