import 'package:aimim_mobile_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../widgets/alert_banner.dart';
import 'chat_single_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();

  static const _contacts = [
    {
      'name': 'A. H. A. KHAN',
      'handle': '@p_m_ajjukhan',
      'verified': true,
      'unread': 2,
      'prime': true,
    },
    {
      'name': 'Jenny Wilson',
      'handle': '@jenny_w',
      'verified': true,
      'unread': 1,
      'prime': false,
    },
    {
      'name': 'Guy Hawkins',
      'handle': '@guy_h',
      'verified': false,
      'unread': 2,
      'prime': false,
    },
    {
      'name': 'Courtney Henry',
      'handle': '@courtney_h',
      'verified': false,
      'unread': 2,
      'prime': false,
    },
    {
      'name': 'Kathryn Murphy',
      'handle': '@kathryn_m',
      'verified': false,
      'unread': 2,
      'prime': false,
    },
    {
      'name': 'Jerome Bell',
      'handle': '@jerome_b',
      'verified': false,
      'unread': 0,
      'prime': false,
    },
    {
      'name': 'Imtiaz Jaleel',
      'handle': '@imtiaz_jaleel',
      'verified': true,
      'unread': 2,
      'prime': true,
    },
    {
      'name': 'Theresa Webb',
      'handle': '@theresa_w',
      'verified': false,
      'unread': 2,
      'prime': false,
    },
    {
      'name': 'Arlene McCoy',
      'handle': '@arlene_m',
      'verified': false,
      'unread': 2,
      'prime': false,
    },
    {
      'name': 'Eleanor Pena',
      'handle': '@eleanor_p',
      'verified': false,
      'unread': 2,
      'prime': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryGreen,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryGreen,
        elevation: 0.5,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            color: Colors.white,
            size: 30.sp,
          ),
          onPressed: () => showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (_) => SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'New Conversation',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.person_add_outlined),
                    title: const Text('New Direct Message'),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.group_add_outlined),
                    title: const Text('New Group'),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.campaign_outlined),
                    title: const Text('New Broadcast'),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        ),
        title: Container(
          height: 36,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: _searchController,

            decoration: InputDecoration(
              fillColor: Color.fromRGBO(41, 42, 46, 0.8),
              hintText: 'Search name',

              // maintainHintHeight: false,
              hintStyle: GoogleFonts.roboto(
                fontSize: 13,
                color: Colors.white60,
              ),
              prefixIcon: Icon(Icons.search, color: Colors.grey, size: 18),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(30.r)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.5),

                borderRadius: BorderRadius.all(Radius.circular(30.r)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.5),

                borderRadius: BorderRadius.all(Radius.circular(30.r)),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ),
        actions: [
          SizedBox(width: 20.w),

          SvgPicture.asset('assets/svg/like.svg', color: Colors.white),
          SizedBox(width: 20.w),
          SvgPicture.asset('assets/svg/badge.svg'),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () => showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (_) => SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.mark_chat_read_outlined),
                      title: const Text('Mark all as read'),
                      onTap: () => Navigator.pop(context),
                    ),
                    ListTile(
                      leading: const Icon(Icons.archive_outlined),
                      title: const Text('Archived chats'),
                      onTap: () => Navigator.pop(context),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings_outlined),
                      title: const Text('Chat settings'),
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),

            decoration: BoxDecoration(
              color: Color.fromRGBO(41, 42, 46, 0.5),
              borderRadius: BorderRadius.circular(30.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.w),
            child: TabBar(
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,

              controller: _tabController,
              onFocusChange: (value, index) {
                setState(() {});
              },
              onTap: (value) {
                setState(() {});
              },

              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: Colors.transparent,
              labelColor: Colors.transparent,
              dividerColor: Colors.transparent,
              // unselectedLabelColor: Colors.grey,
              // labelStyle: const TextStyle(
              //   fontWeight: FontWeight.w600,
              //   fontSize: 12,
              // ),
              tabs: [
                buildTab(
                  title: 'All',
                  value: '60',
                  isActive: _tabController.index == 0,
                ),
                buildTab(
                  title: 'Unread',
                  value: '10',
                  isActive: _tabController.index == 1,
                ),
                buildTab(
                  title: 'P2P',
                  value: '5',
                  isActive: _tabController.index == 2,
                ),
                buildTab(
                  title: 'AIMIM',
                  value: '15',
                  isActive: _tabController.index == 3,
                ),
                buildTab(
                  title: 'Groups',
                  value: '3',
                  isActive: _tabController.index == 4,
                ),

                // Tab(text: 'All  60'),
                // Tab(text: 'Unread  10'),
                // Tab(text: 'P2P  5'),
                // Tab(text: 'AIMIM'),
                // Tab(text: 'Groups  3'),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const AlertBanner(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(
                5,
                (_) => _ContactList(contacts: _contacts),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildTab({
    required String title,
    required String value,
    bool isActive = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: isActive ? Colors.white : Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20.r),
        color: isActive
            ? AppTheme.primaryGreen
            : Color.fromRGBO(41, 42, 46, 0.9),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 16.sp,
              color: isActive ? Colors.white : Colors.white38,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? Color.fromRGBO(36, 54, 237, 1)
                  : Color.fromRGBO(215, 216, 219, 1),
              // borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              value,
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                color: isActive ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactList extends StatelessWidget {
  final List<Map<String, dynamic>> contacts;
  const _ContactList({required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: contacts.length,
      separatorBuilder: (_, i) =>
          Divider(height: 0.1.sp, indent: 0, color: Colors.grey.shade200),
      itemBuilder: (context, i) {
        final c = contacts[i];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          leading: Container(
            width: 55.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
              image: DecorationImage(
                image: AssetImage('assets/images/user.jpg'),
              ),
            ),
          ),
          title: Row(
            children: [
              Text(
                c['name'] as String,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18.sp,
                ),
              ),
              if (c['verified'] == true) ...[
                const SizedBox(width: 4),
                const Icon(Icons.verified, color: kPrimaryGreen, size: 14),
              ],
              if (c['prime'] == true) ...[
                const SizedBox(width: 2),
                const Icon(Icons.verified, color: Colors.blue, size: 13),
              ],
            ],
          ),
          subtitle: Row(
            children: [
              SvgPicture.asset('assets/svg/d-tick.svg'),
              SizedBox(width: 8.w),
              Text(
                "I'm on AIMIM APP as ${c['handle']}...",
                style: GoogleFonts.roboto(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '12:41 pm',
                style: GoogleFonts.roboto(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              if ((c['unread'] as int) > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(254, 101, 5, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${c['unread']} new',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatSingleScreen(name: c['name'] as String),
            ),
          ),
        );
      },
    );
  }
}
