import 'package:flutter/material.dart';
import 'package:fud_app/view/constants/constants.dart';

import 'custom_elevated_button.dart';

class ProgressButton extends StatelessWidget {
  final bool showProgress;
  final double width, height, value;
  final String text;
  final VoidCallback onPressed;
  const ProgressButton(
      {Key? key,
      this.text = "",
      this.value = 0,
      required this.showProgress,
      this.height = 45,
      this.width = double.infinity,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = width == double.infinity
        ? MediaQuery.of(context).size.width - kDefaultPadding
        : width;
    return AppElevatedButton(
        onPressed: onPressed,
        text: text,
        height: height,
        width: w,
        color: showProgress ? Theme.of(context).scaffoldBackgroundColor : null,
        child: showProgress
            ? Stack(
                children: [
                  AnimatedContainer(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    height: height,
                    duration: kDuration,
                    width: value * w,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.25),
                      child: Text(
                        (value * 100).toInt().toString() + "% Completed",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              )
            : null);
  }
}
