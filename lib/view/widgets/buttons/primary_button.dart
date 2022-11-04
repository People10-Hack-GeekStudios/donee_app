import 'package:flutter/material.dart';
import 'package:fud_app/view/constants/constants.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double width;
  final bool loading;
  const PrimaryButton(
      {Key? key,
      required this.onTap,
      this.loading = false,
      this.width = double.infinity,
      this.text = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = width == double.infinity
        ? MediaQuery.of(context).size.width - kDefaultPadding
        : width;
    const double h = 50;
    return AnimatedContainer(
      duration: kDuration,
      width: loading ? 80 : w,
      height: h,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
        ],
        gradient: kButtonGradient,
        color: Colors.deepPurple.shade300,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: loading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          : ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(Size(width, h)),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                // elevation: MaterialStateProperty.all(3),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                onTap();
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
    );
  }
}
