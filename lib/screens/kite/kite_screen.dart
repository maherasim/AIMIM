import 'dart:io';
import 'package:aimim_mobile_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import 'kite_single_screen.dart';
import 'kite_create_screen.dart';

class KiteScreen extends StatefulWidget {
  const KiteScreen({super.key});

  @override
  State<KiteScreen> createState() => _KiteScreenState();
}

class _KiteScreenState extends State<KiteScreen> {
  final List<Map<String, dynamic>> _posts = [
    {
      'author': 'PASHA JAMEER',
      'handle': '@PashaJaam',
      'time': '1 week ago',
      'location': 'UP',
      'text':
          'This is the text and image based headline of news feed post with maximum of 160 words length.',
      'tags': '#160_World #NewPost @mention hyperlink added in this post',
      'images': 4,
      'imagePaths': <String>[
        'assets/images/p-1.jpg',
        'assets/images/p-2.jpg',
        'assets/images/p-3.jpg',
      ],
    },
    {
      'author': 'Imtiaz Jaleel',
      'handle': '@imtiaz_jaleel',
      'time': '2 days ago',
      'location': 'Maharashtra',
      'text':
          'AIMIM is committed to true democracy where every citizen matters, beyond identity and religion.',
      'tags': '#AIMIM #Democracy @AsaduddinOwaisi',
      'images': 1,
      'imagePaths': <String>['assets/images/p-3.jpg'],
    },
    {
      'author': 'Dr. Shoaib Jemai',
      'handle': '@dr_shoaib',
      'time': '3 days ago',
      'location': 'Delhi',
      'text':
          'Community development work ongoing in our constituency. Join us to make a difference.',
      'tags': '#Community #Development #Delhi',
      'images': 2,
      'imagePaths': <String>[],
    },
  ];

  Future<void> _openCreate() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const KiteCreateScreen()),
    );
    if (result != null && mounted) {
      setState(() => _posts.insert(0, result));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryGreen,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _openCreate,
      //   backgroundColor: kPrimaryGreen,
      //   child: const Icon(Icons.add, color: Colors.white),
      // ),
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        elevation: 0,
        leading: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SvgPicture.asset('assets/svg/add-icon.svg'),
        ),
        // leadingWidth: 20,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'For you',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 22.sp),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, i) => _KitePostCard(
          key: ValueKey(i),
          post: _posts[i],
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => KiteSingleScreen(post: _posts[i]),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Stateful post card with like / bookmark / follow toggles ──────────────────

class _KitePostCard extends StatefulWidget {
  final Map<String, dynamic> post;
  final VoidCallback onTap;
  const _KitePostCard({super.key, required this.post, required this.onTap});

  @override
  State<_KitePostCard> createState() => _KitePostCardState();
}

class _KitePostCardState extends State<_KitePostCard> {
  bool _liked = false;
  bool _bookmarked = false;
  bool _following = false;
  int _likeCount = 100;

  void _showShare() {
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
              SizedBox(height: 14.h),
              Text(
                'Share Post',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ShareIcon(
                    Icons.chat_rounded,
                    'WhatsApp',
                    const Color(0xFF25D366),
                  ),
                  _ShareIcon(Icons.send, 'Telegram', const Color(0xFF0088CC)),
                  _ShareIcon(
                    Icons.facebook,
                    'Facebook',
                    const Color(0xFF1877F2),
                  ),
                  _ShareIcon(Icons.link, 'Copy Link', Colors.grey),
                ],
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }

