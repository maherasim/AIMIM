import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import 'reel_single_screen.dart';
import 'reels_create_screen.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  static const _stories = [
    {
      'name': 'AIMIM',
      'verified': true,
      'image': 'assets/images/logo_round.png',
      'isAsset': true,
    },
    {
      'name': 'Asaduddin Owaisi',
      'verified': true,
      'image':
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150',
      'isAsset': false,
    },
    {
      'name': 'Imtiaz Jaleel',
      'verified': true,
      'image':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      'isAsset': false,
    },
    {
      'name': 'Dr. Shoaib Jamai',
      'verified': true,
      'image':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
      'isAsset': false,
    },
    {
      'name': 'Shaukat Ali',
      'verified': false,
      'image':
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
      'isAsset': false,
    },
  ];

  static const _reels = [
    {
      'author': 'PASHA JAMEER',
      'handle': '@pasha_jaam',
      'location': 'UP • Yesterday >',
      'title':
          'Title of this post here if available Title of this post... here if available',
      'videoUrl':
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=800',
    },
    {
      'author': 'Imtiaz Jaleel',
      'handle': '@imtiaz_jaleel',
      'location': 'Maharashtra • 2 days ago >',
      'title':
          'AIMIM Press Conference — Watch Full Coverage and Key Statements...',
      'videoUrl':
          'https://images.unsplash.com/photo-1475721027785-f74eccf877e2?w=800',
    },
    {
      'author': 'Dr. Shoaib',
      'handle': '@dr_shoaib',
      'location': 'Delhi • 3 days ago >',
      'title':
          'Community Development Updates and Action Points from Hyderabad Meeting...',
      'videoUrl':
          'https://images.unsplash.com/photo-1540910419892-4a36d2c3266c?w=800',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F4),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ReelsCreateScreen()),
        ),
        backgroundColor: kPrimaryGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        elevation: 0,
        leadingWidth: 56.w,
        leading: Center(
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ReelsCreateScreen()),
            ),
            child: SvgPicture.asset(
              'assets/svg/add-icon.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              // width: 24.w,
              // height: 24.h,
            ),
          ),
        ),
        title: GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'For you',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18.w),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white, size: 24.w),
            onPressed: () {},
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: ListView(
        children: [
          // Stories row
          Container(
            color: kPrimaryGreen,
            padding: EdgeInsets.fromLTRB(12.w, 0.h, 12.w, 12.h),
            child: SizedBox(
              height: 75.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _stories.length,
                itemBuilder: (context, i) {
                  final s = _stories[i];
                  return Container(
                    width: 78.w,
                    margin: EdgeInsets.only(right: 8.w),
                    child: Column(
                      children: [
                        Container(
                          width: 52.w,
                          height: 52.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: ClipOval(
                            child: s['isAsset'] == true
                                ? Image.asset(
                                    s['image'] as String,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    s['image'] as String,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                              color: Colors.white24,
                                              child: const Icon(
                                                Icons.person,
                                                color: Colors.white,
                                              ),
                                            ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                s['name'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (s['verified'] == true) ...[
                              SizedBox(width: 2.w),
                              Icon(
                                Icons.verified,
                                color: Colors.blue,
                                size: 10.w,
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // Reels list
          ..._reels.asMap().entries.map(
            (e) => _ReelCard(
              reel: e.value,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReelSingleScreen(reel: e.value),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReelCard extends StatefulWidget {
  final Map<String, String> reel;
  final VoidCallback onTap;
  const _ReelCard({required this.reel, required this.onTap});

  @override
  State<_ReelCard> createState() => _ReelCardState();
}

class _ReelCardState extends State<_ReelCard> {
  bool _muted = false;
  bool _liked = false;

  Widget _buildBottomStatItem(
    IconData icon,
    String label,
    VoidCallback onTap, {
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color ?? Colors.black87, size: 20.w),
          SizedBox(width: 4.w),
          Text(
            label,
            style: GoogleFonts.roboto(
              color: Colors.black87,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reel = widget.reel;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reels player container with stack overlays
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: Container(
                height: 380.h,
                width: double.infinity,
                color: Colors.grey.shade900,
                child: Stack(
                  children: [
                    // Video mock image
                    Positioned.fill(
                      child: Image.network(
                        reel['videoUrl']!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey.shade800,
                          child: const Icon(
                            Icons.play_circle_fill,
                            color: Colors.white54,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                    // Top gradient overlay for text readability
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 80.h,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.6),
                              Colors.transparent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    // Top Overlay: Author Details
                    Positioned(
                      top: 12.h,
                      left: 12.w,
                      right: 12.w,
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=150',
                              width: 36.w,
                              height: 36.w,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  CircleAvatar(
                                    radius: 18.w,
                                    backgroundColor: kPrimaryGreen,
                                    child: Text(
                                      reel['author']![0],
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      reel['author']!,
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Icon(
                                      Icons.verified,
                                      color: Colors.blue,
                                      size: 13.w,
                                    ),
                                    SizedBox(width: 4.w),
                                    Flexible(
                                      child: Text(
                                        reel['handle']!,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white70,
                                          fontSize: 11.sp,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  reel['location']!,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white70,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.2,
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                'Follow',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 20.w,
                          ),
                        ],
                      ),
                    ),
                    // Bottom Right Overlay: Speaker Icon
                    Positioned(
                      bottom: 12.h,
                      right: 12.w,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _muted = !_muted;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _muted ? Icons.volume_off : Icons.volume_up,
                            color: Colors.white,
                            size: 20.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Title block below the video
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 8.h),
              child: Text(
                reel['title']!,
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
            ),
            // Bottom stats row below the title
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBottomStatItem(
                    _liked ? Icons.favorite : Icons.favorite_border,
                    '100K',
                    () {
                      setState(() {
                        _liked = !_liked;
                      });
                    },
                    color: _liked ? Colors.red : Colors.black87,
                  ),
                  _buildBottomStatItem(Icons.chat_bubble_outline, '100K', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReelSingleScreen(reel: reel),
                      ),
                    );
                  }, color: Colors.black87),
                  _buildBottomStatItem(
                    Icons.repeat_rounded,
                    '100K',
                    () {},
                    color: Colors.black87,
                  ),
                  _buildBottomStatItem(
                    Icons.bar_chart,
                    '100K',
                    () {},
                    color: Colors.black87,
                  ),
                  GestureDetector(
                    onTap: () {
                      // share actions
                    },
                    child: Icon(
                      Icons.ios_share,
                      color: Colors.black87,
                      size: 20.w,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
