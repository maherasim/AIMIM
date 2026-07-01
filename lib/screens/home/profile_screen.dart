import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../chats/chat_single_screen.dart';
import '../membership/membership_success_screen.dart';

// Brand-specific custom SVG path data for high-fidelity social chips
const String _xIconSvg = '''
<svg viewBox="0 0 24 24" fill="white">
  <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
</svg>
''';

const String _whatsappIconSvg = '''
<svg viewBox="0 0 24 24" fill="white">
  <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L0 24l6.335-1.662c1.746.953 3.71 1.455 5.703 1.457h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
</svg>
''';

const String _messengerIconSvg = '''
<svg viewBox="0 0 24 24" fill="white">
  <path d="M12 2C6.477 2 2 6.145 2 11.258c0 2.914 1.447 5.517 3.7 7.217.194.146.31.376.312.622l.024 1.892c.004.382.426.634.773.473l2.128-.988a.86.86 0 01.65-.034c.767.234 1.579.362 2.413.362 5.523 0 10-4.145 10-9.258C22 6.145 17.523 2 12 2zm1.096 11.758l-2.585-2.756-5.044 2.756 5.544-5.892 2.585 2.756 5.044-2.756-5.544 5.892z"/>
</svg>
''';

const String _telegramIconSvg = '''
<svg viewBox="0 0 24 24" fill="white">
  <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm4.64 6.8c-.15 1.58-.8 5.42-1.13 7.19-.14.75-.42 1-.68 1.03-.58.05-1.02-.38-1.58-.75-.88-.58-1.38-.94-2.23-1.5-1-.65-.35-1 .22-1.59.15-.15 2.71-2.48 2.76-2.69.01-.03.01-.14-.07-.2-.08-.06-.19-.04-.27-.02-.12.02-1.96 1.25-5.54 3.66-.52.36-1 .53-1.42.52-.47-.01-1.37-.27-2.03-.49-.82-.27-1.47-.41-1.42-.87.03-.24.37-.49 1.02-.75 4-1.74 6.67-2.88 8-3.42 3.81-1.54 4.6-1.8 5.12-1.81.11 0 .37.03.54.17.14.12.18.28.2.4l.02.2z"/>
</svg>
''';

const String _instagramIconSvg = '''
<svg viewBox="0 0 24 24" fill="white">
  <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zM12 0C8.741 0 8.333.014 7.053.072 2.695.272.273 2.69.073 7.051.014 8.333 0 8.741 0 12c0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98C15.668.014 15.259 0 12 0zm0 5.838a6.162 6.162 0 100 12.324 6.162 6.162 0 000-12.324zM12 16a4 4 0 110-8 4 4 0 010 8zm6.406-11.845a1.44 1.44 0 100 2.881 1.44 1.44 0 000-2.881z"/>
</svg>
''';

