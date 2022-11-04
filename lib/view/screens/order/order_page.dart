import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fud_app/api/hotels/hotel_api.dart';
import 'package:fud_app/models/hotel_model.dart';
import 'package:fud_app/view/widgets/appbar.dart';
import 'package:fud_app/view/widgets/buttons/elevated-button/loading_button.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';

class DonationOrderPage extends StatefulWidget {
  const DonationOrderPage({
    required this.hotel,
    Key? key,
  }) : super(key: key);
  final HotelModel hotel;
  @override
  State<DonationOrderPage> createState() => _DonationOrderPageState();
}

class _DonationOrderPageState extends State<DonationOrderPage> {
  bool loading = true;
  bool buttonLoading = false;
  List<Widget> imageContainers = [];
  bool favourite = false;

  bool mapLoading = false;

  int currentPage = 1;
  bool newPostLoading = false;
  bool pageLimit = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kBgColor,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  mapLoading = true;
                });
                var query =
                    '${widget.hotel.geojson.coordinates[1]},${widget.hotel.geojson.coordinates[0]}';
                final uri = Uri(
                    scheme: 'geo', host: '0,0', queryParameters: {'q': query});

                _launchUrl(uri).whenComplete(() {
                  setState(() {
                    mapLoading = false;
                  });
                });
              },
              backgroundColor: kPrimaryTextColor,
              child: Icon(
                Icons.location_on_rounded,
                color: kWhite,
              ),
            ),
            const SizedBox(
              width: kDefaultPadding,
            ),
            FloatingActionButton(
              onPressed: () {
                _callNumber(number: widget.hotel.phone);
              },
              backgroundColor: kPrimaryTextColor,
              child: Icon(
                Icons.call,
                color: kWhite,
              ),
            ),
          ],
        ),
      ),
      appBar: CustomAppbar(
        title: "Order Food",
        back: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/svg/helping.svg",
              height: 240,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.food_bank,
                        color: kGreen,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.hotel.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: kGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              children: [
                const SizedBox(
                  width: kDefaultPadding,
                ),
                Text(
                  "Donated ",
                  style: _titleTextstyle(color: kGreen),
                ),
                Text(
                  "${widget.hotel.donatedItems.length} result${widget.hotel.donatedItems.length > 1 ? "s" : ""}",
                  style: _bodyTextstyle(),
                ),
              ],
            ),
            for (DonatedItem donatation in widget.hotel.donatedItems)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Container(
                  width:
                      MediaQuery.of(context).size.width - kDefaultPadding * 2,
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Row(
                    children: [
                      Image.network(
                        donatation.image,
                        width: 70,
                      ),
                      const SizedBox(
                        width: kDefaultPadding,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            donatation.name,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            donatation.foodType,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "quantity ${donatation.quantity}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    ));
  }

  TextStyle _titleTextstyle({Color color = Colors.grey}) {
    return TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  Future _callNumber({required String number}) async {
    FlutterPhoneDirectCaller.callNumber(number).whenComplete(() {
      return;
    });
  }

  TextStyle _bodyTextstyle() {
    return TextStyle(
      color: Colors.grey.shade700,
      fontSize: 16,
    );
  }

  Widget _item(
      {required IconData icon, required String title, required String desc}) {
    if (desc != null) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: kDefaultPadding,
        ),
        Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: Colors.grey,
            ),
            Text(
              title,
              textAlign: TextAlign.left,
              style: _titleTextstyle(),
            ),
          ],
        ),
        Text(
          desc,
          style: _bodyTextstyle(),
        ),
      ]);
    } else {
      return SizedBox();
    }
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
