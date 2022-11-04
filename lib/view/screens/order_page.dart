import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fud_app/api/hotels/hotel_api.dart';
import 'package:fud_app/models/hotel_model.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  HotelModel hotel = HotelApi.getHotel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 219, 238, 247),
        appBar: AppBar(
            title: Text(
          'Order Food',
        )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    hotel.name,
                    //textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 125,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: const SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    "Biriyani - 20-fgqfebvnmaahuvc-f9uqfkjavvnadvupavwqwwvmanvauewfqfqwef9uqfkjavvnadvupavwqwwvmanvauewfqfqweff9uqfkjavvnadvupavwqwwvmanvauewfqfqweff9uqfkjavvnadvupavwqwwvmanvauewfqfqweff9uqfkjavvnadvupavwqwwvmanvauewfqfqweff",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Number of parcels:",
                    style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: '10',
                          border: InputBorder.none,
                          fillColor: Colors.white,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