const String _facebookIconSvg = '''
<svg viewBox="0 0 24 24" fill="white">
  <path d="M22 12c0-5.52-4.48-10-10-10S2 6.48 2 12c0 4.84 3.44 8.87 8 9.8V15H8v-3h2V9.5C10 7.57 11.57 6 13.5 6H16v3h-2c-.55 0-1 .45-1 1v2h3v3h-3v6.95c4.56-.93 8-4.96 8-9.75z"/>
</svg>
''';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String heroTag;
  const ProfileScreen({super.key, required this.name, required this.heroTag});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _following = false;

  void _showShare(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Share Profile',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareOpt(
                    context,
                    Icons.chat_rounded,
                    'WhatsApp',
                    const Color(0xFF25D366),
                  ),
                  _buildShareOpt(
                    context,
                    Icons.send,
                    'Telegram',
                    const Color(0xFF0088CC),
                  ),
                  _buildShareOpt(
                    context,
                    Icons.facebook,
                    'Facebook',
                    const Color(0xFF1877F2),
                  ),
                  _buildShareOpt(context, Icons.link, 'Copy Link', Colors.grey),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShareOpt(
    BuildContext ctx,
    IconData icon,
    String label,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(ctx);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Sharing via $label...')));
      },
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  void _showMore(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.block),
              title: const Text('Block'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('User blocked')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.report_outlined),
              title: const Text('Report'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Report submitted')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('Cancel'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('Notifications'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text('Privacy'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.language_outlined),
              title: const Text('Language'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/login', (_) => false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon({
    String? svgString,
    String? assetPath,
    Color? backgroundColor,
    List<Color>? gradientColors,
    bool isAsset = false,
  }) {
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        gradient: gradientColors != null
            ? LinearGradient(
                colors: gradientColors,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              )
            : null,
      ),
      child: Center(
        child: SizedBox(
          width: 18.w,
          height: 18.w,
          child: isAsset
              ? SvgPicture.asset(assetPath!)
              : SvgPicture.string(svgString!),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 35.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: Colors.black,

              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconActionButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 35.w,
        height: 35.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, color: Colors.black, size: 18.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.name;
    return Scaffold(
      backgroundColor: kPrimaryGreen,
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        elevation: 0,
        // leadingWidth: 160.w,
        leading: Row(
          children: [
            SizedBox(width: 16.w),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset('assets/svg/arrow_back.svg'),
            ),
          ],
        ),

        title: Row(
          mainAxisAlignment: .start,
          children: [
            Text(
              '@p_m_ajjukhan',
              style: GoogleFonts.roboto(
                color: const Color.fromRGBO(0, 255, 83, 1),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 3.w),

            Icon(
              Icons.keyboard_arrow_down,
              color: const Color.fromRGBO(0, 255, 83, 1),
              size: 16.w,
            ),
            SizedBox(width: 15.w),

            SvgPicture.asset('assets/svg/amim-logo.svg'),
          ],
        ),
        // centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () => _showShare(context),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SvgPicture.asset(
                'assets/svg/share-1.svg',
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                width: 24.w,
                height: 24.w,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white, size: 28.sp),
            onPressed: () => _showMore(context),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Info Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Instagram-style avatar with gradient border
                          Container(
                            padding: EdgeInsets.all(3.w),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFf99f1b),
                                  Color(0xFFe1306c),
                                  Color(0xFFc13584),
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: const BoxDecoration(
                                color: kPrimaryGreen,
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                radius: 32.w,
                                backgroundImage: const AssetImage(
                                  'assets/images/user.jpg',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'A. H. A. KHAN',
                                                style: GoogleFonts.roboto(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                ),
                                              ),
                                              SizedBox(width: 6.w),
                                              Container(
                                                width: 18.w,
                                                height: 18.w,
                                                padding: EdgeInsets.all(2.w),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFF0E6E44,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        4.w,
                                                      ),
                                                ),
                                                child: SvgPicture.asset(
                                                  'assets/svg/kite.svg',
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                        Colors.white,
                                                        BlendMode.srcIn,
                                                      ),
                                                ),
                                              ),
                                              SizedBox(width: 4.w),
                                              Icon(
                                                Icons.verified,
                                                color: Colors.blue,
                                                size: 18.w,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'AZHAR HUSAIN AJJU KHAN',
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.notifications_none,
                                      color: Colors.white,
                                      size: 26.w,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Member ID: 786786786',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      // Bio Description
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                          height: 1.35,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      // Overlapping follows & text
                      Row(
                        children: [
                          SizedBox(
                            width: 46.w,
                            height: 20.w,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 9.w,
                                      backgroundImage: const AssetImage(
                                        'assets/images/p-1.jpg',
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 10.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.5.w,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 9.w,
                                      backgroundImage: const AssetImage(
                                        'assets/images/p-2.jpg',
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 20.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 9.w,
                                      backgroundImage: const AssetImage(
                                        'assets/images/p-3.jpg',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              'Followed by juliantara.uix, juliantara and 100 others',
                              style: GoogleFonts.roboto(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      // Social Chips
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSocialIcon(
                            svgString: _xIconSvg,
                            backgroundColor: Colors.black,
                          ),
                          _buildSocialIcon(
                            svgString: _whatsappIconSvg,
                            backgroundColor: const Color(0xFF25D366),
                          ),
                          _buildSocialIcon(
                            svgString: _messengerIconSvg,
                            backgroundColor: const Color(0xFF3B5998),
                          ),
                          _buildSocialIcon(
                            svgString: _telegramIconSvg,
                            backgroundColor: const Color(0xFF229ED9),
                          ),
                          _buildSocialIcon(
                            svgString: _instagramIconSvg,
                            gradientColors: [
                              const Color(0xFFf99f1b),
                              const Color(0xFFe1306c),
                              const Color(0xFFc13584),
                            ],
                          ),
                          _buildSocialIcon(
                            svgString: _facebookIconSvg,
                            backgroundColor: const Color(0xFF1877F2),
                          ),
                          _buildSocialIcon(
                            assetPath: 'assets/svg/google-1.svg',
                            backgroundColor: Colors.white,
                            isAsset: true,
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      // Action buttons
                      Row(
                        children: [
                          _buildActionButton('Member Card', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MembershipSuccessScreen(
                                  name: name,
                                  enrollmentNo: 'MEM-786786',
                                  state: 'Maharashtra',
                                  district: 'Mumbai',
                                  assembly: 'Aurangabad',
                                  membershipType: 'Active',
                                ),
                              ),
                            );
                          }),
                          SizedBox(width: 8.w),
                          _buildActionButton('Message', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatSingleScreen(name: name),
                              ),
                            );
                          }),
                          SizedBox(width: 8.w),
                          _buildActionButton('Settings', () {
                            _showSettings(context);
                          }),
                          SizedBox(width: 8.w),
                          _buildIconActionButton(
                            _following
                                ? Icons.person_remove_outlined
                                : Icons.person_add_alt_1_outlined,
                            () {
                              setState(() {
                                _following = !_following;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    _following
                                        ? 'Following A. H. A. Khan'
                                        : 'Unfollowed A. H. A. Khan',
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      // User Stories
                      SizedBox(
                        height: 56.w,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (context, i) {
                            final faceUrls = [
                              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
                              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
                              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
                              'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=150',
                              'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150',
                              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150',
                            ];
                            return Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: Container(
                                width: 52.w,
                                height: 52.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color.fromRGBO(154, 164, 178, 1),
                                    width: 3.sp,
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(faceUrls[i]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // child: ClipOval(
                                //   child: Image.network(
                                //     faceUrls[i],
                                //     fit: BoxFit.cover,
                                //     errorBuilder: (context, error, stackTrace) {
                                //       return Container(
                                //         color: Colors.white.withValues(
                                //           alpha: 0.2,
                                //         ),
                                //         child: const Icon(
                                //           Icons.person,
                                //           color: Colors.white,
                                //         ),
                                //       );
                                //     },
                                //   ),
                                // ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _TabBarHeaderDelegate(
                  tabBar: TabBar(
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 3,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white.withValues(alpha: 0.5),
                    tabs: [
                      SvgPicture.asset(
                        'assets/svg/dash-board-1.svg',
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        width: 30.w,
                        height: 30.h,
                      ),
                      SvgPicture.asset(
                        'assets/svg/menu-1.svg',
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        width: 20.w,
                        height: 20.h,
                      ),
                      Tab(
                        icon: SvgPicture.asset(
                          'assets/svg/reels.svg',
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          width: 25.w,
                          height: 25.h,
                        ),
                      ),
                      Tab(
                        icon: SvgPicture.asset(
                          'assets/svg/person-1.svg',
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          width: 25.w,
                          height: 25.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Container(
            color: kPrimaryGreen,
            child: TabBarView(
              children: [
                _PostGrid(),
                const Center(
                  child: Text(
                    'List View',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const Center(
                  child: Text(
                    'Reels',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const Center(
                  child: Text(
                    'Tagged',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  _TabBarHeaderDelegate({required this.tabBar});

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: kPrimaryGreen, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant _TabBarHeaderDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}

class _PostGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postImages = [
      'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?w=500&q=80',
      'https://images.unsplash.com/photo-1639762681485-074b7f938ba0?w=500&q=80',
      'https://images.unsplash.com/photo-1518770660439-4636190af475?w=500&q=80',
      'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=500&q=80',
      'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=500&q=80',
      'https://images.unsplash.com/photo-1544256718-3bcf237f3974?w=500&q=80',
      'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=500&q=80',
      'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=500&q=80',
      'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=500&q=80',
    ];

    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: 9,
      itemBuilder: (context, i) => Image.network(
        postImages[i],
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.white.withValues(alpha: 0.05),
            child: const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.white.withValues(alpha: 0.1),
          child: const Icon(Icons.image_outlined, color: Colors.white54),
        ),
      ),
    );
  }
}
