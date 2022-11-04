import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fud_app/models/hotel_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewWidget extends StatefulWidget {
  final List<HotelModel> hotelModel;
  final LatLng location;
  final Function(HotelModel) onClicked;
  const MapViewWidget(
      {Key? key,
      required this.hotelModel,
      required this.location,
      required this.onClicked})
      : super(key: key);

  @override
  State<MapViewWidget> createState() => _MapViewWidgetState();
}

class _MapViewWidgetState extends State<MapViewWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  late CameraPosition _kGooglePlex;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.location.latitude, widget.location.longitude),
      zoom: 14.4746,
    );
    _add();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> _add() async {
    final location = await Geolocator.getCurrentPosition();

    for (HotelModel hotel in widget.hotelModel) {
      final MarkerId markerId = MarkerId(hotel.name);

      final Uint8List markerIcon =
          await getBytesFromAsset('assets/png/packaging.png', 200);
      final icon = BitmapDescriptor.fromBytes(markerIcon);

      // creating a new MARKER
      final Marker marker = Marker(
        markerId: markerId,
        icon: icon,
        position:
            LatLng(hotel.geojson.coordinates[1], hotel.geojson.coordinates[0]),
        infoWindow: InfoWindow(
          title: hotel.name,
        ),
        onTap: () {
          widget.onClicked(hotel);
        },
      );
      markers[markerId] = marker;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.terrain,
      initialCameraPosition: _kGooglePlex,
      markers: Set<Marker>.of(markers.values),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
