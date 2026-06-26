import 'package:flutter/material.dart';
import '../../constants.dart';
import '../membership/membership_form_screen.dart';
import 'profile_screen.dart';

class BuildTeamScreen extends StatelessWidget {
  const BuildTeamScreen({super.key});

  static final _members = List<Map<String, String>>.generate(
    20,
    (_) => {
      'name': 'A. H. A. KHAN',
      'id': '001123456',
      'ac': 'AC 314 DHANGHATA',
      'district': 'SANT KABIR NAGAR',
      'state': 'UP',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Build Your Team',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.white24,
            child: const Icon(Icons.person, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          // Help button
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF25D366),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Text(
                  'Help?',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.chat_rounded, color: Colors.white, size: 14),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats row
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'My Team Members',
                    count: 399,
                    actionLabel: 'Invite Friends\nShare Link',
                    actionIcon: Icons.share_outlined,
                    onAction: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Onboard New Member',
                    count: 99,
                    actionLabel: 'ADD',
                    actionIcon: Icons.person_add_outlined,
                    onAction: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MembershipFormScreen(),
                      ),
                    ),
                    isAdd: true,
                  ),
                ),
              ],
            ),
          ),

          // List header
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 6),
            child: Row(
              children: [
                Text(
                  'My Team Member List (${_members.length + 479})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Member list
          Expanded(
            child: ListView.builder(
              itemCount: _members.length,
              itemBuilder: (context, i) {
                final m = _members[i];
                return _MemberRow(
                  number: i + 1,
                  name: m['name']!,
                  id: m['id']!,
                  ac: m['ac']!,
                  district: m['district']!,
                  state: m['state']!,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProfileScreen(
                        name: m['name']!,
                        heroTag: 'build_team_profile_${m['name']!}',
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MembershipFormScreen()),
        ),
        backgroundColor: kPrimaryGreen,
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: const Text(
          'Add Member',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int count;
  final String actionLabel;
  final IconData actionIcon;
  final VoidCallback onAction;
  final bool isAdd;

  const _StatCard({
    required this.title,
    required this.count,
    required this.actionLabel,
    required this.actionIcon,
    required this.onAction,
    this.isAdd = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: kDarkGreen,
                  ),
                ),
              ),
              const Icon(Icons.info_outline, size: 13, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$count',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 26,
                  color: kDarkGreen,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.group_outlined, color: Colors.grey, size: 18),
              const Spacer(),
              GestureDetector(
                onTap: onAction,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isAdd ? 12 : 8,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryGreen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: isAdd
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.person_add_outlined,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'ADD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          actionLabel,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MemberRow extends StatelessWidget {
  final int number;
  final String name, id, ac, district, state;
  final VoidCallback onTap;

  const _MemberRow({
    required this.number,
    required this.name,
    required this.id,
    required this.ac,
    required this.district,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: Text(
                '$number',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: kDarkGreen,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: kDarkGreen,
                        ),
                      ),
                      const Text(' · ', style: TextStyle(color: Colors.grey)),
                      Text(
                        id,
                        style: const TextStyle(
                          fontSize: 12,
                          color: kDarkGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$ac · $district · $state',
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }
}
