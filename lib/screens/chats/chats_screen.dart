import 'package:flutter/material.dart';
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
    {'name': 'A. H. A. KHAN', 'handle': '@p_m_ajjukhan', 'verified': true, 'unread': 2, 'prime': true},
    {'name': 'Jenny Wilson', 'handle': '@jenny_w', 'verified': true, 'unread': 1, 'prime': false},
    {'name': 'Guy Hawkins', 'handle': '@guy_h', 'verified': false, 'unread': 2, 'prime': false},
    {'name': 'Courtney Henry', 'handle': '@courtney_h', 'verified': false, 'unread': 2, 'prime': false},
    {'name': 'Kathryn Murphy', 'handle': '@kathryn_m', 'verified': false, 'unread': 2, 'prime': false},
    {'name': 'Jerome Bell', 'handle': '@jerome_b', 'verified': false, 'unread': 0, 'prime': false},
    {'name': 'Imtiaz Jaleel', 'handle': '@imtiaz_jaleel', 'verified': true, 'unread': 2, 'prime': true},
    {'name': 'Theresa Webb', 'handle': '@theresa_w', 'verified': false, 'unread': 2, 'prime': false},
    {'name': 'Arlene McCoy', 'handle': '@arlene_m', 'verified': false, 'unread': 2, 'prime': false},
    {'name': 'Eleanor Pena', 'handle': '@eleanor_p', 'verified': false, 'unread': 2, 'prime': false},
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
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.add_circle_outline, color: kPrimaryGreen),
          onPressed: () => showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            builder: (_) => SafeArea(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const SizedBox(height: 8),
                const Text('New Conversation',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Divider(),
                ListTile(leading: const Icon(Icons.person_add_outlined),
                    title: const Text('New Direct Message'),
                    onTap: () => Navigator.pop(context)),
                ListTile(leading: const Icon(Icons.group_add_outlined),
                    title: const Text('New Group'),
                    onTap: () => Navigator.pop(context)),
                ListTile(leading: const Icon(Icons.campaign_outlined),
                    title: const Text('New Broadcast'),
                    onTap: () => Navigator.pop(context)),
              ]),
            ),
          ),
        ),
        title: Container(
          height: 36,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search name',
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
              prefixIcon:
                  Icon(Icons.search, color: Colors.grey, size: 18),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.grey),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No starred messages yet'))),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.grey),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contacts synced'))),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () => showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
              builder: (_) => SafeArea(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  ListTile(leading: const Icon(Icons.mark_chat_read_outlined),
                      title: const Text('Mark all as read'),
                      onTap: () => Navigator.pop(context)),
                  ListTile(leading: const Icon(Icons.archive_outlined),
                      title: const Text('Archived chats'),
                      onTap: () => Navigator.pop(context)),
                  ListTile(leading: const Icon(Icons.settings_outlined),
                      title: const Text('Chat settings'),
                      onTap: () => Navigator.pop(context)),
                ]),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: kPrimaryGreen,
          labelColor: kPrimaryGreen,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 12),
          tabs: const [
            Tab(text: 'All  60'),
            Tab(text: 'Unread  10'),
            Tab(text: 'P2P  5'),
            Tab(text: 'AIMIM'),
            Tab(text: 'Groups  3'),
          ],
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
}

class _ContactList extends StatelessWidget {
  final List<Map<String, dynamic>> contacts;
  const _ContactList({required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: contacts.length,
      separatorBuilder: (_, i) =>
          Divider(height: 1, indent: 72, color: Colors.grey.shade200),
      itemBuilder: (context, i) {
        final c = contacts[i];
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: kPrimaryGreen,
            child: Text(
              (c['name'] as String)[0],
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          title: Row(
            children: [
              Text(
                c['name'] as String,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 13),
              ),
              if (c['verified'] == true) ...[
                const SizedBox(width: 4),
                const Icon(Icons.verified,
                    color: kPrimaryGreen, size: 14),
              ],
              if (c['prime'] == true) ...[
                const SizedBox(width: 2),
                const Icon(Icons.verified_user,
                    color: Colors.blue, size: 13),
              ],
            ],
          ),
          subtitle: Text(
            "I'm on AIMIM APP as ${c['handle']}...",
            style: const TextStyle(fontSize: 11, color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('12:41 pm',
                  style:
                      TextStyle(fontSize: 10, color: Colors.grey)),
              const SizedBox(height: 4),
              if ((c['unread'] as int) > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${c['unread']} new',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ChatSingleScreen(name: c['name'] as String),
            ),
          ),
        );
      },
    );
  }
}
