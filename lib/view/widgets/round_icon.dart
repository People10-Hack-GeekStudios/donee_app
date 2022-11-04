import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fud_app/view/constants/constants.dart';
import 'package:get/get.dart';

Widget roundIcon(
    {double diameter = 30,
    required IconData icon,
    Color background = kGreen,
    VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap ?? () {},
    child: Container(
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(diameter / 2)),
      alignment: Alignment.center,
      child: Icon(
        icon,
        color: kWhite,
      ),
    ),
  );
}
