// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import '../../app/theme/app_theme.dart';

// /// Reusable full-screen image viewer with zoom and swipe functionality
// /// Supports File, Network, and Asset images
// class ImageViewerView extends StatefulWidget {
//   /// List of image sources - can be File, String (URL), or AssetImage
//   final List<dynamic> images;

//   /// Initial index to display
//   final int initialIndex;

//   /// Optional title for the viewer
//   final String? title;

//   /// Whether to show image counter (default: true)
//   final bool showCounter;

//   /// Whether to show close button (default: true)
//   final bool showCloseButton;

//   const ImageViewerView({
//     super.key,
//     required this.images,
//     this.initialIndex = 0,
//     this.title,
//     this.showCounter = true,
//     this.showCloseButton = true,
//   });

//   @override
//   State<ImageViewerView> createState() => _ImageViewerViewState();
// }

// class _ImageViewerViewState extends State<ImageViewerView> {
//   late PageController _pageController;
//   late RxInt _currentIndex;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: widget.initialIndex);
//     _currentIndex = widget.initialIndex.obs;
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   ImageProvider _getImageProvider(dynamic image) {
//     if (image is File) {
//       return FileImage(image);
//     } else if (image is String) {
//       // Check if it's a network URL or asset path
//       if (image.startsWith('http://') || image.startsWith('https://')) {
//         return NetworkImage(image);
//       } else {
//         return AssetImage(image);
//       }
//     } else if (image is ImageProvider) {
//       return image;
//     } else {
//       throw ArgumentError('Unsupported image type: ${image.runtimeType}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       extendBodyBehindAppBar: true,
//       appBar: widget.showCloseButton
//           ? AppBar(
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               leading: IconButton(
//                 icon: Icon(Icons.close, color: AppTheme.white, size: 28.sp),
//                 onPressed: () => Get.back(),
//               ),
//               title: widget.title != null
//                   ? Text(
//                       widget.title!,
//                       style: GoogleFonts.inter(
//                         color: AppTheme.white,
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     )
//                   : null,
//               actions: widget.showCounter
//                   ? [
//                       Padding(
//                         padding: EdgeInsets.only(right: 16.w),
//                         child: Center(
//                           child: Obx(
//                             () => Text(
//                               '${_currentIndex.value + 1} / ${widget.images.length}',
//                               style: GoogleFonts.inter(
//                                 color: AppTheme.white,
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ]
//                   : null,
//             )
//           : null,
//       body: PhotoViewGallery.builder(
//         scrollPhysics: const BouncingScrollPhysics(),
//         builder: (BuildContext context, int index) {
//           return PhotoViewGalleryPageOptions(
//             imageProvider: _getImageProvider(widget.images[index]),
//             initialScale: PhotoViewComputedScale.contained,
//             minScale: PhotoViewComputedScale.contained,
//             maxScale: PhotoViewComputedScale.covered * 4,
//             heroAttributes: PhotoViewHeroAttributes(tag: 'image_$index'),
//           );
//         },
//         itemCount: widget.images.length,
//         loadingBuilder: (context, event) => Center(
//           child: CircularProgressIndicator(
//             value: event == null
//                 ? 0
//                 : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
//             color: AppTheme.primaryPink,
//             strokeWidth: 3.w,
//           ),
//         ),
//         pageController: _pageController,
//         onPageChanged: (index) {
//           _currentIndex.value = index;
//         },
//         backgroundDecoration: const BoxDecoration(color: Colors.black),
//       ),
//     );
//   }
// }
