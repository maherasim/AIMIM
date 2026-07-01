import 'dart:io';
import 'package:aimim_mobile_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants.dart';

class KiteCreateScreen extends StatefulWidget {
  const KiteCreateScreen({super.key});

  @override
  State<KiteCreateScreen> createState() => _KiteCreateScreenState();
}

class _KiteCreateScreenState extends State<KiteCreateScreen> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  String _audience = 'Everyone';
  final List<String> _selectedMedia = []; // Paths or network URLs
  final _picker = ImagePicker();
  static const _maxChars = 280;

  // Unsplash recommendation gallery images
  static const _galleryRecommendations = [
    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
    'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=150',
    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150',
  ];

  @override
  void initState() {
    super.initState();
    _textController.addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _focusNode.requestFocus(),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  int get _remaining => _maxChars - _textController.text.length;
  bool get _canPost =>
      _textController.text.trim().isNotEmpty && _remaining >= 0;

  Future<void> _pickFromGallery() async {
    if (_selectedMedia.length >= 4) {
      _showMaxImagesSnackBar();
      return;
    }
    final picked = await _picker.pickMultiImage(imageQuality: 85);
    if (picked.isNotEmpty) {
      setState(() {
        final canAdd = 4 - _selectedMedia.length;
        _selectedMedia.addAll(picked.take(canAdd).map((f) => f.path));
      });
    }
  }

  Future<void> _pickFromCamera() async {
    if (_selectedMedia.length >= 4) {
      _showMaxImagesSnackBar();
      return;
    }
    final picked = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (picked != null) {
      setState(() => _selectedMedia.add(picked.path));
    }
  }

  void _showMaxImagesSnackBar() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Max 4 images per post')));
  }

  void _removeMedia(int i) => setState(() => _selectedMedia.removeAt(i));

  void _toggleRecommendation(String url) {
    setState(() {
      if (_selectedMedia.contains(url)) {
        _selectedMedia.remove(url);
      } else {
        if (_selectedMedia.length >= 4) {
          _showMaxImagesSnackBar();
          return;
        }
        _selectedMedia.add(url);
      }
    });
  }

  void _showAudienceSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0C202F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Text(
              'Who can see this post?',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 8.h),
            ...[
              ('Everyone', Icons.public, 'Anyone on AIMIM can see'),
              ('Followers', Icons.group_outlined, 'Only your followers'),
              (
                'Members Only',
                Icons.verified_user_outlined,
                'Verified members only',
              ),
            ].map(
              (opt) => ListTile(
                leading: Icon(
                  opt.$2,
                  color: _audience == opt.$1 ? kPrimaryGreen : Colors.white60,
                ),
                title: Text(
                  opt.$1,
                  style: GoogleFonts.roboto(
                    color: _audience == opt.$1 ? kPrimaryGreen : Colors.white,
                    fontWeight: _audience == opt.$1
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                subtitle: Text(
                  opt.$3,
                  style: TextStyle(color: Colors.white38, fontSize: 11.sp),
                ),
                trailing: _audience == opt.$1
                    ? const Icon(Icons.check_circle, color: kPrimaryGreen)
                    : null,
                onTap: () {
                  setState(() => _audience = opt.$1);
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  void _saveDraft() {
    if (_textController.text.trim().isEmpty) {
      Navigator.pop(context);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Draft saved'),
        backgroundColor: Color(0xFF1A6B45),
      ),
    );
    Navigator.pop(context);
  }

  void _submitPost() {
    if (!_canPost) return;
    final post = {
      'author': 'PASHA JAMEER',
      'handle': '@pasha_jaam',
      'time': 'Just now',
      'location': 'My Location',
      'text': _textController.text.trim(),
      'tags': _extractTags(_textController.text),
      'images': _selectedMedia.length,
      'imagePaths': _selectedMedia,
      'audience': _audience,
    };
    Navigator.pop(context, post);
  }

  String _extractTags(String text) {
    final regex = RegExp(r'#\w+');
    return regex.allMatches(text).map((m) => m.group(0)).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final charFraction = _textController.text.length / _maxChars;
    final charColor = _remaining < 0
        ? Colors.red
        : _remaining < 20
        ? Colors.orange
        : Colors.white54;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF0C202F),
      appBar: AppBar(
        backgroundColor: AppTheme.primaryGreen,
        elevation: 0,
        leadingWidth: 50.w,
        leading: Center(
          child: GestureDetector(
            onTap: () {
              if (_textController.text.trim().isNotEmpty ||
                  _selectedMedia.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: const Color(0xFF0C202F),
                    title: Text(
                      'Discard post?',
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                    content: Text(
                      'Your draft will be lost.',
                      style: GoogleFonts.roboto(color: Colors.white70),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _saveDraft();
                        },
                        child: Text(
                          'Save draft',
                          style: GoogleFonts.roboto(color: kPrimaryGreen),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Discard',
                          style: GoogleFonts.roboto(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: Icon(Icons.close, color: Colors.white, size: 22.w),
            ),
          ),
        ),

        title: Row(
          mainAxisAlignment: .start,
          children: [SvgPicture.asset('assets/svg/Logo.svg', height: 50.h)],
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _saveDraft,
            child: Text(
              'Drafts',
              style: GoogleFonts.roboto(
                color: AppTheme.greenAccent,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Center(
              child: ElevatedButton(
                onPressed: _canPost ? _submitPost : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  disabledBackgroundColor: Colors.white54,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 6.h,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Post',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar with border
                      Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(0, 255, 83, 1),
                        ),
                        child: CircleAvatar(
                          radius: 20.w,
                          backgroundImage: const AssetImage(
                            'assets/images/user.jpg',
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Audience Selector
                            GestureDetector(
                              onTap: _showAudienceSheet,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromRGBO(0, 255, 83, 1),
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _audience,
                                      style: GoogleFonts.roboto(
                                        color: Color.fromRGBO(0, 255, 83, 1),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color.fromRGBO(0, 255, 83, 1),
                                      size: 16.w,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Text Input
                  TextField(
                    controller: _textController,

                    focusNode: _focusNode,
                    maxLines: 10,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),

                    cursorColor: kPrimaryGreen,
                    decoration: InputDecoration(
                      hintText: 'Your post start from here...',
                      hintStyle: GoogleFonts.roboto(
                        color: Colors.white60,
                        fontSize: 14.sp,
                      ),
                      fillColor: Colors.transparent,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15.h,
                        horizontal: 15.w.w,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Display selected media images preview
                  if (_selectedMedia.isNotEmpty)
                    SizedBox(
                      height: 140.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _selectedMedia.length,
                        itemBuilder: (context, i) {
                          final path = _selectedMedia[i];
                          final isNetwork = path.startsWith('http');
                          return Container(
                            width: 110.w,
                            margin: EdgeInsets.only(right: 8.w),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: isNetwork
                                      ? Image.network(
                                          path,
                                          width: 110.w,
                                          height: 140.h,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          File(path),
                                          width: 110.w,
                                          height: 140.h,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Positioned(
                                  top: 4.h,
                                  right: 4.w,
                                  child: _RemoveBtn(
                                    onTap: () => _removeMedia(i),
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
            ),
          ),

          // Bottom Bar containing horizontal picker, permissions and actions toolbar
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0C202F),
              border: Border(
                top: BorderSide(color: Colors.white10, width: 1.w),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Horizontal picker list
                SizedBox(
                  height: 90.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 8.h,
                    ),
                    children: [
                      // Camera trigger button card
                      GestureDetector(
                        onTap: _pickFromCamera,
                        child: Container(
                          width: 74.w,
                          height: 74.w,
                          margin: EdgeInsets.only(right: 8.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.greenAccent,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: AppTheme.greenAccent,
                            size: 45.w,
                          ),
                        ),
                      ),
                      // Recommendation Unsplash items
                      ..._galleryRecommendations.map((url) {
                        final isSel = _selectedMedia.contains(url);
                        return GestureDetector(
                          onTap: () => _toggleRecommendation(url),
                          child: Container(
                            width: 74.w,
                            height: 74.w,
                            margin: EdgeInsets.only(right: 8.w),
                            decoration: BoxDecoration(
                              border: isSel
                                  ? Border.all(color: kPrimaryGreen, width: 2.5)
                                  : null,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.r),
                              child: Image.network(
                                url,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: Colors.grey.shade800,
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: Colors.white54,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                // Permissions row (Everyone can comment / Schedule)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                          size: 22.w,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Icon(
                        Icons.public,
                        color: AppTheme.greenAccent,
                        size: 18.w,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Everyone can comment',
                        style: GoogleFonts.roboto(
                          color: AppTheme.greenAccent,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.calendar_today,
                        color: kPrimaryGreen,
                        size: 18.w,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Schedule',
                        style: GoogleFonts.roboto(
                          color: AppTheme.greenAccent,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom toolbar row (Image, Gift, Location Pin, Character counter, Save button)
                Container(
                  padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 12.h),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.white10, width: 1.w),
                    ),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _pickFromGallery,
                        child: Icon(
                          Icons.image_outlined,
                          color: AppTheme.greenAccent,
                          size: 22.w,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.card_giftcard_outlined,
                          color: AppTheme.greenAccent,
                          size: 22.w,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.location_on_outlined,
                          color: AppTheme.greenAccent,
                          size: 22.w,
                        ),
                      ),
                      const Spacer(),
                      // Character Counter circle
                      SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: charFraction.clamp(0.0, 1.0),
                              strokeWidth: 2.w,
                              backgroundColor: Colors.white10,
                              color: charColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Container(
                        height: 20.h,
                        width: 1.w,
                        color: Colors.white24,
                      ),
                      SizedBox(width: 12.w),
                      GestureDetector(
                        onTap: _saveDraft,
                        child: Text(
                          'Save',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RemoveBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _RemoveBtn({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20.w,
        height: 20.w,
        decoration: BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white54),
        ),
        child: Icon(Icons.close, color: Colors.white, size: 12.w),
      ),
    );
  }
}
