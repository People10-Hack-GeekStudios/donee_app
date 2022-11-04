import 'package:flutter/material.dart';
import 'package:fud_app/view/constants/constants.dart';
import 'package:get/get.dart';


class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({Key? key, required this.currentIndex})
      : super(key: key);
  final int currentIndex;

  @override
  State<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  List pages = [
    // const HomePage(),
    // const NotificatonsPage(),
    // const FavouritesPage(),
    // ProfilePageLayout()
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        color: kWhite,
        height: 70,
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => pressed(0),
              child: Icon(
                widget.currentIndex == 0 ? Icons.home : Icons.home_outlined,
                size: 28,
                color: kGreen,
              ),
            ),
            GestureDetector(
              onTap: () => pressed(1),
              child: Icon(
                widget.currentIndex == 1
                    ? Icons.notifications_active
                    : Icons.notifications_none,
                size: 28,
                color: kGreen,
              ),
            ),
            GestureDetector(
              onTap: () => pressed(2),
              child: Icon(
                widget.currentIndex == 2
                    ? Icons.favorite_rounded
                    : Icons.favorite_border,
                size: 28,
                color: kGreen,
              ),
            ),
            GestureDetector(
              onTap: () => pressed(3),
              child: Icon(
                widget.currentIndex == 3
                    ? Icons.account_circle
                    : Icons.account_circle_outlined,
                size: 28,
                color: kGreen,
              ),
            ),
          ],
        ));
  }

  void pressed(int index) {
    if (widget.currentIndex != index) {
      Get.to(pages[index]);
    }
  }
}
