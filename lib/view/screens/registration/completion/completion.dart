import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fud_app/api/auth/auth.dart';
import 'package:fud_app/view/constants/constants.dart';
import 'package:fud_app/view/screens/homepage/hompage.dart';
import 'package:fud_app/view/screens/order_page.dart';
import 'package:fud_app/view/widgets/buttons/elevated-button/loading_button.dart';
import 'package:fud_app/view/widgets/textField/textfield_custom.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class ProfileCompletion extends StatefulWidget {
  const ProfileCompletion({super.key});

  @override
  State<ProfileCompletion> createState() => _ProfileCompletionState();
}

class _ProfileCompletionState extends State<ProfileCompletion> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _orgName = TextEditingController();
  final TextEditingController _orgCapacity = TextEditingController();
  final TextEditingController _orgAddress = TextEditingController();
  final TextEditingController _orgKycType = TextEditingController();
  final TextEditingController _orgKyc = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: kDefaultPadding,
              ),
              Text("Few more details required",
                  style: TextStyle(
                      color: kPrimaryTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              SvgPicture.asset(
                "assets/svg/completion.svg",
                height: 250,
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              TextFieldCustom(
                size: size,
                hintText: "Full Name",
                controller: _nameController,
              ),
              TextFieldCustom(
                size: size,
                hintText: "Organisation Name",
                controller: _orgName,
              ),
              TextFieldCustom(
                size: size,
                hintText: "Organisation Capacity",
                controller: _orgCapacity,
              ),
              TextFieldCustom(
                size: size,
                hintText: "Organisation Address",
                controller: _orgAddress,
              ),
              TextFieldCustom(
                size: size,
                hintText: "KYC Type",
                controller: _orgKycType,
              ),
              TextFieldCustom(
                size: size,
                hintText: "KYC Number",
                controller: _orgKyc,
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              LoadingButton(
                loading: loading,
                onPressed: () {
                  if (_validateAllFields()) {
                    setState(() {
                      loading = true;
                    });
                    AuthApi.profileCompletion(
                            fullName: _nameController.text,
                            orgName: _orgName.text,
                            orgAddress: _orgAddress.text,
                            orgCapacity: int.parse(_orgCapacity.text),
                            orgKyc: _orgKyc.text,
                            orgKycType: _orgKycType.text)
                        .then((completion) {
                      setState(() {
                        loading = false;
                      });
                      if (completion == 1) {
                        Get.to(Homepage());
                      }
                    });
                  }
                },
                text: "Continue",
                width: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateAllFields() {
    if (_nameController.text == "" ||
        _orgAddress.text == "" ||
        _orgCapacity.text == "" ||
        _orgKyc.text == "" ||
        _orgKycType.text == "" ||
        _orgName.text == "") {
      MotionToast.error(
              position: MotionToastPosition.top,
              animationType: AnimationType.fromTop,
              title: Text("Field Required"),
              description: Text("All Fields are required"))
          .show(context);
      return false;
    } else {
      if (int.tryParse(_orgCapacity.text) == null) {
        MotionToast.error(
                position: MotionToastPosition.top,
                animationType: AnimationType.fromTop,
                title: Text("Invalid field"),
                description: Text("Enter a valid number as capacity"))
            .show(context);
        return false;
      }
    }
    return true;
  }
}