  void _showMore() {
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
              leading: const Icon(Icons.bookmark_add_outlined),
              title: Text(_bookmarked ? 'Remove bookmark' : 'Bookmark post'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _bookmarked = !_bookmarked);
              },
            ),
            ListTile(
              leading: const Icon(Icons.report_outlined, color: Colors.orange),
              title: const Text('Report post'),
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

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final imgCount = (post['images'] as int?) ?? 0;
    final imagePaths =
        (post['imagePaths'] as List?)?.cast<String>() ?? <String>[];
    final hasRealImages = imagePaths.isNotEmpty;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 2.h),
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author row
            Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: kPrimaryGreen,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/user.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        width: 2.w,
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              post['author'] as String,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(Icons.verified, color: Colors.blue, size: 13.sp),
                        ],
                      ),
                      Text(
                        '${post['location']} · ${post['time']}',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _following = !_following),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: _following
                          ? kPrimaryGreen.withAlpha(25)
                          : kPrimaryGreen,
                      border: Border.all(color: kPrimaryGreen),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      _following ? 'Following' : 'Follow',
                      style: TextStyle(
                        fontSize: 12,
                        color: _following ? kPrimaryGreen : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: _showMore,
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Post text
            Text(
              post['text'] as String,
              style: GoogleFonts.roboto(
                fontSize: 13.sp,
                height: 1.45,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Tags
            if ((post['tags'] as String?)?.isNotEmpty == true) ...[
              SizedBox(height: 6.h),
              Text(
                post['tags'] as String,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],

            const SizedBox(height: 10),

            // Images
            if (hasRealImages) ...[
              _buildRealImages(imagePaths),
              const SizedBox(height: 10),
            ] else if (imgCount > 0) ...[
              _buildPlaceholderImages(imgCount),
              const SizedBox(height: 10),
            ],

            // Action row
            Row(
              children: [
                // Like
                GestureDetector(
                  onTap: () => setState(() {
                    _liked = !_liked;
                    _likeCount += _liked ? 1 : -1;
                  }),
                  child: Row(
                    children: [
                      Icon(
                        _liked ? Icons.favorite : Icons.favorite_border,
                        size: 24.sp,
                        color: _liked ? Colors.red : Colors.black,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _liked ? '${_likeCount}K' : '100K',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: _liked ? Colors.red : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30.sp),

                // Comment (opens detail)
                GestureDetector(
                  onTap: widget.onTap,
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/comment.svg', height: 20.sp),
                      const SizedBox(width: 4),
                      Text(
                        '10K',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                // Repost
                SizedBox(width: 30.sp),
                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Reposted!'))),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/repost.svg', height: 20.sp),

                      const SizedBox(width: 4),
                      Text(
                        '1K',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30.sp),

                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Reposted!'))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset('assets/svg/insight.svg', height: 20.sp),

                      const SizedBox(width: 4),
                      Text(
                        '1K',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),

                // Bookmark
                // GestureDetector(
                //   onTap: () => setState(() => _bookmarked = !_bookmarked),
                //   child: Icon(
                //     _bookmarked ? Icons.bookmark : Icons.bookmark_border,
                //     size: 17,
                //     color: _bookmarked ? Colors.black : Colors.black,
                //   ),
                // ),
                const Spacer(),

                // Share
                GestureDetector(
                  onTap: _showShare,
                  child: SvgPicture.asset(
                    'assets/svg/share.svg',
                    width: 20.w,
                    height: 20.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRealImages(List<String> paths) {
    if (paths.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          paths[0],
          width: double.infinity,
          height: 180.h,
          fit: BoxFit.cover,
        ),
      );
    }
    return SizedBox(
      height: 180,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        children: paths
            .take(4)
            .map(
              (p) => ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Image.asset(p, fit: BoxFit.cover),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildPlaceholderImages(int count) {
    if (count == 1) {
      return Container(
        height: 180.h.h,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Icon(Icons.image_outlined, color: Colors.grey, size: 48),
        ),
      );
    }
    return SizedBox(
      height: 180,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        children: List.generate(
          count > 4 ? 4 : count,
          (_) => Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.image_outlined, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}

// ── Share icon helper ─────────────────────────────────────────────────────────

class _ShareIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _ShareIcon(this.icon, this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Sharing via $label...')));
      },
      child: Column(
        children: [
          Container(
            width: 52.w,
            height: 52.h,
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 26.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(fontSize: 11.sp, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
