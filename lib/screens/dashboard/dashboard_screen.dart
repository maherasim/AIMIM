import 'package:flutter/material.dart';
import '../../constants.dart';
import '../awards/awards_screen.dart';
import '../home/build_team_screen.dart';
import '../membership/membership_form_screen.dart';
import 'share_invite_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showBanner = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showMoreSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(
                Icons.emoji_events_outlined,
                color: kPrimaryGreen,
              ),
              title: const Text('Awards & Medals'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AwardsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.group_outlined, color: kPrimaryGreen),
              title: const Text('Build Your Team'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BuildTeamScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.share_outlined, color: kPrimaryGreen),
              title: const Text('Share & Invite'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ShareInviteScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryGreen,
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo_round.png',
          height: 36,
          errorBuilder: (c, e, s) => const Text(
            'AIMIM',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
            ),
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events_outlined, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AwardsScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.receipt_long_outlined, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BuildTeamScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () => _showMoreSheet(context),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44),
          child: Row(
            children: [
              Expanded(
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white60,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  tabs: const [
                    Tab(text: 'Dashboard'),
                    Tab(text: 'Badge'),
                    Tab(text: 'Action'),
                    Tab(text: 'Control'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white24,
                  child: const Text(
                    'P',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _DashboardTab(
            showBanner: _showBanner,
            onCloseBanner: () => setState(() => _showBanner = false),
          ),
          const _ComingSoonTab(label: 'Badge'),
          const _ComingSoonTab(label: 'Action'),
          const _ComingSoonTab(label: 'Control'),
        ],
      ),
    );
  }
}

class _DashboardTab extends StatelessWidget {
  final bool showBanner;
  final VoidCallback onCloseBanner;
  const _DashboardTab({required this.showBanner, required this.onCloseBanner});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // KITE promo banner
          if (showBanner)
            Container(
              margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'AIMIM',
                          style: TextStyle(
                            color: kPrimaryGreen,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          'à¤ªà¤¤à¤‚à¤— Â· KITE Â· Ù¾ØªÙ†Ú¯',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'All India Majlis E-Ittehadul Muslimeen',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onCloseBanner,
                    child: const Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 10),

          // Stats grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.4,
              children: const [
                _StatCard(
                  title: 'My Rank',
                  value: '#1,240',
                  icon: Icons.leaderboard_outlined,
                ),
                _StatCard(
                  title: 'My Points',
                  value: '5,300 XP',
                  icon: Icons.star_outline,
                ),
                _StatCard(
                  title: 'My Team',
                  value: '399',
                  icon: Icons.group_outlined,
                ),
                _StatCard(
                  title: 'New Members',
                  value: '99',
                  icon: Icons.person_add_outlined,
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Action cards row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: _ActionCard(
                    icon: Icons.how_to_vote_outlined,
                    label: 'Rank Your\nLeader',
                    color: const Color(0xFF2E7D32),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const _RankLeaderScreen(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionCard(
                    icon: Icons.check_circle_outline,
                    label: 'Daily\nCheck-in',
                    color: const Color(0xFF1565C0),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const _DailyCheckinScreen(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionCard(
                    icon: Icons.share_outlined,
                    label: 'Share &\nInvite',
                    color: const Color(0xFF6A1B9A),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ShareInviteScreen(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Growth chart card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'Growth Chart',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'This Month',
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 120,
                  child: CustomPaint(
                    size: const Size(double.infinity, 120),
                    painter: _LineChartPainter(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Opportunities card
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Opportunities',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Volunteer Initiative',
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.group_outlined,
                            color: kPrimaryGreen,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '100K',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: kPrimaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MembershipFormScreen(),
                    ),
                  ),
                  icon: const Icon(
                    Icons.volunteer_activism,
                    size: 16,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Apply Now',
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: kPrimaryGreen, size: 22),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComingSoonTab extends StatelessWidget {
  final String label;
  const _ComingSoonTab({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.construction_outlined,
            color: Colors.white54,
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            '$label â€” Coming Soon',
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kPrimaryGreen
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [kPrimaryGreen.withAlpha(80), kPrimaryGreen.withAlpha(0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    const points = [0.9, 0.7, 0.75, 0.5, 0.55, 0.3, 0.35, 0.2, 0.25, 0.1];
    final dx = size.width / (points.length - 1);

    final linePath = Path();
    final fillPath = Path();

    for (int i = 0; i < points.length; i++) {
      final x = i * dx;
      final y = size.height * points[i];
      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, y);
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, paint);

    // Dots at each point
    final dotPaint = Paint()
      ..color = kPrimaryGreen
      ..style = PaintingStyle.fill;
    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(Offset(i * dx, size.height * points[i]), 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// â”€â”€ Sub-screens accessible from Dashboard â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _DailyCheckinScreen extends StatelessWidget {
  const _DailyCheckinScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        title: const Text(
          'Daily Check-in',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Level card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'LEVEL 3',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 4),
                      Text(
                        'GOLD 200',
                        style: TextStyle(color: Colors.amber, fontSize: 14),
                      ),
                      SizedBox(width: 16),
                      Icon(Icons.bolt, color: Colors.yellow, size: 20),
                      SizedBox(width: 4),
                      Text(
                        '5,300 XP',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: 0.65,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.amber,
                      ),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Today's Tasks & Rewards",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            const SizedBox(height: 12),
            ...[
              ('Check App', '+50 XP', false),
              ('Share Tasks', '+100 XP', true),
              ('Watch a Reel', '+75 XP', false),
              ('Invite to App', '+200 XP', false),
            ].map((t) => _TaskRow(label: t.$1, reward: t.$2, done: t.$3)),
          ],
        ),
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  final String label;
  final String reward;
  final bool done;
  const _TaskRow({
    required this.label,
    required this.reward,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: done ? kPrimaryGreen.withAlpha(20) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: done ? kPrimaryGreen : Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(
            done ? Icons.check_circle : Icons.circle_outlined,
            color: done ? kPrimaryGreen : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: done ? Colors.grey : Colors.black87,
              ),
            ),
          ),
          Text(
            reward,
            style: const TextStyle(
              color: kPrimaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _RankLeaderScreen extends StatefulWidget {
  const _RankLeaderScreen();

  @override
  State<_RankLeaderScreen> createState() => _RankLeaderScreenState();
}

class _RankLeaderScreenState extends State<_RankLeaderScreen> {
  static const _leaders = [
    'Arun Shah',
    'Kabir Khan',
    'Nazma Khan',
    'S Azhar',
    'K R Kappor',
    'Rohit Sharma',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        title: const Text(
          'Rank your Leader',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'AC-50 Â· Dhanghata Vidhan Sabha\nDhanghata, Sant Kbir Nagar, Uttar Pradesh',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Drop in Box for Rank your Leader',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const Text(
              'Your Opinion Matters',
              style: TextStyle(color: Colors.grey, fontSize: 11),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2,
              children: List.generate(
                6,
                (i) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Drag your Leader for Rank',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemCount: _leaders.length,
              itemBuilder: (context, i) => Column(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: kPrimaryGreen,
                    child: Text(
                      _leaders[i][0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _leaders[i],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 11),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You Can only rank one time, one member rank only one time, please do not influence rank with your design, rank your favorite and genuine leader. Ranked 1st leader award with party ticket in the upcoming Vidhan Sabha election.',
              style: TextStyle(color: Colors.grey, fontSize: 10, height: 1.5),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Final Submit',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
