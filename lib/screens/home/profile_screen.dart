import 'package:flutter/material.dart';
import '../../constants.dart';
import '../chats/chat_single_screen.dart';
import '../membership/membership_success_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  const ProfileScreen({super.key, required this.name});

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
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(width: 40, height: 4,
                decoration: BoxDecoration(color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 14),
            const Text('Share Profile',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _buildShareOpt(context, Icons.chat_rounded, 'WhatsApp', const Color(0xFF25D366)),
              _buildShareOpt(context, Icons.send, 'Telegram', const Color(0xFF0088CC)),
              _buildShareOpt(context, Icons.facebook, 'Facebook', const Color(0xFF1877F2)),
              _buildShareOpt(context, Icons.link, 'Copy Link', Colors.grey),
            ]),
            const SizedBox(height: 8),
          ]),
        ),
      ),
    );
  }

  Widget _buildShareOpt(BuildContext ctx, IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(ctx);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sharing via $label...')));
      },
      child: Column(children: [
        Container(
          width: 52, height: 52,
          decoration: BoxDecoration(color: color.withAlpha(25), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 26),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11)),
      ]),
    );
  }

  void _showMore(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(leading: const Icon(Icons.block), title: const Text('Block'),
              onTap: () { Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User blocked'))); }),
          ListTile(leading: const Icon(Icons.report_outlined), title: const Text('Report'),
              onTap: () { Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Report submitted'))); }),
          ListTile(leading: const Icon(Icons.close), title: const Text('Cancel'),
              onTap: () => Navigator.pop(context)),
        ]),
      ),
    );
  }

  void _showSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(leading: const Icon(Icons.notifications_outlined),
              title: const Text('Notifications'), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.lock_outline),
              title: const Text('Privacy'), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.language_outlined),
              title: const Text('Language'), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
              }),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.name;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('@${name.toLowerCase().replaceAll(' ', '_')}',
            style: const TextStyle(color: Colors.white, fontSize: 14)),
        actions: [
          IconButton(
              icon: const Icon(Icons.ios_share_outlined, color: Colors.white),
              onPressed: () => _showShare(context)),
          IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () => _showMore(context)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: kPrimaryGreen,
                            child: Text(name[0],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: kPrimaryGreen,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(Icons.notifications,
                                  color: Colors.white, size: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                const SizedBox(width: 4),
                                const Icon(Icons.verified,
                                    color: kPrimaryGreen, size: 16),
                                const Icon(Icons.verified,
                                    color: Colors.blue, size: 16),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(name.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.grey)),
                            const SizedBox(height: 2),
                            const Text('Member ID: 786786786',
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: TextStyle(fontSize: 12, height: 1.4),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.grey,
                          child: Text('J',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 8))),
                      const SizedBox(width: 4),
                      const Text('Followed by juliantara.uix, juliantara',
                          style: TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Social links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      _SocialChip(Icons.alternate_email, Colors.black),
                      _SocialChip(Icons.chat_rounded, Color(0xFF25D366)),
                      _SocialChip(Icons.send, Color(0xFF0088CC)),
                      _SocialChip(Icons.camera_alt_outlined,
                          Color(0xFFE1306C)),
                      _SocialChip(Icons.facebook, Color(0xFF1877F2)),
                      _SocialChip(Icons.g_mobiledata_rounded, Colors.red),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Follow button (prominent)
                  GestureDetector(
                    onTap: () => setState(() => _following = !_following),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: _following ? Colors.white : kPrimaryGreen,
                        border: Border.all(
                            color: _following ? Colors.grey.shade400 : kPrimaryGreen,
                            width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _following
                                ? Icons.check_circle_outline
                                : Icons.person_add_outlined,
                            size: 16,
                            color: _following ? kPrimaryGreen : Colors.white,
                          ),
                          const SizedBox(width: 6),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              _following ? 'Following' : 'Follow',
                              key: ValueKey(_following),
                              style: TextStyle(
                                color: _following ? kPrimaryGreen : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Action buttons row
                  Row(
                    children: [
                      Expanded(
                          child: _ProfileBtn('Member Card', Icons.badge_outlined,
                              () => Navigator.push(context,
                                  MaterialPageRoute(builder: (_) =>
                                      MembershipSuccessScreen(
                                        name: name,
                                        enrollmentNo: 'MEM-786786',
                                        state: 'Maharashtra',
                                        district: 'Mumbai',
                                        assembly: 'Aurangabad',
                                        membershipType: 'Active',
                                      ))))),
                      const SizedBox(width: 8),
                      Expanded(
                          child: _ProfileBtn('Message', Icons.message_outlined,
                              () => Navigator.push(context,
                                  MaterialPageRoute(builder: (_) =>
                                      ChatSingleScreen(name: name))))),
                      const SizedBox(width: 8),
                      Expanded(
                          child: _ProfileBtn('Settings', Icons.settings_outlined,
                              () => _showSettings(context))),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Story circles
            SizedBox(
              height: 72,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: 6,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor:
                            kPrimaryGreen.withAlpha(40 + i * 20),
                        child: Text(String.fromCharCode(65 + i),
                            style: const TextStyle(
                                color: kPrimaryGreen,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            // Tab bar
            DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  const TabBar(
                    indicatorColor: kPrimaryGreen,
                    labelColor: kPrimaryGreen,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(icon: Icon(Icons.grid_view, size: 20)),
                      Tab(icon: Icon(Icons.view_list, size: 20)),
                      Tab(icon: Icon(Icons.play_circle_outline, size: 20)),
                      Tab(icon: Icon(Icons.person_outline, size: 20)),
                    ],
                  ),
                  SizedBox(
                    height: 320,
                    child: TabBarView(
                      children: [
                        _PostGrid(),
                        const Center(child: Text('List View')),
                        const Center(child: Text('Reels')),
                        const Center(child: Text('Tagged')),
                      ],
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

class _PostGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: 9,
      itemBuilder: (context, i) => Container(
        color: Colors.grey.shade200,
        child: const Icon(Icons.image_outlined,
            color: Colors.grey, size: 32),
      ),
    );
  }
}

class _SocialChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _SocialChip(this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 18),
    );
  }
}

class _ProfileBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _ProfileBtn(this.label, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black87,
        side: BorderSide(color: Colors.grey.shade300),
        padding: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 11)),
    );
  }
}
