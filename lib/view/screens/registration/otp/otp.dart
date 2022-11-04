import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:flutter_svg/svg.dart';
import 'package:fud_app/api/auth/auth.dart';
import 'package:fud_app/view/screens/order_page.dart';
import 'package:fud_app/view/screens/homepage/hompage.dart';
import 'package:fud_app/view/screens/registration/completion/completion.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../widgets/buttons/elevated-button/loading_button.dart';

class OTPScreen extends StatefulWidget {
  // final OTPNotifier otpNotifier;
  final String mobile;
  const OTPScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String verificationCode = "";
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    pinController.dispose();

    super.dispose();
  }

  final pinController = TextEditingController();

  /// Set text programmatically

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kWhite,
          elevation: 0,
          leadingWidth: 25,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          title: Text(
            "Donee App",
            style: TextStyle(color: kGreen, fontSize: 16),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: size.height - kDefaultPadding * 8,
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: kDefaultPadding,
                ),
                SvgPicture.asset(
                  "assets/svg/otp_svg.svg",
                  width: size.height * 1 / 3,
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Text(
                        "Verification",
                        style:
                            TextStyle(color: kPrimaryTextColor, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.mobile,
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: kGreen,
                  focusedBorderColor: kGreen,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onSubmit: ((code) {
                    setState(() {
                      verificationCode = code;
                    });
                  }),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Column(
                    children: [
                      LoadingButton(
                        loading: loading,
                        text: "Continue",
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
                          AuthApi.validate(
                                  otp: verificationCode, mobile: widget.mobile)
                              .then((completion) {
                            setState(() {
                              loading = false;
                            });

                            if (completion == 0) {
                              Get.to(ProfileCompletion());
                            } else if (completion == 1) {
                              Get.to(Homepage());

                              if (completion == 0) {
                                Get.to(const ProfileCompletion());
                              }
                            }
                          });
                        },
                        width: size.width - 4 * kDefaultPadding,
                        height: 55,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
