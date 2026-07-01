import 'package:aimim_mobile_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_screen.dart';

class NavMenuDrawer extends StatefulWidget {
  const NavMenuDrawer({super.key});

  @override
  State<NavMenuDrawer> createState() => _NavMenuDrawerState();
}

class _NavMenuDrawerState extends State<NavMenuDrawer> {
  final Map<String, ExpansionTileController> _controllers = {};

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.primaryGreen,
      width: 350.w,
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
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    size: 40.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentGeometry.center,
            children: [
              Container(
                width: 350.w,
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
          SizedBox(height: 15.h),
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
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
                      // SizedBox(height: 5.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 8.h,
                        ),
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
                      Divider(color: AppTheme.primaryGreen),
                      buildDrawerTile(
                        title: 'Account Preferences',
                        icon: 'assets/svg/user-round.svg',
                        isExpanded: true,
                        children: [
                          buildDataColumn(
                            title: 'Current Residency: ',
                            value: 'Mumbai, Maharashtra',
                          ),
                          buildDataColumn(
                            title: 'Voting Location: ',
                            value: 'Noida, Uttar Pradesh',
                          ),
                          buildDataColumn(
                            title: 'Phone Number: ',
                            value: '+91 9876543210',
                          ),
                        ],
                      ),

                      // buildDrawerTile(
                      //   title: 'My Contacts (1200)',
                      //   icon: 'assets/svg/contact.svg',
                      // ),
                      buildDrawerTile(
                        title: 'Support Center',
                        icon: 'assets/svg/support.svg',
                        children: [
                          buildDataColumn(
                            title: 'Helpline Number: ',
                            value: '1800-11-2233',
                            showEdit: false,
                          ),
                          buildDataColumn(
                            title: 'Email: ',
                            value: 'support@aimim.org',
                            showEdit: false,
                          ),
                        ],
                      ),
                      buildDrawerTile(
                        title: 'Advanced Setting',
                        icon: 'assets/svg/advance-settings.svg',
                        isAdvanceSetting: true,
                        children: [
                          buildDataColumn(
                            title: 'Privacy Settings',
                            value: 'Manage your data and privacy',
                            showEdit: true,
                            isAdvanceSetting: true,
                          ),
                          buildDataColumn(
                            title: 'Security Settings',
                            value: 'Password, 2FA, and alerts',
                            showEdit: true,
                            isAdvanceSetting: true,
                          ),
                          buildDataColumn(
                            title: 'Notification Settings',
                            value: 'Push, email, and SMS alerts',
                            showEdit: true,
                            isAdvanceSetting: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60.h,
                  margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                  child: Image.asset('assets/images/cat-whatsaopop.png'),
                ),
                Text(
                  'Managed by: Third Party',
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox.shrink(),
                // Spacer(),
                Image.asset('assets/images/ooter-1.png'),
                Expanded(
                  child: Container(width: double.infinity, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerTile({
    required String title,
    required String icon,
    bool isExpanded = false,
    bool isAdvanceSetting = false,
    List<Widget>? children,
  }) {
    final controller = _controllers.putIfAbsent(
      title,
      () => ExpansionTileController(),
    );

    return Container(
      decoration: BoxDecoration(
        color: isAdvanceSetting ? Colors.black : Colors.transparent,
        border: Border(bottom: BorderSide(color: AppTheme.primaryGreen)),
        borderRadius: isAdvanceSetting
            ? BorderRadius.only(
                bottomLeft: Radius.circular(15.r),
                bottomRight: Radius.circular(15.r),
              )
            : BorderRadius.circular(0),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: ExpansionTile(
          controller: controller,
          onExpansionChanged: (expanded) {
            if (expanded) {
              for (final key in _controllers.keys) {
                if (key != title) {
                  _controllers[key]?.collapse();
                }
              }
            }
          },
          tilePadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
          leading: SvgPicture.asset(
            icon,
            color: isAdvanceSetting ? Colors.white : AppTheme.primaryGreen,
          ),
          visualDensity: VisualDensity.compact,
          initiallyExpanded: isExpanded,

          iconColor: isAdvanceSetting ? Colors.white : AppTheme.primaryGreen,
          title: Text(
            title,
            style: GoogleFonts.roboto(
              color: isAdvanceSetting ? Colors.white : AppTheme.primaryGreen,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.bottomLeft,
          childrenPadding: EdgeInsets.symmetric(horizontal: 15.w),
          children: children ?? [],
        ),
      ),
    );
  }

  Widget buildDataColumn({
    required String title,
    required String value,
    bool showEdit = true,
    bool isAdvanceSetting = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.roboto(
                  color: isAdvanceSetting ? Colors.white70 : Colors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (showEdit)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  margin: EdgeInsets.only(left: 2.w),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    'Edit',
                    style: GoogleFonts.roboto(
                      color: Colors.red,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 3.h),
          Text(
            value,
            style: GoogleFonts.roboto(
              color: isAdvanceSetting ? Colors.white : AppTheme.primaryGreen,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
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

  Widget buildUserinfo() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(13, 83, 55, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ProfileScreen(
                name: 'PASHA JAMEER',
                heroTag: 'nav_drawer_profile_pasha_jameer',
              ),
            ),
          );
        },
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
      ),
    );
  }
}
