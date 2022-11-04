import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fud_app/view/constants/constants.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DropdownItemSelectPage extends StatefulWidget {
  const DropdownItemSelectPage(
      {Key? key, required this.items, required this.onchanged})
      : super(key: key);
  final List<String> items;
  final Function(int) onchanged;
  @override
  State<DropdownItemSelectPage> createState() => _DropdownItemSelectPageState();
}

class _DropdownItemSelectPageState extends State<DropdownItemSelectPage> {
  String filter = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        body: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kGrey,
                    boxShadow: [
                      BoxShadow(
                          color: kPrimaryTextColor.withOpacity(0.1),
                          blurRadius: 20),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            filter = value.toLowerCase();
                          });
                        },
                        style: TextStyle(
                          color: kPrimaryTextColor,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            // labelText: 'Password',
                            hintText: "Search",
                            hintStyle: TextStyle(
                              color: kPrimaryTextColor,
                              fontSize: 16,
                            )),
                      ),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      "assets/svg/search.svg",
                      color: kGrey,
                      height: 24,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "search results",
                        style: titleStyle,
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      widget.items.isEmpty
                          ? Lottie.asset("assets/lotties/nothing.json")
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SingleChildScrollView(
                                child: Column(children: [
                                  for (int i = 0; i < widget.items.length; i++)
                                    if (widget.items[i]
                                        .toLowerCase()
                                        .contains(filter))
                                      GestureDetector(
                                          onTap: () {
                                            widget.onchanged(i);
                                          },
                                          child: locationItem(
                                              i: i, items: widget.items))
                                ]),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle titleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: kGreen,
  );
  Widget locationItem({required int i, required List<String> items}) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: double.maxFinite,
      color: i % 2 == 0
          ? kGreen.withOpacity(.1)
          : kPrimaryTextColor.withOpacity(.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            items[i],
            style: TextStyle(
              color: kPrimaryTextColor,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
