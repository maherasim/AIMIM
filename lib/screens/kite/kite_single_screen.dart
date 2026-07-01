import 'package:aimim_mobile_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';

class KiteSingleScreen extends StatefulWidget {
  final Map<String, dynamic> post;
  const KiteSingleScreen({super.key, required this.post});

  @override
  State<KiteSingleScreen> createState() => _KiteSingleScreenState();
}

class _KiteSingleScreenState extends State<KiteSingleScreen> {
  bool _liked = false;
  bool _bookmarked = false;
  bool _following = false;

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
              const SizedBox(height: 14),
              const Text(
                'Share Post',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareOption(
                    Icons.chat_rounded,
                    'WhatsApp',
                    const Color(0xFF25D366),
                  ),
                  _buildShareOption(
                    Icons.send,
                    'Telegram',
                    const Color(0xFF0088CC),
                  ),
                  _buildShareOption(
                    Icons.facebook,
                    'Facebook',
                    const Color(0xFF1877F2),
                  ),
                  _buildShareOption(Icons.link, 'Copy Link', Colors.grey),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _showReplyBottomSheet(String replyToUser) {
    final replySheetController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
            color: kDarkGreen,
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Replying to @$replyToUser',
                      style: GoogleFonts.roboto(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(sheetContext),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white70,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: replySheetController,
                        autofocus: true,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 13.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Replay your comment',
                          hintStyle: GoogleFonts.roboto(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 13.sp,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white54,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.5,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: () {
                        if (replySheetController.text.trim().isNotEmpty) {
                          Navigator.pop(sheetContext);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Reply posted!')),
                          );
                        }
                      },
                      child: Icon(
                        Icons.image,
                        color: const Color(0xFF25D366),
                        size: 24.w,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) => replySheetController.dispose());
  }

  Widget _buildShareOption(IconData icon, String label, Color color) {
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

  Widget _buildThumbnail(String url) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.r),
        child: Image.network(
          url,
          height: 100.h,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 52.h,
            color: Colors.grey.shade300,
            child: const Icon(Icons.image_outlined, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Row(
      children: [
        Text(
          count,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
            color: Colors.black,
          ),
        ),
        Text(
          ' • $label',
          style: GoogleFonts.roboto(
            color: Colors.grey.shade700,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final author = post['author'] as String? ?? 'PASHA JAMEER';
    final location = post['location'] as String? ?? 'UP';
    final time = post['time'] as String? ?? '1 week ago';
    final text =
        post['text'] as String? ??
        'This is the text and image based headline of news feed post with maximum of 160 words length.';
    final tags =
        post['tags'] as String? ??
        '#160_World # New Post\n@menthion\nhyperlink added in this post';

    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.9),
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        elevation: 0,
        leadingWidth: 160.w,
        leading: Row(
          children: [
            SizedBox(width: 16.w),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 16.w),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              'Post',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18.w),
          ],
        ),
        title: Container(
          width: 32.w,
          height: 32.w,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(5.w),
            child: SvgPicture.asset(
              'assets/svg/kite.svg',
              colorFilter: const ColorFilter.mode(
                kPrimaryGreen,
                BlendMode.srcIn,
              ),
            ),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author row
                  Row(
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.primaryGreen,
                            width: 1.5,
                          ),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=150',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // ClipOval(
                      //   child: Image.network(
                      //     'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=150',
                      //     width: 44.w,
                      //     height: 44.w,
                      //     fit: BoxFit.cover,
                      //     errorBuilder: (context, error, stackTrace) =>
                      //         CircleAvatar(
                      //           radius: 22.w,
                      //           backgroundColor: kPrimaryGreen,
                      //           child: Text(
                      //             author[0],
                      //             style: const TextStyle(
                      //               color: Colors.white,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 18,
                      //             ),
                      //           ),
                      //         ),
                      //   ),
                      // ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  author,
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.verified,
                                  color: Colors.blue,
                                  size: 14.w,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  '@PashaJaam',
                                  style: GoogleFonts.roboto(
                                    color: Colors.grey.shade600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '$location • $time',
                              style: GoogleFonts.roboto(
                                color: Colors.grey.shade600,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _following = !_following),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: _following
                                ? Colors.grey.shade400
                                : kPrimaryGreen,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            _following ? 'Following' : 'Follow',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.more_vert, color: Colors.black, size: 20.w),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Post text
                  Text(
                    text,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      height: 1.35,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    tags,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 13.sp,
                      height: 1.35,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Main image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1545241047-6083a3684587?w=800',
                      height: 250.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 180.h,
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.grey,
                            size: 56,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  // Thumbnail strip (4 images)
                  Row(
                    children: [
                      _buildThumbnail(
                        'https://images.unsplash.com/photo-1528183429752-a97d0bf99b5a?w=300',
                      ),
                      SizedBox(width: 6.w),
                      _buildThumbnail(
                        'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=300',
                      ),
                      SizedBox(width: 6.w),
                      _buildThumbnail(
                        'https://images.unsplash.com/photo-1448375240586-882707db888b?w=300',
                      ),
                      SizedBox(width: 6.w),
                      _buildThumbnail(
                        'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=300',
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Time & Date metadata
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '10:28 pm',
                          style: GoogleFonts.roboto(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '17 Feb 26',
                          style: GoogleFonts.roboto(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '@p_m_ajjukhan',
                          style: GoogleFonts.roboto(
                            color: kPrimaryGreen,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey.shade300, height: 12.h),
                  // Stats row 1
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatItem('100K', 'Likes'),
                        _buildStatItem('100K', 'Repost'),
                        _buildStatItem('100K', 'View'),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey.shade300, height: 12.h),
                  // Stats row 2
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => _showReplyBottomSheet(
                            author.toLowerCase().replaceAll(' ', '_'),
                          ),
                          child: _buildStatItem('100K', 'Comments'),
                        ),
                        _buildStatItem('100K', 'Share'),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey.shade300, height: 12.h),
                  // Actions row
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _liked = !_liked),
                          child: Icon(
                            _liked ? Icons.favorite : Icons.favorite_border,
                            color: _liked ? Colors.red : Colors.black87,
                            size: 24.w,
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Reposted!')),
                              ),
                          child: Icon(
                            Icons.repeat_rounded,
                            color: Colors.black87,
                            size: 24.w,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.bar_chart,
                            color: Colors.black87,
                            size: 24.w,
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              setState(() => _bookmarked = !_bookmarked),
                          child: Icon(
                            _bookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: _bookmarked ? kPrimaryGreen : Colors.black87,
                            size: 24.w,
                          ),
                        ),
                        GestureDetector(
                          onTap: _showShare,
                          child: Icon(
                            Icons.ios_share,
                            color: Colors.black87,
                            size: 24.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey.shade300, height: 12.h),
                  // Sort replies dropdown trigger
                  Row(
                    children: [
                      Text(
                        'Most relevant replies',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 18.w,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Sample replies list
                  ...List.generate(
                    3,
                    (i) => _ReplyCard(
                      index: i,
                      onReplyTap: () {
                        final names = [
                          'PASHA JAMEER',
                          'Imtiaz Jaleel',
                          'Dr. Shoaib',
                        ];
                        final name = names[i % names.length];
                        _showReplyBottomSheet(
                          name.toLowerCase().replaceAll(' ', '_'),
                        );
                      },
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

class _ReplyCard extends StatelessWidget {
  final int index;
  final VoidCallback onReplyTap;
  const _ReplyCard({required this.index, required this.onReplyTap});

  static const _names = ['PASHA JAMEER', 'Imtiaz Jaleel', 'Dr. Shoaib'];

  @override
  Widget build(BuildContext context) {
    final name = _names[index % _names.length];
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.network(
              'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=150',
              width: 32.w,
              height: 32.w,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => CircleAvatar(
                radius: 16.w,
                backgroundColor: kPrimaryGreen,
                child: Text(
                  name[0],
                  style: const TextStyle(color: Colors.white),
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
                    Text(
                      name,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(Icons.verified, color: Colors.blue, size: 12.w),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryGreen,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'Follow',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Icon(Icons.more_vert, color: Colors.grey, size: 16.w),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  'To, @khan_jameer @ravi_negi &...',
                  style: GoogleFonts.roboto(
                    color: kPrimaryGreen,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.',
                  style: GoogleFonts.roboto(
                    fontSize: 12.sp,
                    color: Colors.black,
                    height: 1.35,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Text(
                      '2h',
                      style: GoogleFonts.roboto(
                        color: Colors.grey.shade600,
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    GestureDetector(
                      onTap: onReplyTap,
                      child: Text(
                        'Reply',
                        style: GoogleFonts.roboto(
                          color: Colors.grey.shade700,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
