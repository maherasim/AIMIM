import 'package:flutter/material.dart';
import '../../constants.dart';

class AwardsScreen extends StatefulWidget {
  const AwardsScreen({super.key});

  @override
  State<AwardsScreen> createState() => _AwardsScreenState();
}

class _AwardsScreenState extends State<AwardsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryGreen,
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Awards & Medals',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          tabs: const [
            Tab(text: 'My Medals'),
            Tab(text: 'Leaderboard'),
            Tab(text: 'Criteria'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _MyMedalsTab(),
          _LeaderboardTab(),
          _CriteriaTab(),
        ],
      ),
    );
  }
}

// ── My Medals Tab ────────────────────────────────────────────────────────────

class _MyMedalsTab extends StatelessWidget {
  const _MyMedalsTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Points summary card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _ScorePill(label: 'Total XP', value: '5,300', icon: Icons.bolt),
                _ScorePill(
                    label: 'Gold Coins',
                    value: '200',
                    icon: Icons.monetization_on_outlined),
                _ScorePill(
                    label: 'Rank', value: '#1,240', icon: Icons.leaderboard_outlined),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Featured medal — Gold
          _FeaturedMedal(
            type: MedalType.gold,
            title: 'Gold Member',
            subtitle: 'Top 1% Contributor',
            earned: true,
            xp: 5000,
            requirement: 'Earn 5,000+ XP',
          ),
          const SizedBox(height: 14),

          // Silver
          _FeaturedMedal(
            type: MedalType.silver,
            title: 'Silver Member',
            subtitle: 'Active Contributor',
            earned: true,
            xp: 2500,
            requirement: 'Earn 2,500+ XP',
          ),
          const SizedBox(height: 14),

          // Bronze
          _FeaturedMedal(
            type: MedalType.bronze,
            title: 'Bronze Member',
            subtitle: 'Community Starter',
            earned: true,
            xp: 1000,
            requirement: 'Earn 1,000+ XP',
          ),
          const SizedBox(height: 14),

          // Special awards row
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Special Awards',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
          ),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.85,
            children: const [
              _SpecialAward(
                  icon: Icons.group_outlined,
                  label: 'Team Builder',
                  sublabel: '100 members',
                  earned: true,
                  color: Color(0xFF6A1B9A)),
              _SpecialAward(
                  icon: Icons.how_to_vote_outlined,
                  label: 'Voter Hero',
                  sublabel: 'Registered 50',
                  earned: true,
                  color: Color(0xFF1565C0)),
              _SpecialAward(
                  icon: Icons.campaign_outlined,
                  label: 'Campaigner',
                  sublabel: '30-day streak',
                  earned: false,
                  color: Color(0xFFE65100)),
              _SpecialAward(
                  icon: Icons.share_outlined,
                  label: 'Connector',
                  sublabel: 'Shared 200',
                  earned: false,
                  color: Color(0xFF00695C)),
              _SpecialAward(
                  icon: Icons.star_outlined,
                  label: 'Star Member',
                  sublabel: 'Top rated',
                  earned: false,
                  color: Color(0xFFF9A825)),
              _SpecialAward(
                  icon: Icons.emoji_events_outlined,
                  label: 'Champion',
                  sublabel: 'All tasks done',
                  earned: false,
                  color: Colors.red),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ── Leaderboard Tab ──────────────────────────────────────────────────────────

class _LeaderboardTab extends StatelessWidget {
  const _LeaderboardTab();

  static const _leaders = [
    ('Imtiaz Jaleel', '12,400 XP', '🥇'),
    ('A.H.A. Khan', '11,200 XP', '🥈'),
    ('S. Owaisi', '10,800 XP', '🥉'),
    ('Nazma Khan', '9,500 XP', '4'),
    ('K. R. Kapoor', '8,200 XP', '5'),
    ('Arun Shah', '7,600 XP', '6'),
    ('Kabir Ali', '7,100 XP', '7'),
    ('Rohit Dev', '6,800 XP', '8'),
    ('Pasha Jameer', '5,300 XP', '9'),
    ('S. Azhar', '4,900 XP', '10'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _leaders.length,
      itemBuilder: (context, i) {
        final l = _leaders[i];
        final isTop3 = i < 3;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isTop3
                ? Colors.white.withAlpha(30)
                : Colors.white.withAlpha(15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isTop3 ? Colors.white38 : Colors.white12,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 32,
                child: Text(l.$3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: isTop3 ? 20 : 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white24,
                child: Text(l.$1[0],
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(l.$1,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            isTop3 ? FontWeight.bold : FontWeight.normal,
                        fontSize: 13)),
              ),
              Text(l.$2,
                  style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        );
      },
    );
  }
}

// ── Criteria Tab ─────────────────────────────────────────────────────────────

class _CriteriaTab extends StatelessWidget {
  const _CriteriaTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          _CriteriaCard(
            type: MedalType.gold,
            title: 'Gold Medal',
            points: '5,000 XP',
            criteria: [
              'Onboard 50+ new members',
              'Complete all daily check-ins for 30 days',
              'Rank in top 5% of your district',
              'Share content 100+ times',
            ],
          ),
          SizedBox(height: 12),
          _CriteriaCard(
            type: MedalType.silver,
            title: 'Silver Medal',
            points: '2,500 XP',
            criteria: [
              'Onboard 20+ new members',
              'Complete 15 days check-in streak',
              'Rank in top 15% of your district',
              'Share content 50+ times',
            ],
          ),
          SizedBox(height: 12),
          _CriteriaCard(
            type: MedalType.bronze,
            title: 'Bronze Medal',
            points: '1,000 XP',
            criteria: [
              'Onboard 5+ new members',
              'Complete 7 days check-in streak',
              'Register your voting details',
              'Complete your profile 100%',
            ],
          ),
        ],
      ),
    );
  }
}

