import 'package:flutter/material.dart';
import 'package:fud_app/view/constants/constants.dart';
import 'package:fud_app/view/widgets/textField/textfield_custom.dart';

class MobileField extends StatelessWidget {
  const MobileField({
    Key? key,
    required this.size,
    required this.controller,
  }) : super(key: key);

  final Size size;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: size.width - kDefaultPadding * 4,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: kPrimaryTextColor.withOpacity(.2),
                blurRadius: 10,
              )
            ]),
        child: TextFieldCustom(
          hintText: "Mobile",
          controller: controller,
          size: size,
        ));
  }
}
