import 'package:flutter/material.dart';
import 'package:fud_app/view/constants/constants.dart';

class ImgSourceOverlay extends StatefulWidget {
  const ImgSourceOverlay({Key? key, required this.overlayEntry})
      : super(key: key);
  final OverlayEntry overlayEntry;

  @override
  State<ImgSourceOverlay> createState() => _ImgSourceOverlayState();
}

class _ImgSourceOverlayState extends State<ImgSourceOverlay> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Material(
        color: Colors.black.withOpacity(.1),
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () => widget.overlayEntry.remove(),
              child: Container(
                color: Colors.black.withOpacity(.4),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
              ),
            ),
            Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                child: Container(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  height: size.height * 0.25,
                  width: size.width,
                  color: kWhite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Profile Photo',
                              style: TextStyle(
                                color: kPrimaryTextColor,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: kDefaultPadding,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: const [
                                      Icon(
                                        Icons.photo_camera,
                                        color: kGreen,
                                      ),
                                      Text(
                                        'Camera',
                                        style: TextStyle(
                                          color: kHintTextColor,
                                          fontSize: 9,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: const [
                                      Icon(
                                        Icons.photo,
                                        color: kGreen,
                                      ),
                                      Text(
                                        'Gallery',
                                        style: TextStyle(
                                          color: kHintTextColor,
                                          fontSize: 9,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextStyle titleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: kGreen,
  );

  Widget choiceItem(
      {required int i, required List<String> list, required int compItem}) {
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
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1,
                  color: i == compItem ? kGreen : kPrimaryTextColor,
                )),
            alignment: Alignment.center,
            child: i == compItem
                ? Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8), color: kGreen),
                  )
                : const SizedBox(),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            list[i],
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
