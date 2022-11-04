// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fud_app/view/constants/constants.dart';
// import 'package:fud_app/view/widgets/round_icon.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_web/image_picker_web.dart';

// class ImageContainer extends StatefulWidget {
//   const ImageContainer(
//       {super.key,
//       this.height = 250,
//       this.width = 350,
//       this.icon,
//       this.iconBg = kPrimaryTextColor,
//       this.imageTap,
//       this.iconTap,
//       this.title,
//       this.fit = BoxFit.cover,
      
//       this.loading = false,
//       this.imageAsMediaInfo,
//       this.url =
//           "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"});
//   final String url;
//   final double height;
//   final double width;
//   final IconData? icon;
//   final Color iconBg;
//   final Function(MediaInfo)? imageTap;
//   final VoidCallback? iconTap;
//   final String? title;
//   final bool loading;
//   final BoxFit fit;
//   final MediaInfo? imageAsMediaInfo;
//   @override
//   State<ImageContainer> createState() => _ImageContainerState();
// }

// class _ImageContainerState extends State<ImageContainer> {
//   String path = '';
//   XFile? storedImage;
//   MediaInfo? imageMediaInfo;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.topRight,
//       children: [
//         InkWell(
//           onTap: () async {
//             if (widget.imageTap != null) {
//               await _imageWebAdd();
//               widget.imageTap!(imageMediaInfo!);
//             }
//           },
//           child: Padding(
//             padding: EdgeInsets.all(widget.icon == null ? 0 : 8.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(kBorderRadius),
//               child: Stack(
//                 alignment: Alignment.topLeft,
//                 children: [
//                   Container(
//                       height: widget.height,
//                       width: widget.width,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(kBorderRadius),
//                           color: kLightGrey),
//                       child: widget.loading
//                           ? const Center(
//                               child: SpinKitFadingCircle(color: kGreen),
//                             )
//                           : widget.imageAsMediaInfo != null
//                               ? Image.memory(
//                                   widget.imageAsMediaInfo!.data!,
//                                   fit: widget.fit,
//                                 )
//                               : imageMediaInfo != null
//                                   ? Image.memory(
//                                       imageMediaInfo!.data!,
//                                       fit: widget.fit,
//                                     )
//                                   : Image.network(
//                                       widget.url,
//                                       fit: widget.fit,
//                                     )),
//                   if (widget.title != null)
//                     Container(
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: kPrimaryTextColor),
//                       child: Text(
//                         widget.title!,
//                         style: TextStyle(color: kWhite),
//                       ),
//                     )
//                 ],
//               ),
//             ),
//           ),
//         ),
//         if (widget.icon != null)
//           roundIcon(
//               icon: widget.icon!,
//               background: widget.iconBg,
//               onTap: () {
//                 if (widget.iconTap != null) {
//                   widget.iconTap!();
//                 }
//               })
//       ],
//     );
//   }

//   imageAdd() async {
//     final ImagePicker picker = ImagePicker();
//     // Pick an image
//     XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         // storedImage = File(image.path);
//         storedImage = image;
//         path = image.path;
//       });
//     }
//   }

//   _imageWebAdd() async {
//     MediaInfo? mediaData = await ImagePickerWeb.getImageInfo;
//     setState(() {
//       imageMediaInfo = mediaData;
//     });
//   }
// }
