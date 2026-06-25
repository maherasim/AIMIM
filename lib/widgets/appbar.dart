// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'svg_button.dart';

// bool _isTrainerOrBusinessAdmin() {
//   final userData = AuthStorageService().getUserData();
//   final role = (userData?['role'] as String?)?.toLowerCase() ?? '';
//   return role == 'trainer' || role == 'business_admin';
// }

// class CustomAppbar extends StatelessWidget {
//   const CustomAppbar({
//     super.key,
//     this.title,
//     this.showBackButton = true,
//     this.isLeading = true,
//     this.isLogout = false,
//     this.isHome = false,
//   });
//   final String? title;
//   final bool? showBackButton;
//   final bool? isLeading;
//   final bool? isLogout;
//   final bool? isHome;

//   void _showWhatsAppSupportPopup() {
//     Get.dialog(
//       Dialog(
//         backgroundColor: Colors.transparent,
//         insetPadding: EdgeInsets.symmetric(horizontal: 25.w),
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
//           decoration: BoxDecoration(
//             image: const DecorationImage(
//               image: AssetImage('assets/images/bg-2.png'),
//               fit: BoxFit.cover,
//             ),
//             borderRadius: BorderRadius.circular(20.r),
//             border: Border.all(
//               color: AppTheme.primaryPink.withValues(alpha: 0.3),
//               width: 1.5.w,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: AppTheme.primaryPink.withValues(alpha: 0.3),
//                 blurRadius: 10.r,
//                 spreadRadius: 0,
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 60.w,
//                 height: 60.h,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppTheme.primaryPink.withValues(alpha: 0.2),
//                 ),
//                 child: Icon(
//                   Icons.support_agent_rounded,
//                   color: AppTheme.primaryPink,
//                   size: 30.sp,
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               Text(
//                 'common.whatsappSupportTitle'.tr,
//                 style: GoogleFonts.montserrat(
//                   fontSize: 24.sp,
//                   fontWeight: FontWeight.w700,
//                   color: AppTheme.white,
//                 ),
//               ),
//               SizedBox(height: 12.h),
//               Text(
//                 'common.whatsappSupportMessage'.tr,
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.inter(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w400,
//                   color: AppTheme.greyText,
//                 ),
//               ),
//               SizedBox(height: 28.h),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () => Get.back(),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppTheme.primaryPink,
//                     foregroundColor: AppTheme.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 14.h),
//                   ),
//                   child: Text(
//                     'common.ok'.tr,
//                     style: GoogleFonts.inter(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w600,
//                       color: AppTheme.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       barrierDismissible: true,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final showProfileIcon = _isTrainerOrBusinessAdmin();
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Image.asset(
//           'assets/images/logo-1.png',
//           fit: BoxFit.contain,
//           width: 150.w,
//           height: 68.h,
//         ),
//         if (showProfileIcon)
//           Bounceable(
//             onTap: () => Get.toNamed(Routes.PROFILE),
//             child: Container(
//               margin: EdgeInsets.only(right: 17.w),
//               padding: EdgeInsets.all(10.w),
//               decoration: BoxDecoration(
//                 color: AppTheme.primaryPink.withValues(alpha: 0.1),
//                 // borderRadius: BorderRadius.circular(12.r),
//                 shape: BoxShape.circle,
//                 border: Border.all(color: AppTheme.primaryPink, width: 0.5.w),
//               ),
//               child: Icon(
//                 Icons.person_rounded,
//                 color: AppTheme.white,
//                 size: 28.sp,
//               ),
//             ),
//           )
//         else
//           ImageButton(
//             image: 'assets/images/whatsapp-icon.png',
//             onTap: _showWhatsAppSupportPopup,
//           ),
//       ],
//     );
//   }
// }

// class DefaultAppbar extends StatelessWidget {
//   const DefaultAppbar({
//     super.key,
//     this.isLeading = false,
//     this.showBackButton = false,
//     this.title,
//     this.titleIcon,
//     this.isLogout = false,
//     this.onLogout,
//   });

//   final bool? isLeading;
//   final bool? showBackButton;
//   final String? title;
//   final IconData? titleIcon;
//   final bool? isLogout;
//   final VoidCallback? onLogout;

//   void _showWhatsAppSupportPopup() {
//     Get.dialog(
//       Dialog(
//         backgroundColor: Colors.transparent,
//         insetPadding: EdgeInsets.symmetric(horizontal: 25.w),
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
//           decoration: BoxDecoration(
//             image: const DecorationImage(
//               image: AssetImage('assets/images/bg-2.png'),
//               fit: BoxFit.cover,
//             ),
//             borderRadius: BorderRadius.circular(20.r),
//             border: Border.all(
//               color: AppTheme.primaryPink.withValues(alpha: 0.3),
//               width: 1.5.w,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: AppTheme.primaryPink.withValues(alpha: 0.3),
//                 blurRadius: 10.r,
//                 spreadRadius: 0,
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 60.w,
//                 height: 60.h,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppTheme.primaryPink.withValues(alpha: 0.2),
//                 ),
//                 child: Icon(
//                   Icons.support_agent_rounded,
//                   color: AppTheme.primaryPink,
//                   size: 30.sp,
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               Text(
//                 'common.whatsappSupportTitle'.tr,
//                 style: GoogleFonts.montserrat(
//                   fontSize: 24.sp,
//                   fontWeight: FontWeight.w700,
//                   color: AppTheme.white,
//                 ),
//               ),
//               SizedBox(height: 12.h),
//               Text(
//                 'common.whatsappSupportMessage'.tr,
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.inter(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w400,
//                   color: AppTheme.greyText,
//                 ),
//               ),
//               SizedBox(height: 28.h),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () => Get.back(),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppTheme.primaryPink,
//                     foregroundColor: AppTheme.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 14.h),
//                   ),
//                   child: Text(
//                     'common.ok'.tr,
//                     style: GoogleFonts.inter(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w600,
//                       color: AppTheme.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       barrierDismissible: true,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final showProfileIcon = _isTrainerOrBusinessAdmin();
//     return AppBar(
//       centerTitle: true,
//       surfaceTintColor: Colors.transparent,
//       leadingWidth: 66.w,
//       leading: isLeading! && showBackButton!
//           ? Container(
//               margin: EdgeInsets.only(left: 17.w),
//               child: SvgButton(
//                 icon: 'assets/svgs/arrow_back.svg',
//                 onTap: () {
//                   Get.back();
//                 },
//               ),
//             )
//           : Container(),

//       title: title != null
//           ? (titleIcon != null
//                 ? Row(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(titleIcon, color: AppTheme.primaryPink, size: 24.sp),
//                       SizedBox(width: 8.w),
//                       Flexible(
//                         child: Text(
//                           title!,
//                           style: AppTheme.lightTheme.textTheme.headlineLarge!
//                               .copyWith(fontSize: 26.sp),
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ],
//                   )
//                 : Text(
//                     title!,
//                     style: AppTheme.lightTheme.textTheme.headlineLarge!
//                         .copyWith(fontSize: 26.sp),
//                   ))
//           : null,
//       actions: [
//         if (isLogout!)
//           ImageButton(
//             image: 'assets/images/logout.png',
//             onTap: onLogout ?? () {},
//           )
//         else if (showProfileIcon)
//           Bounceable(
//             onTap: () => Get.toNamed(Routes.PROFILE),
//             child: Container(
//               margin: EdgeInsets.only(right: 17.w),
//               padding: EdgeInsets.all(10.w),
//               child: Icon(
//                 Icons.person_rounded,
//                 color: AppTheme.white,
//                 size: 28.sp,
//               ),
//             ),
//           )
//         else
//           ImageButton(
//             image: 'assets/images/whatsapp-icon.png',
//             onTap: _showWhatsAppSupportPopup,
//           ),
//       ],
//     );
//   }
// }

// class ImageButton extends StatelessWidget {
//   const ImageButton({super.key, required this.image, this.onTap});
//   final String image;
//   final VoidCallback? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Bounceable(
//       onTap: onTap ?? () {},
//       child: Container(
//         margin: EdgeInsets.only(right: 17.w),
//         child: Image.asset(image, fit: BoxFit.contain, width: 50),
//       ),
//     );
//   }
// }
