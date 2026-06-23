import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../widgets/alert_banner.dart';
import '../../widgets/ad_banner.dart';
import '../membership/membership_form_screen.dart';

class ShareInviteScreen extends StatelessWidget {
  const ShareInviteScreen({super.key});

  static final _members = List<Map<String, String>>.generate(
    15,
    (i) => {
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Share & Invite',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15)),
            Text('Onboard New Members',
                style: TextStyle(color: Colors.white70, fontSize: 10)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_outlined, color: Colors.white),
            onPressed: () => _showQrSheet(context),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const AlertBanner(),

          // Stats row
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
            child: Row(
              children: [
                // My Team
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: const [
                          Text('My Team',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: kDarkGreen)),
                          SizedBox(width: 4),
                          Icon(Icons.info_outline,
                              size: 12, color: Colors.grey),
                        ]),
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('399',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 26,
                                    color: kDarkGreen)),
                            const SizedBox(width: 4),
                            const Icon(Icons.group_outlined,
                                color: Colors.grey, size: 18),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => _shareLink(context),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                decoration: BoxDecoration(
                                  color: kPrimaryGreen,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Invite Friends\nShare Link',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Register New Member
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: const [
                          Expanded(
                            child: Text('Register New Member',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: kDarkGreen)),
                          ),
                          Icon(Icons.info_outline,
                              size: 12, color: Colors.grey),
                        ]),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Text('99',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 26,
                                    color: kDarkGreen)),
                            const SizedBox(width: 4),
                            const Icon(Icons.group_outlined,
                                color: Colors.grey, size: 18),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const MembershipFormScreen()),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: kPrimaryGreen,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.person_add_outlined,
                                        color: Colors.white, size: 14),
                                    SizedBox(width: 4),
                                    Text('ADD',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List header
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
            child: Row(
              children: [
                Text('My Team (${_members.length + 484})',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          ),

          // Member list + ad banner at bottom
          Expanded(
            child: ListView.builder(
              itemCount: _members.length + 1, // +1 for ad banner
              itemBuilder: (context, i) {
                if (i == _members.length) {
                  return const AdBanner();
                }
                final m = _members[i];
                return _MemberTile(
                  number: i + 1,
                  name: m['name']!,
                  id: m['id']!,
                  ac: m['ac']!,
                  district: m['district']!,
                  state: m['state']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _shareLink(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 16),
            const Text('Share & Invite',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      'https://aimim.app/join/302-123456',
                      style: TextStyle(fontSize: 12, color: kPrimaryGreen),
                    ),
                  ),
                  Icon(Icons.copy, color: kPrimaryGreen, size: 18),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ShareOption(
                    icon: Icons.chat_rounded,
                    label: 'WhatsApp',
                    color: const Color(0xFF25D366)),
                _ShareOption(
                    icon: Icons.send,
                    label: 'Telegram',
                    color: const Color(0xFF0088CC)),
                _ShareOption(
                    icon: Icons.facebook,
                    label: 'Facebook',
                    color: const Color(0xFF1877F2)),
                _ShareOption(
                    icon: Icons.more_horiz,
                    label: 'More',
                    color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showQrSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 16),
            const Text('Your QR Code',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: kPrimaryGreen, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.qr_code_2,
                  size: 140, color: kDarkGreen),
            ),
            const SizedBox(height: 12),
            const Text('302-123456',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: kDarkGreen,
                    letterSpacing: 2)),
            const Text('Scan to join my team',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  final int number;
  final String name, id, ac, district, state;
  const _MemberTile({
    required this.number,
    required this.name,
    required this.id,
    required this.ac,
    required this.district,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Text('$number',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: kDarkGreen)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: kDarkGreen)),
                    const Text(' · ',
                        style: TextStyle(color: Colors.grey)),
                    Text(id,
                        style: const TextStyle(
                            fontSize: 12,
                            color: kDarkGreen,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 2),
                Text('$ac · $district · $state',
                    style: const TextStyle(
                        fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
        ],
      ),
    );
  }
}

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _ShareOption(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(fontSize: 10, color: Colors.black54)),
      ],
    );
  }
}
