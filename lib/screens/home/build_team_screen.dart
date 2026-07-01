import 'package:aimim_mobile_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../membership/membership_form_screen.dart';
import 'profile_screen.dart';

class BuildTeamScreen extends StatelessWidget {
  const BuildTeamScreen({super.key});

  static final _members = List<Map<String, String>>.generate(
    15,
    (i) => {
      'name': 'A. H. A. KHAN',
      'id': '001123456',
      'ac': 'AC 314 DHANGHATA',
      'district': 'SANT KABIR NAGAR',
      'state': 'UP',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.9),
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        elevation: 0,
        leadingWidth: 50.w,
        leading: Center(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(
              'assets/svg/arrow_back.svg',
              // width: 18.w,
              // height: 18.w,
              // color: Colors.white,
            ),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Build Your Team',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(width: 8.w),
            SvgPicture.asset(
              'assets/svg/amim-logo.svg',
              // width: 18.w,
              // height: 18.w,
              // color: Colors.white,
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          // WhatsApp Help Button
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFF00E676),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  Text(
                    'Help?',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  SvgPicture.asset(
                    'assets/svg/whatsapp-1.svg',
                    color: Colors.white,
                    height: 20.sp,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white, size: 22.w),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Row (Card 1: Dark Green, Card 2: White/Border)
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'My Team Members',
                    count: 399,
                    actionLabel: 'Invite Friends\nShare Link',
                    onAction: () {},
                    isDark: true,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _StatCard(
                    title: 'Onboard New Member',
                    count: 99,
                    actionLabel: 'ADD',
                    onAction: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MembershipFormScreen(),
                      ),
                    ),
                    isDark: false,
                    isAdd: true,
                  ),
                ),
              ],
            ),
          ),

          // Divider Line
          Divider(color: AppTheme.greyText, height: 1.h),

          // List Header Title
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 8.h),
            child: Row(
              children: [
                Text(
                  'My Team Member List (${_members.length + 484})',
                  style: GoogleFonts.roboto(
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),

          // Member List
          Expanded(
            child: ListView.builder(
              itemCount: _members.length,
              itemBuilder: (context, i) {
                final m = _members[i];
                return _MemberRow(
                  number: i + 1,
                  name: m['name']!,
                  id: m['id']!,
                  ac: m['ac']!,
                  district: m['district']!,
                  state: m['state']!,
                  highlighted: i == 0,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProfileScreen(
                        name: m['name']!,
                        heroTag: 'build_team_profile_${m['name']!}_$i',
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int count;
  final String actionLabel;
  final VoidCallback onAction;
  final bool isDark;
  final bool isAdd;

  const _StatCard({
    required this.title,
    required this.count,
    required this.actionLabel,
    required this.onAction,
    required this.isDark,
    this.isAdd = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? kPrimaryGreen : Colors.white;
    final textColor = isDark ? Colors.white : kPrimaryGreen;
    final infoColor = isDark ? Colors.white70 : Colors.black45;
    final buttonColor = isDark ? Colors.black : kPrimaryGreen;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: isDark ? null : Border.all(color: AppTheme.primaryGreen),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.roboto(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              Icon(Icons.info_outline, size: 14.w, color: infoColor),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$count',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  fontSize: 28.sp,
                  color: textColor,
                ),
              ),
              SizedBox(width: 4.w),
              Icon(Icons.group_outlined, color: infoColor, size: 20.w),
              const Spacer(),
              GestureDetector(
                onTap: onAction,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isAdd ? 12.w : 8.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: isAdd
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person_add_alt_1_outlined,
                              color: Colors.white,
                              size: 14.w,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'ADD',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          actionLabel,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MemberRow extends StatelessWidget {
  final int number;
  final String name, id, ac, district, state;
  final bool highlighted;
  final VoidCallback onTap;

  const _MemberRow({
    required this.number,
    required this.name,
    required this.id,
    required this.ac,
    required this.district,
    required this.state,
    required this.highlighted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final rowBgColor = highlighted
        ? const Color(0xFFD0F8E8)
        : Colors.white.withValues(alpha: 0.9);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: rowBgColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppTheme.primaryGreen),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 28.w,
              child: Text(
                '$number',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: kDarkGreen,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                          color: kDarkGreen,
                        ),
                      ),
                      Text(
                        ' • ',
                        style: GoogleFonts.roboto(
                          color: kDarkGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        id,
                        style: GoogleFonts.roboto(
                          fontSize: 13.sp,
                          color: kDarkGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.h),
                  Text(
                    '$ac • $district • $state',
                    style: GoogleFonts.roboto(
                      fontSize: 10.sp,
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kPrimaryGreen, width: 1.2),
              ),
              child: Center(
                child: Icon(
                  Icons.chevron_right,
                  color: kPrimaryGreen,
                  size: 14.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