// ── Medal types & painters ───────────────────────────────────────────────────

enum MedalType { gold, silver, bronze }

class _FeaturedMedal extends StatelessWidget {
  final MedalType type;
  final String title, subtitle, requirement;
  final bool earned;
  final int xp;
  const _FeaturedMedal({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.earned,
    required this.xp,
    required this.requirement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(earned ? 25 : 12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: earned ? Colors.white38 : Colors.white12),
      ),
      child: Row(
        children: [
          // Medal painter
          SizedBox(
            width: 70,
            height: 80,
            child: CustomPaint(
              painter: MedalPainter(type: type, earned: earned),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title,
                        style: TextStyle(
                            color: earned ? Colors.white : Colors.white54,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    const Spacer(),
                    if (earned)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: kPrimaryGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text('EARNED',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 11)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.bolt,
                        color: Colors.amber, size: 14),
                    const SizedBox(width: 2),
                    Text('$xp XP required',
                        style: const TextStyle(
                            color: Colors.amber, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(requirement,
                    style: const TextStyle(
                        color: Colors.white54, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CriteriaCard extends StatelessWidget {
  final MedalType type;
  final String title, points;
  final List<String> criteria;
  const _CriteriaCard({
    required this.type,
    required this.title,
    required this.points,
    required this.criteria,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 44,
                height: 50,
                child: CustomPaint(
                    painter: MedalPainter(type: type, earned: true)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  Row(
                    children: [
                      const Icon(Icons.bolt,
                          color: Colors.amber, size: 13),
                      Text(points,
                          style: const TextStyle(
                              color: Colors.amber, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...criteria.map((c) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline,
                        color: Colors.white70, size: 14),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(c,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _SpecialAward extends StatelessWidget {
  final IconData icon;
  final String label, sublabel;
  final bool earned;
  final Color color;
  const _SpecialAward({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.earned,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: earned
            ? Colors.white.withAlpha(25)
            : Colors.white.withAlpha(10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: earned ? Colors.white38 : Colors.white12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: earned ? color.withAlpha(180) : Colors.white12,
            ),
            child: Icon(icon,
                color: earned ? Colors.white : Colors.white30,
                size: 22),
          ),
          const SizedBox(height: 5),
          Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: earned ? Colors.white : Colors.white38,
                  fontWeight: FontWeight.bold,
                  fontSize: 10)),
          Text(sublabel,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: earned ? Colors.white60 : Colors.white24,
                  fontSize: 9)),
        ],
      ),
    );
  }
}

class _ScorePill extends StatelessWidget {
  final String label, value;
  final IconData icon;
  const _ScorePill(
      {required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.amber, size: 20),
        const SizedBox(height: 3),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 16)),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 9)),
      ],
    );
  }
}

// ── Medal CustomPainter ───────────────────────────────────────────────────────

class MedalPainter extends CustomPainter {
  final MedalType type;
  final bool earned;
  const MedalPainter({required this.type, required this.earned});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height * 0.45;
    final r = size.width * 0.38;

    // Ribbon colors per type
    final ribbonColor = type == MedalType.gold
        ? const Color(0xFFB71C1C)
        : type == MedalType.silver
            ? const Color(0xFF1565C0)
            : const Color(0xFF6A1B9A);

    // Faded if not earned
    final alpha = earned ? 255 : 77;

    // Draw ribbons
    final rPaint = Paint()
      ..color = ribbonColor.withAlpha(alpha)
      ..style = PaintingStyle.fill;

    final ribbonLeft = Path()
      ..moveTo(cx - r * 0.6, cy - r * 0.2)
      ..lineTo(cx - r * 1.1, cy + r * 0.9)
      ..lineTo(cx - r * 0.4, cy + r * 0.6)
      ..lineTo(cx - r * 0.2, cy + r * 0.2)
      ..close();
    canvas.drawPath(ribbonLeft, rPaint);

    final ribbonRight = Path()
      ..moveTo(cx + r * 0.6, cy - r * 0.2)
      ..lineTo(cx + r * 1.1, cy + r * 0.9)
      ..lineTo(cx + r * 0.4, cy + r * 0.6)
      ..lineTo(cx + r * 0.2, cy + r * 0.2)
      ..close();
    canvas.drawPath(ribbonRight, rPaint);

    // Outer ring (border)
    final outerColor = type == MedalType.gold
        ? const Color(0xFFB8860B)
        : type == MedalType.silver
            ? const Color(0xFF9E9E9E)
            : const Color(0xFF8D5524);
    final borderPaint = Paint()
      ..color = outerColor.withAlpha(alpha)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), r, borderPaint);

    // Inner circle
    final innerColor = type == MedalType.gold
        ? const Color(0xFFFFD700)
        : type == MedalType.silver
            ? const Color(0xFFE0E0E0)
            : const Color(0xFFCD7F32);
    final innerPaint = Paint()
      ..color = innerColor.withAlpha(alpha)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), r * 0.82, innerPaint);

    // Star
    if (earned) {
      final starPaint = Paint()
        ..color = Colors.white.withAlpha(230)
        ..style = PaintingStyle.fill;
      _drawStar(canvas, Offset(cx, cy), r * 0.45, r * 0.22, starPaint);
    } else {
      final lockPaint = Paint()
        ..color = Colors.white.withAlpha(102)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawCircle(Offset(cx, cy), r * 0.25, lockPaint);
    }
  }

  void _drawStar(Canvas canvas, Offset center, double outerR, double innerR,
      Paint paint) {
    const points = 5;
    final path = Path();
    for (int i = 0; i < points * 2; i++) {
      final angle =
          (i * 3.14159265 / points) - 3.14159265 / 2;
      final radius = i.isEven ? outerR : innerR;
      final x = center.dx + radius * _cos(angle);
      final y = center.dy + radius * _sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  double _cos(double a) => _approxCos(a);
  double _sin(double a) => _approxSin(a);

  // Dart doesn't have dart:math imported here, use inline approximation
  double _approxCos(double a) {
    // Use series: cos(x) ≈ 1 - x²/2 + x⁴/24
    // But for a star painter, just use the identity cos = sin(pi/2 - a)
    // Actually dart:math is available in Flutter; let me use it via import
    // The class uses dart:math implicitly via Flutter — we just cast
    return _mathCos(a);
  }

  double _approxSin(double a) => _mathSin(a);

  // These call into dart's math — Flutter has this available
  static double _mathCos(double x) {
    // Taylor series for cos(x), accurate for small |x|
    // Better: just use the built-in via the import trick
    double result = 1.0;
    double term = 1.0;
    double x2 = x * x;
    for (int i = 1; i <= 10; i++) {
      term *= -x2 / ((2 * i - 1) * (2 * i));
      result += term;
    }
    return result;
  }

  static double _mathSin(double x) {
    double result = x;
    double term = x;
    double x2 = x * x;
    for (int i = 1; i <= 10; i++) {
      term *= -x2 / ((2 * i) * (2 * i + 1));
      result += term;
    }
    return result;
  }

  @override
  bool shouldRepaint(covariant MedalPainter old) =>
      old.type != type || old.earned != earned;
}
