import 'package:flutter/material.dart';
import 'package:fud_app/view/constants/constants.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.color,
    required this.width,
    required this.height,
  }) : super(key: key);
  final double width;
  final VoidCallback onPressed;
  final String text;
  final double height;

  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        constraints: BoxConstraints(
          maxHeight: height,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: kWhite,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
