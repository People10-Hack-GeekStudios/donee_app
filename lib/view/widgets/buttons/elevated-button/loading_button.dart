import 'package:flutter/material.dart';
import 'package:fud_app/view/constants/constants.dart';
import 'package:fud_app/view/widgets/buttons/elevated-button/custom_elevated_button.dart';

class LoadingButton extends StatelessWidget {
  final bool loading;
  final double width, height;
  final String text;
  final VoidCallback onPressed;
  final Color color;
  const LoadingButton(
      {Key? key,
      this.color = kGreen,
      this.text = "",
      required this.loading,
      this.height = 45,
      this.width = double.infinity,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = width == double.infinity
        ? MediaQuery.of(context).size.width - kDefaultPadding
        : width;
    return AnimatedContainer(
        duration: kDuration,
        width: loading ? 80 : w,
        child: AppElevatedButton(
            onPressed: onPressed,
            text: text,
            color: color,
            height: height,
            width: loading ? 80 : w,
            child: loading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : null));
  }
}
