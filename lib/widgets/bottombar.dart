// import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../app/theme/app_theme.dart';

// class CustomBottombar extends StatelessWidget {
//   const CustomBottombar({
//     super.key,
//     this.onIndexChanged,
//     this.currentIndex = 1,
//     this.isTrainer = false,
//     /// When false (e.g. business_admin), trainer bar shows Home, Orders, Notifications only.
//     this.showTrainerExerciseTab = true,
//   });
//   final Function(int)? onIndexChanged;
//   final int currentIndex;
//   final bool isTrainer;
//   final bool showTrainerExerciseTab;
//   List<CurvedNavigationBarItem> get clientItems => [
//     CurvedNavigationBarItem(
//       child: SvgPicture.asset(
//         'assets/svgs/notification_icon.svg',
//         height: 28.h,
//       ),
//     ),
//     CurvedNavigationBarItem(
//       child: SvgPicture.asset('assets/svgs/home.svg', height: 28.h),
//     ),

//     CurvedNavigationBarItem(
//       child: SvgPicture.asset('assets/svgs/profile.svg', height: 28.h),
//     ),
//   ];
//   List<CurvedNavigationBarItem> get _trainerItemsThreeTabs => [
//         CurvedNavigationBarItem(
//           child: SvgPicture.asset('assets/svgs/home.svg', height: 28.h),
//         ),
//         CurvedNavigationBarItem(
//           child: SvgPicture.asset(
//             'assets/svgs/order-102.svg',
//             height: 30.h,
//             colorFilter: const ColorFilter.mode(
//               AppTheme.white,
//               BlendMode.srcIn,
//             ),
//           ),
//         ),
//         CurvedNavigationBarItem(
//           child: SvgPicture.asset(
//             'assets/svgs/notification_icon.svg',
//             height: 28.h,
//           ),
//         ),
//       ];

//   List<CurvedNavigationBarItem> get trainerItemsWithExercise => [
//         CurvedNavigationBarItem(
//           child: SvgPicture.asset('assets/svgs/home.svg', height: 28.h),
//         ),
//         CurvedNavigationBarItem(
//           child: SvgPicture.asset(
//             'assets/svgs/order-102.svg',
//             height: 30.h,
//             colorFilter: const ColorFilter.mode(
//               AppTheme.white,
//               BlendMode.srcIn,
//             ),
//           ),
//         ),
//         CurvedNavigationBarItem(
//           child: SvgPicture.asset(
//             'assets/svgs/exercise-101.svg',
//             height: 30.h,
//             colorFilter: const ColorFilter.mode(
//               AppTheme.white,
//               BlendMode.srcIn,
//             ),
//           ),
//         ),
//         CurvedNavigationBarItem(
//           child: SvgPicture.asset(
//             'assets/svgs/notification_icon.svg',
//             height: 28.h,
//           ),
//         ),
//       ];

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: 90.h,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/home-bg.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),

//         CurvedNavigationBar(
//           backgroundColor: Colors.transparent,
//           buttonBackgroundColor: AppTheme.primaryPink,
//           color: AppTheme.primaryPink.withValues(alpha: 0.1),

//           height: 90.h,
//           iconPadding: 20.sp,
//           index: currentIndex,
//           // maxWidth: 200,
//           items: isTrainer
//               ? (showTrainerExerciseTab
//                   ? trainerItemsWithExercise
//                   : _trainerItemsThreeTabs)
//               : clientItems,
//           onTap: (index) {
//             // Handle button tap
//             onIndexChanged?.call(index);
//           },
//         ),
//       ],
//     );
//   }
// }
