import 'dart:ui';

import 'package:aimim_mobile_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import 'home/home_screen.dart';
import 'reels/reels_screen.dart';
import 'kite/kite_screen.dart';
import 'dashboard/dashboard_screen.dart';
import 'chats/chats_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          ReelsScreen(),
          KiteScreen(),
          DashboardScreen(),
          ChatsScreen(),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 90.h,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bb-shadow.png'),
                fit: BoxFit.cover,
              ),
              // color: AppTheme.primaryGreen.withOpacity(0.8),
            ),
          ),
          ClipRRect(
            // borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                height: 90.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                decoration: BoxDecoration(
                  // color: AppTheme.white.withOpacity(0.2),
                  // image: DecorationImage(
                  //   image: AssetImage('assets/images/bb-shadow.png'),
                  //   fit: BoxFit.cover,
                  // ),
                  // color: AppTheme.w,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.transparent,
                  //     blurRadius: 0,
                  //     offset: Offset(0, 10),
                  //   ),
                  // ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildNavbarItem(
                      isActive: _currentIndex == 0,
                      onTap: () => setState(() => _currentIndex = 0),
                      iconPath: 'assets/svg/home.svg',
                      text: 'Home',
                    ),
                    buildNavbarItem(
                      isActive: _currentIndex == 1,
                      onTap: () => setState(() => _currentIndex = 1),
                      iconPath: 'assets/svg/reels.svg',
                      text: 'Reels',
                    ),
                    buildNavbarItem(
                      isActive: _currentIndex == 2,
                      onTap: () => setState(() => _currentIndex = 2),
                      iconPath: 'assets/svg/kite-2.svg',
                      text: 'Kite',
                    ),
                    buildNavbarItem(
                      isActive: _currentIndex == 3,
                      onTap: () => setState(() => _currentIndex = 3),
                      iconPath: 'assets/svg/dash.svg',
                      text: 'Dashboard',
                    ),
                    buildNavbarItem(
                      isActive: _currentIndex == 4,
                      onTap: () => setState(() => _currentIndex = 4),
                      iconPath: 'assets/svg/chat.svg',
                      text: 'Chats',
                    ),
                  ],
                ),

                //  BottomNavigationBar(
                //   currentIndex: _currentIndex,
                //   onTap: (i) => setState(() => _currentIndex = i),
                //   type: BottomNavigationBarType.fixed,
                //   selectedItemColor: kPrimaryGreen,
                //   unselectedItemColor: Colors.grey,
                //   selectedLabelStyle: const TextStyle(
                //     fontWeight: FontWeight.w600,
                //     fontSize: 11,
                //   ),
                //   unselectedLabelStyle: const TextStyle(fontSize: 11),
                //   backgroundColor: Colors.transparent,
                //   elevation: 0,
                //   items: [
                //     BottomNavigationBarItem(
                //       icon: SvgPicture.asset('assets/svg/home.svg', height: 28),
                //       activeIcon: Icon(Icons.home),
                //       label: 'Home',
                //     ),
                //     BottomNavigationBarItem(
                //       icon: Icon(Icons.play_circle_outline),
                //       activeIcon: Icon(Icons.play_circle),
                //       label: 'Reels',
                //     ),
                //     BottomNavigationBarItem(
                //       icon: Icon(Icons.filter_frames_outlined),
                //       activeIcon: Icon(Icons.filter_frames),
                //       label: 'Kite',
                //     ),
                //     BottomNavigationBarItem(
                //       icon: Icon(Icons.dashboard_outlined),
                //       activeIcon: Icon(Icons.dashboard),
                //       label: 'Dash',
                //     ),
                //     BottomNavigationBarItem(
                //       icon: Icon(Icons.chat_bubble_outline),
                //       activeIcon: Icon(Icons.chat_bubble),
                //       label: 'Chats',
                //     ),
                //   ],
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavbarItem({
    bool isActive = false,
    required String iconPath,
    int index = 0,
    required String text,
    Function()? onTap,
  }) {
    return Bounceable(
      duration: const Duration(milliseconds: 300),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.white : Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 28.h,
              color: isActive ? Colors.black : Colors.white,
            ),
            // SizedBox(height: 4.h),
            if (isActive)
              Text(
                text,
                style: GoogleFonts.roboto(
                  fontSize: 12.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
