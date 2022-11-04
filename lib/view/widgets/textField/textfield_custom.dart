import 'package:flutter/material.dart';
import 'package:fud_app/view/constants/constants.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.size,
  }) : super(key: key);
  final TextEditingController controller;
  final Size size;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      width: size.width,
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(kBorderRadius),
          boxShadow: [
            BoxShadow(
              color: kGreen.withOpacity(.2),
              blurRadius: 15,
            )
          ]),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: TextFormField(
        controller: controller,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: hintText),
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
