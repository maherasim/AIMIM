import 'package:aimim_mobile_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../widgets/alert_banner.dart';
import 'profile_screen.dart';
import '../awards/awards_screen.dart';
import '../chats/chats_screen.dart';
import '../webmode/web_mode_screen.dart';

class NavMenuDrawer extends StatefulWidget {
  const NavMenuDrawer({super.key});

  @override
  State<NavMenuDrawer> createState() => _NavMenuDrawerState();
}

class _NavMenuDrawerState extends State<NavMenuDrawer> {
  bool _prefsExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.primaryGreen,
      width: 300.w,
      child: Column(
        children: [
          // â”€â”€ User profile header â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Container(
            margin: EdgeInsets.only(top: 45.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/svg/Logo.svg', height: 70.sp),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.cancel_outlined,
                    size: 40.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentGeometry.center,
            children: [
              Container(
                width: 300.w,
                height: 2.h,
                decoration: BoxDecoration(color: Colors.white),
              ),
              Positioned(
                top: -13.h,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppTheme.primaryGreen,
                  ),
                  child: Text(
                    'NATIONAL MEMBERSHIP PLATFORM',
                    style: GoogleFonts.rubikMoonrocks(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
                  // padding: EdgeInsets.all(5.sp),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(15.r),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      buildUserinfo(),
                      // SizedBox(height: 5.h),
                      buildAlert(),
                      SizedBox(height: 5.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.red,
                              size: 20.sp,
                            ),
                            Text(
                              '580 Lucknow, Uttar Pradesh, 272165',
                              style: GoogleFonts.roboto(
                                color: Colors.red,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 80.w,
                              // height: 40.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 3.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                    size: 20.w,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    'Update',
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildAlert() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: Color.fromRGBO(230, 131, 64, 1),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Text(
              'Alert',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(width: 5.w),
          Text(
            'Beware of fraud, AIMIM never ask OTP, \nPasscode, or any kind of payments ETC.',
            style: GoogleFonts.roboto(
              fontSize: 11.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Container buildUserinfo() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(13, 83, 55, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/user.jpg'),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 5.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'PASHA JAMEER',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Icon(Icons.verified, color: Colors.blue, size: 20.sp),
                  ],
                ),
                Text(
                  'New User • Joined May 2025 >',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
                Text(
                  'Last login 26 November 2025',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
            SizedBox(width: 18.w),
            Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20.sp),
          ],
        ),
      ),
    );
  }
}

class _PrefRow extends StatelessWidget {
  final String label;
  final String value;
  const _PrefRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(56, 4, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: kPrimaryGreen,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(value, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: kPrimaryGreen,
              side: const BorderSide(color: kPrimaryGreen),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Edit', style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback onTap;
  const _DrawerItem({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kPrimaryGreen, size: 20),
      title: Text(
        title,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
      trailing: trailing != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  trailing!,
                  style: const TextStyle(
                    color: kPrimaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            )
          : const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      dense: true,
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _SocialIcon(this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 18),
    );
  }
}
