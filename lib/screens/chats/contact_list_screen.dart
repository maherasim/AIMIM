import 'package:aimim_mobile_app/theme/app_theme.dart';
import 'package:aimim_mobile_app/widgets/alert_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import 'chat_single_screen.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final _searchController = TextEditingController();
  bool _showAlert = true;

  static const _contacts = [
    {
      'name': 'A. H. A. KHAN',
      'handle': '@p_m_ajjukhan',
      'verified': true,
      'hasKite': true,
      'subtitle': 'Prime Member',
      'phone': '+91 9410081501',
      'image':
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150',
    },
    {
      'name': 'Team 1',
      'handle': '@username',
      'verified': true,
      'hasKite': false,
      'subtitle': 'Maharashtra State President',
      'phone': '+91 9410081501',
      'image':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
    },
    {
      'name': 'Imtiaz Jaleel',
      'handle': '@imtiaz_jaleel',
      'verified': true,
      'hasKite': true,
      'subtitle': 'Maharashtra State President',
      'phone': '+91 9410081501',
      'image':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
    },
    {
      'name': 'Imtiaz Jaleel',
      'handle': '@imtiaz_jaleel',
      'verified': true,
      'hasKite': true,
      'subtitle': 'Maharashtra State President',
      'phone': '+91 9410081501',
      'image':
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
    },
    {
      'name': 'Imtiaz Jaleel',
      'handle': '@imtiaz_jaleel',
      'verified': true,
      'hasKite': true,
      'subtitle': 'Maharashtra State President',
      'phone': '+91 9410081501',
      'image':
          'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=150',
    },
    {
      'name': 'Imtiaz Jaleel',
      'handle': '@imtiaz_jaleel',
      'verified': true,
      'hasKite': true,
      'subtitle': 'Maharashtra State President',
      'phone': '+91 9410081501',
      'image':
          'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=150',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildFilterPill({
    required String label,
    required String count,
    required bool isActive,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.25),
        border: isActive ? Border.all(color: Colors.white, width: 1.2) : null,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(width: 6.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: isActive ? Colors.blue : Colors.white24,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              count,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryGreen,
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        elevation: 0,
        // leadingWidth: 50.w,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_circle_left_outlined,
            color: Colors.white,
            size: 28.w,
          ),
        ),
        titleSpacing: 0,
        title: Container(
          height: 40.h,
          margin: EdgeInsets.only(right: 8.w),
          decoration: BoxDecoration(
            color: Color.fromRGBO(41, 42, 46, 0.8),
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(color: Colors.white24, width: 1.w),
          ),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              hintText: '| Search name',
              hintStyle: GoogleFonts.roboto(
                color: Colors.white38,
                fontSize: 13.sp,
              ),

              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                // vertical: 8.h,
              ),

              suffixIcon: Icon(Icons.tune, color: Colors.white54, size: 18.w),
            ),
          ),
        ),
        actions: [
          SvgPicture.asset('assets/svg/share-1.svg'),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white, size: 30.w),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Sub-appbar horizontal filter buttons
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterPill(label: 'All', count: '3560', isActive: true),
                  _buildFilterPill(
                    label: 'Registered',
                    count: '1200',
                    isActive: false,
                  ),
                  _buildFilterPill(
                    label: 'AIMIM',
                    count: '1560',
                    isActive: false,
                  ),
                ],
              ),
            ),
          ),

          // Orange Fraud Alert banner
          AlertBanner(),
          SizedBox(height: 30.h),

          // Contacts Header Row
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(height: 1, width: double.infinity, color: Colors.white),
              Positioned(
                bottom: -14.h,
                left: 10.w,
                child: buildContactheader(),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // Divider Line
          // Divider(color: Colors.white10, height: 1.h, thickness: 1.h),

          // Contacts List
          Expanded(
            child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, i) {
                final c = _contacts[i];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  leading: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 24.w,
                      backgroundImage: NetworkImage(c['image'] as String),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        c['name'] as String,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
                      ),
                      if (c['hasKite'] == true) ...[
                        SizedBox(width: 4.w),
                        Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: const BoxDecoration(),
                          child: Image.asset(
                            'assets/images/logo_round.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                      if (c['verified'] == true) ...[
                        SizedBox(width: 4.w),
                        Icon(Icons.verified, color: Colors.blue, size: 13.w),
                      ],
                      SizedBox(width: 6.w),
                      Flexible(
                        child: Text(
                          c['handle'] as String,
                          style: GoogleFonts.roboto(
                            color: Colors.white70,
                            fontSize: 11.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),
                      Text(
                        c['subtitle'] as String,
                        style: GoogleFonts.roboto(
                          color: Colors.white70,
                          fontSize: 11.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        c['phone'] as String,
                        style: GoogleFonts.roboto(
                          color: Colors.white60,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ChatSingleScreen(name: c['name'] as String),
                            ),
                          );
                        },
                        child: Text(
                          'Message',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // Circular WhatsApp Green Icon
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ChatSingleScreen(name: c['name'] as String),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: const BoxDecoration(
                            color: Color(0xFF25D366),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/whatsapp-1.svg',
                            width: 14.w,
                            height: 14.w,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildContactheader() {
    return Container(
      padding: EdgeInsets.only(left: 10.w, right: 3.w, top: 4.h, bottom: 4.h),
      // width: 150.w,
      decoration: BoxDecoration(
        color: Color.fromRGBO(13, 83, 55, 1),
        border: Border.all(color: Colors.white, width: 1.2),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Text(
            'All Contacts',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              '3560',
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
