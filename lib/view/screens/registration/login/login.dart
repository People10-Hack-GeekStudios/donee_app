import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fud_app/api/auth/auth.dart';
import 'package:fud_app/view/constants/constants.dart';
import 'package:fud_app/view/screens/order_page.dart';
import 'package:fud_app/view/screens/registration/login/mobile_field.dart';
import 'package:fud_app/view/screens/registration/otp/otp.dart';
import 'package:get/get.dart';

import '../../../widgets/buttons/elevated-button/loading_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mobileController = TextEditingController();
  bool loading = false;

  String url = "https://geekstudios.tech/";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgColor,
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        height: size.height,
        width: size.width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: kDefaultPadding * 2,
              ),
              Expanded(
                flex: 2,
                child: SvgPicture.asset(
                  "assets/svg/login_svg1.svg",
                ),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Text("Seeker App",
                  style: TextStyle(
                      color: kGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 2 * kDefaultPadding,
              ),
              MobileField(
                size: size,
                controller: mobileController,
              ),
              const SizedBox(
                height: kDefaultPadding * 2,
              ),
              LoadingButton(
                loading: loading,
                text: "Let's go",
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  AuthApi.login(mobile: mobileController.text).then((value) {
                    if (value) {
                      Get.to(() => OTPScreen(
                            mobile: mobileController.text,
                          ));
                    }
                    setState(() {
                      loading = false;
                    });
                  });
                },
                width: size.width - 4 * kDefaultPadding,
                height: 55,
              ),
              const SizedBox(
                height: kDefaultPadding * 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "designed and developed by",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    "GeekStudios LLP",
                    style: TextStyle(
                      fontSize: 14,
                      color: kGreen,
                    ),
                  )
                ],
              )
            ]),
      ),
    );
  }
}
