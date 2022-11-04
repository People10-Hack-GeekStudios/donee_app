import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fud_app/view/constants/constants.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    Key? key,
    this.title = "",
    this.prefixIcon,
    this.backgroundColor = kWhite,
    this.back = false,
    this.profileIcon = false,
    this.suffixIcon,
  }) : super(key: key);
  final String title;
  final bool back;
  final bool profileIcon;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color backgroundColor;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      color: backgroundColor,
      child: Row(
        children: [
          if (back)
            Padding(
              padding: const EdgeInsets.only(right: kDefaultPadding),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: kPrimaryTextColor,
                  size: 28,
                ),
              ),
            ),
          prefixIcon != null ? prefixIcon! : SizedBox(),
          Text(
            title,
            style: TextStyle(
                color: kPrimaryTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          suffixIcon ?? const SizedBox(),
          if (profileIcon)
            GestureDetector(
              onTap: () {
                // Get.to(ProfilePageLayout());
              },
              child: Container(
                height: 35,
                width: 35,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kBgColor,
                ),
                child: SvgPicture.asset(
                  "assets/svg/user_icon.svg",
                  color: kGreen,
                ),
              ),
            ),
        ],
      ),
    ); // Your custom widget implementation.
  }
}
