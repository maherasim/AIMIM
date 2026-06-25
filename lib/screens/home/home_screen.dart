import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../widgets/alert_banner.dart';
import 'nav_menu_drawer.dart';
import 'profile_screen.dart';
import '../membership/membership_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 8),
          Container(width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          const Text('Notifications',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Divider(),
          ...[
            ('New member joined your team', Icons.person_add, '2m ago'),
            ('AIMIM announced a new event', Icons.campaign_outlined, '1h ago'),
            ('Your membership was verified', Icons.verified, '3h ago'),
            ('Daily check-in reminder', Icons.check_circle_outline, 'Yesterday'),
          ].map((n) => ListTile(
            leading: CircleAvatar(
              backgroundColor: kPrimaryGreen.withAlpha(25),
              child: Icon(n.$2, color: kPrimaryGreen, size: 20),
            ),
            title: Text(n.$1, style: const TextStyle(fontSize: 13)),
            trailing: Text(n.$3,
                style: const TextStyle(color: Colors.grey, fontSize: 11)),
          )),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }

  void _showHomeMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('View Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(
                    name: 'A.H.A. KHAN',
                    heroTag: 'home_menu_profile_avatar',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.group_outlined),
            title: const Text('Build Your Team'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (_) => const MembershipFormScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text('Cancel'),
            onTap: () => Navigator.pop(context),
          ),
        ]),
      ),
    );
  }

  static const _stories = [
    {'name': 'AIMIM', 'isAdd': true},
    {'name': 'Asaduddin', 'color': 0xFF1A6B45},
    {'name': 'Imtiaz', 'color': 0xFF2E7D32},
    {'name': 'Dr.Shoaib', 'color': 0xFF388E3C},
    {'name': 'Shaukat', 'color': 0xFF43A047},
    {'name': 'Pasha', 'color': 0xFF4CAF50},
    {'name': 'Ahmed', 'color': 0xFF66BB6A},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawer: const NavMenuDrawer(),
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        elevation: 0,
        leading: Builder(
          builder: (ctx) => GestureDetector(
            onTap: () => Scaffold.of(ctx).openDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.white24,
                child: Image.asset(
                  'assets/images/logo_round.png',
                  errorBuilder: (c, e, s) =>
                      const Icon(Icons.person, color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          'AIMIM',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 22,
            letterSpacing: 3,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.white),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const MembershipFormScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () => _showNotifications(context),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () => _showHomeMenu(context),
          ),
        ],
      ),
      body: Column(
        children: [
          const AlertBanner(),
          // Stories row
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _stories.length,
                itemBuilder: (context, i) =>
                    _StoryItem(
                      story: _stories[i],
                      onTap: () {
                        final s = _stories[i];
                        if (s['isAdd'] == true) {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (_) => const MembershipFormScreen()));
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProfileScreen(
                                name: s['name'] as String,
                                heroTag: 'story_avatar_${s['name'] as String}',
                              ),
                            ),
                          );
                        }
                      },
                    ),
              ),
            ),
          ),
          const Divider(height: 1),
          // Feed
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, i) => _StatusCard(index: i),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MembershipFormScreen())),
        backgroundColor: kPrimaryGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  final Map<String, dynamic> story;
  final VoidCallback onTap;
  const _StoryItem({required this.story, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isAdd = story['isAdd'] == true;
    final color = story['color'] != null
        ? Color(story['color'] as int)
        : kPrimaryGreen;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 65,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'story_avatar_${story['name'] as String}',
                  child: CircleAvatar(
                    radius: 29,
                    backgroundColor:
                        isAdd ? Colors.grey.shade200 : color,
                    child: isAdd
                        ? const Icon(Icons.add, color: kPrimaryGreen, size: 26)
                        : Text(
                            (story['name'] as String)[0],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                  ),
                ),
                if (!isAdd)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              story['name'] as String,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final int index;
  const _StatusCard({required this.index});

  static const _users = [
    'A.H.A. KHAN', 'Imtiaz Jaleel', 'Pasha Jameer',
    'Asaduddin Owais', 'Dr. Shoaib', 'Shaukat Ali',
  ];

  @override
  Widget build(BuildContext context) {
    final name = _users[index % _users.length];
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'feed_avatar_$name',
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: kPrimaryGreen,
                    child: Text(name[0],
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13)),
                          const SizedBox(width: 4),
                          const Icon(Icons.verified,
                              color: kPrimaryGreen, size: 14),
                        ],
                      ),
                      Text('${index + 1}h ago',
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 11)),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProfileScreen(
                        name: name,
                        heroTag: 'feed_avatar_$name',
                      ),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: kPrimaryGreen,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    side: const BorderSide(color: kPrimaryGreen),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Follow',
                      style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'This is a status update from AIMIM National Membership Platform. Stay connected with your local representatives and party updates.',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 10),
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.image_outlined,
                    color: Colors.grey, size: 48),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _ActionBtn(Icons.favorite_border, '${(index + 1) * 12}K'),
                _ActionBtn(Icons.comment_outlined, '${(index + 1) * 3}K'),
                _ActionBtn(Icons.repeat_rounded, '${(index + 1)}K'),
                const Spacer(),
                _ActionBtn(Icons.share_outlined, 'Share'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ActionBtn(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade600),
          const SizedBox(width: 4),
          Text(label,
              style:
                  TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}

