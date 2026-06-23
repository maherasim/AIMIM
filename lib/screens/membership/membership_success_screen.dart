import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants.dart';
import '../main_screen.dart';
import '../home/build_team_screen.dart';

class MembershipSuccessScreen extends StatelessWidget {
  final String name;
  final String enrollmentNo;
  final String state;
  final String district;
  final String assembly;
  final String membershipType;

  const MembershipSuccessScreen({
    super.key,
    required this.name,
    required this.enrollmentNo,
    required this.state,
    required this.district,
    required this.assembly,
    required this.membershipType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryGreen,
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const MainScreen()),
            (_) => false,
          ),
        ),
        title: Image.asset(
          'assets/images/logo_round.png',
          height: 34,
          errorBuilder: (c, e, s) => const Text('AIMIM',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3)),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Success badge
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(Icons.check_circle, color: kPrimaryGreen, size: 56),
            ),
            const SizedBox(height: 10),
            const Text('Registration Successful!',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18)),
            const SizedBox(height: 4),
            const Text('Your AIMIM membership has been submitted for review.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 12)),

            const SizedBox(height: 20),

            // Membership Card
            _MembershipCard(
              name: name.isEmpty ? 'MEMBER NAME' : name.toUpperCase(),
              enrollmentNo: enrollmentNo,
              state: state,
              district: district,
              assembly: assembly,
              membershipType: membershipType,
            ),

            const SizedBox(height: 16),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: _ActionBtn(
                    icon: Icons.download_outlined,
                    label: 'Download Card',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Member card saved to gallery'))),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionBtn(
                    icon: Icons.share_outlined,
                    label: 'Share',
                    onTap: () => showModalBottomSheet(
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
                            const Text('Share Member Card',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 16),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                              _ShareOpt(Icons.chat_rounded, 'WhatsApp', const Color(0xFF25D366)),
                              _ShareOpt(Icons.send, 'Telegram', const Color(0xFF0088CC)),
                              _ShareOpt(Icons.facebook, 'Facebook', const Color(0xFF1877F2)),
                              _ShareOpt(Icons.link, 'Copy Link', Colors.grey),
                            ]),
                            const SizedBox(height: 8),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _ActionBtn(
                    icon: Icons.group_add_outlined,
                    label: 'Build Your Team',
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const BuildTeamScreen())),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionBtn(
                    icon: Icons.home_outlined,
                    label: 'Go to Home',
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const MainScreen()),
                      (_) => false,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Enrollment number card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0D2B3E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text('Your Enrollment Number',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 8),
                  Text(enrollmentNo,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                          letterSpacing: 2)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: enrollmentNo));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enrollment number copied!'),
                          backgroundColor: kPrimaryGreen,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.copy, color: Colors.white54, size: 14),
                        SizedBox(width: 4),
                        Text('Tap to copy',
                            style: TextStyle(
                                color: Colors.white54, fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _ShareOpt extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _ShareOpt(this.icon, this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
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
}

// ── Digital Membership Card ─────────────────────────────────────────────────

class _MembershipCard extends StatelessWidget {
  final String name;
  final String enrollmentNo;
  final String state;
  final String district;
  final String assembly;
  final String membershipType;

  const _MembershipCard({
    required this.name,
    required this.enrollmentNo,
    required this.state,
    required this.district,
    required this.assembly,
    required this.membershipType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D2B1A), Color(0xFF1A6B45)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(80),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Card header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(15),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/logo_round.png',
                  width: 40,
                  height: 40,
                  errorBuilder: (c, e, s) => const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Text('A',
                        style: TextStyle(
                            color: kPrimaryGreen,
                            fontWeight: FontWeight.w900,
                            fontSize: 18)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('AIMIM',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              letterSpacing: 3)),
                      Text('National Membership Platform',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 9,
                              letterSpacing: 0.5)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('NMP',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 10)),
                ),
              ],
            ),
          ),

          // Card body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 70,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(20),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Icon(Icons.person, color: Colors.white54, size: 40),
                ),
                const SizedBox(width: 14),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 15)),
                      const SizedBox(height: 6),
                      _CardRow(label: 'Member ID', value: enrollmentNo),
                      _CardRow(label: 'Type', value: membershipType),
                      _CardRow(label: 'State', value: state),
                      _CardRow(label: 'AC', value: assembly),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Card footer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(10),
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('District',
                        style: TextStyle(color: Colors.white54, fontSize: 9)),
                    Text(district,
                        style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Valid From',
                        style: TextStyle(color: Colors.white54, fontSize: 9)),
                    const Text('Jun 2026',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
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

class _CardRow extends StatelessWidget {
  final String label;
  final String value;
  const _CardRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Text('$label: ',
              style: const TextStyle(color: Colors.white54, fontSize: 10)),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionBtn(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(25),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(height: 4),
            Text(label,
                style:
                    const TextStyle(color: Colors.white, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
