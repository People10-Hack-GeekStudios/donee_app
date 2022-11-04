import 'package:flutter/material.dart';
import 'package:fud_app/view/constants/constants.dart';

class DropDown extends StatelessWidget {
  const DropDown({Key? key, required this.width}) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 30),
        ],
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
    );
  }
}
