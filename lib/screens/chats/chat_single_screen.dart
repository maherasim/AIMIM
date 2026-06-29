import 'package:aimim_mobile_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../widgets/alert_banner.dart';

class ChatSingleScreen extends StatefulWidget {
  final String name;
  const ChatSingleScreen({super.key, required this.name});

  @override
  State<ChatSingleScreen> createState() => _ChatSingleScreenState();
}

class _ChatSingleScreenState extends State<ChatSingleScreen> {
  final _msgController = TextEditingController();

  static const _messages = [
    {'me': false, 'text': 'This is the main chat template', 'time': '9:41 AM'},
    {'me': false, 'text': 'Hmmm', 'time': '9:42 AM'},
    {'me': false, 'text': 'I think I get it', 'time': '9:42 AM'},
    {
      'me': false,
      'text': 'Will head to the Help Center if I have more questions tho',
      'time': '9:43 AM',
    },
    {
      'me': true,
      'text':
          'You just edit any text to type in the conversation you want to show, and delete any bubbles you don\'t want to use',
      'time': '9:44 AM',
    },
    {'me': true, 'text': 'Boom!', 'time': '9:44 AM'},
    {'me': false, 'text': 'Oh?', 'time': '9:45 AM'},
    {'me': false, 'text': 'Cool', 'time': '9:45 AM'},
    {'me': false, 'text': 'How does it work?', 'time': '9:46 AM'},
  ];

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryGreen,
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 16.r,
              backgroundColor: Colors.white24,
              child: Text(
                widget.name[0],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
                        widget.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.verified, color: Colors.blue, size: 13),
                    ],
                  ),
                  Text(
                    'Online',
                    style: TextStyle(color: Colors.white70, fontSize: 10.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call_outlined, color: Colors.white),
            onPressed: () {},
          ),
          SizedBox(width: 10.w),
          SvgPicture.asset('assets/svg/whatsapp-1.svg', height: 25.h),
          SizedBox(width: 10.w),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const AlertBanner(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length + 1,
              itemBuilder: (context, i) {
                if (i == 0) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Text(
                        'Nov 30, 2025, 9:41 AM',
                        style: TextStyle(color: Colors.grey, fontSize: 11.sp),
                      ),
                    ),
                  );
                }
                final msg = _messages[i - 1];
                return _ChatBubble(
                  text: msg['text'] as String,
                  isMe: msg['me'] as bool,
                  time: msg['time'] as String,
                );
              },
            ),
          ),
          // Input bar
          Container(
            margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    decoration: InputDecoration(
                      hintText: 'Messages',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      // prefix: Row(
                      //   children: [
                      //     Icon(Icons.gif, color: Colors.white),
                      //     Divider(thickness: 5),
                      //   ],
                      // ),
                      prefixIcon: Icon(
                        Icons.gif_box_outlined,
                        color: Colors.white,
                      ),
                      suffixIcon: Icon(Icons.attachment, color: Colors.green),
                      fillColor: Color.fromRGBO(30, 41, 59, 1),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        // borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.mic, color: Colors.black, size: 20.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;
  const _ChatBubble({
    required this.text,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        decoration: BoxDecoration(
          color: isMe ? Colors.black : Colors.white,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(isMe ? 4.r : 16.r),
            bottomLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            topLeft: Radius.circular(isMe ? 16.r : 4.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.r,
              offset: Offset(0, 1.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: GoogleFonts.roboto(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 13.sp,
                height: 1.4,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              time,
              style: TextStyle(
                color: isMe ? Colors.white60 : Colors.grey,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
