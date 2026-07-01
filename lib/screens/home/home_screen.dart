import 'package:aimim_mobile_app/screens/home/nav_menu_drawer.dart';
import 'package:aimim_mobile_app/screens/membership/membership_form_screen.dart';
import 'package:aimim_mobile_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 600.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/home-bg.png'),
              fit: BoxFit.cover,
            ),
            color: AppTheme.primaryGreen,
          ),
        ),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          drawer: NavMenuDrawer(),
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: SvgPicture.asset('assets/svg/mneu.svg', height: 30.sp),
              ),
            ),
            // leadingWidth: 40.sp,
            title: SvgPicture.asset('assets/svg/amim-logo.svg', height: 35.sp),
            centerTitle: false,
            actions: [
              SvgPicture.asset('assets/svg/ai-cht.svg'),
              SizedBox(width: 20.w),
            ],
          ),

          // drawer: const NavMenuDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Expanded(flex: 4, child: Container(color: Colors.transparent)),
                Container(
                  margin: EdgeInsets.only(top: 330.h),
                  padding: EdgeInsets.only(bottom: 500.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r),
                    ),
                    border: Border(
                      top: BorderSide(color: Colors.white, width: 1.5.sp),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          // horizontal: 15.w,
                          vertical: 5.h,
                        ),
                        child: Column(
                          children: [
                            Memberheader(),
                            UserHeaderBanner(),
                            AimimBanner(),
                            StatsSection(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  // mainAxisAlignment: .spaceBetween,
                  crossAxisAlignment: .start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          buildValueBox(
                            title: 'Family Members',
                            value: '123',
                            icon: 'assets/svg/Icon-add-user.svg',
                            isIconBtn: true,
                            btntext: 'Add',
                          ),
                          buildValueBox(
                            title: 'Feedback, Poll & Survey',
                            value: '07',
                            icon: 'assets/svg/thumbup.svg',
                            isIconBtn: true,
                            btntext: 'Add',
                          ),
                          buildValueBox(
                            title: 'Opportunities',
                            value: '100K',
                            icon: 'assets/svg/oppur.svg',
                            isIconBtn: false,
                            btntext: 'Apply',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        children: [
                          buildValueBox(
                            title: 'My Team (25)',
                            value: '3515',
                            icon: 'assets/svg/Icon-add-user.svg',
                            isIconBtn: false,
                            btntext: 'Link',
                            isFill: true,
                          ),
                          Container(
                            height: 185.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              image: DecorationImage(
                                image: AssetImage('assets/images/gift-1.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Row(
              mainAxisAlignment: .center,
              children: [
                Text(
                  'More',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: Colors.black),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            child: Image.asset('assets/images/stat-banner.png'),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.h, top: 5.h),
            child: Image.asset('assets/images/whats--app.png'),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.h, top: 5.h),
            child: Image.asset('assets/images/review.png'),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15.h, top: 15.h),
            child: Image.asset('assets/images/rating.png'),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15.h, top: 15.h),
            child: Image.asset('assets/images/footer.png'),
          ),
        ],
      ),
    );
  }

  Container buildValueBox({
    required String title,
    required String value,
    required String icon,
    required String btntext,
    required bool isIconBtn,
    bool isFill = false,
  }) {
    return Container(
      // width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.w),
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: isFill ? AppTheme.primaryGreen : Colors.white,
        border: Border.all(
          color: AppTheme.primaryGreen.withValues(alpha: 0.5),

          width: 1.sp,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: .start,

        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 14.sp,
              color: isFill ? Colors.white : AppTheme.primaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                value,
                style: GoogleFonts.roboto(
                  fontSize: 30.sp,
                  height: 0.8,
                  color: isFill ? Colors.white : AppTheme.primaryGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 0.w, bottom: 2.w),
                child: SvgPicture.asset(
                  icon,
                  height: 20.h,
                  color: isFill ? Colors.white : AppTheme.primaryGreen,
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: isFill ? Colors.white : AppTheme.primaryGreen,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                margin: EdgeInsets.only(left: 8.w),
                child: Row(
                  children: [
                    if (isIconBtn)
                      SvgPicture.asset('assets/svg/Icon-add-user.svg'),
                    Text(
                      btntext,
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        color: isFill ? AppTheme.primaryGreen : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Memberheader extends StatelessWidget {
  const Memberheader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quick Access',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/svg/thunmb-arrow.svg'),
                  SizedBox(width: 5.w),
                  Text(
                    'Learning Hub',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Bounceable(
          onTap: () {
            // Navigator.of(context).push(MembershipFormScreen())
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MembershipFormScreen()),
            );
          },
          child: SvgPicture.asset('assets/svg/apply-now.svg'),
        ),
      ],
    );
  }
}

class AimimBanner extends StatelessWidget {
  const AimimBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Container(
            height: 120.w,
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/svg/kite-clack.svg',
                  height: 70.w,
                  fit: BoxFit.cover,
                  color: Colors.white,
                ),
                Column(
                  children: [
                    Text(
                      'AIMIM',
                      style: GoogleFonts.rubikMoonrocks(
                        fontSize: 60.sp,
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'पतंग • KITE • پتنگ',
                      style: GoogleFonts.roboto(
                        fontSize: 20.sp,
                        color: Colors.white,
                        height: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  'assets/svg/kite-black-2.svg',
                  height: 70.w,
                  fit: BoxFit.cover,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserHeaderBanner extends StatelessWidget {
  const UserHeaderBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: Color.fromRGBO(30, 41, 59, 1),
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(color: Colors.white, width: 0.5.w),
            ),
            child: Row(
              children: [
                Container(
                  height: 34.sp,
                  width: 34.sp,
                  margin: EdgeInsets.only(right: 12.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5.w),
                    image: DecorationImage(
                      image: AssetImage('assets/images/user.jpg'),
                    ),
                  ),
                ),
                Text(
                  'A. H. A. KHAN',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(width: 5.w),
                Icon(Icons.verified, color: Colors.blue, size: 20.sp),
              ],
            ),
          ),
          Container(
            height: 42.h,
            width: 55.w,
            margin: EdgeInsets.symmetric(horizontal: 7.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Image.asset(
              'assets/images/discount-ezgif.com-gif-maker.png',
            ),
          ),
          Container(
            height: 42.h,
            width: 55.w,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: Color.fromRGBO(30, 41, 59, 1),
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(color: Colors.white, width: 0.5.sp),
            ),
            child: SvgPicture.asset('assets/svg/setting.svg'),
          ),
          Container(
            height: 42.h,
            width: 55.w,
            padding: EdgeInsets.all(5.w),
            margin: EdgeInsets.only(left: 7.w),
            decoration: BoxDecoration(
              color: Color.fromRGBO(30, 41, 59, 1),
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(color: Colors.white, width: 0.5.sp),
            ),
            child: SvgPicture.asset('assets/svg/share-1.svg'),
          ),
        ],
      ),
    );
  }
}
