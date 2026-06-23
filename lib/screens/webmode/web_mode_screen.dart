import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../widgets/ad_banner.dart';

class WebModeScreen extends StatefulWidget {
  const WebModeScreen({super.key});

  @override
  State<WebModeScreen> createState() => _WebModeScreenState();
}

class _WebModeScreenState extends State<WebModeScreen> {
  bool _showOfflineBanner = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // ── Browser top bar ────────────────────────────────────
            _BrowserBar(
              onRefresh: () =>
                  setState(() => _showOfflineBanner = !_showOfflineBanner),
            ),

            // ── No internet banner ─────────────────────────────────
            if (_showOfflineBanner)
              GestureDetector(
                onTap: () => setState(() => _showOfflineBanner = false),
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFFFFF3CD),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  child: Row(
                    children: const [
                      Icon(Icons.wifi_off,
                          size: 14, color: Color(0xFF856404)),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text('No Internet connection',
                            style: TextStyle(
                                color: Color(0xFF856404),
                                fontSize: 11,
                                fontWeight: FontWeight.w600)),
                      ),
                      Icon(Icons.close,
                          size: 14, color: Color(0xFF856404)),
                    ],
                  ),
                ),
              ),

            // ── Web content ────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Hero banner
                    Stack(
                      children: [
                        Container(
                          height: 180,
                          width: double.infinity,
                          color: kDarkGreen,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/logo_round.png',
                                height: 70,
                                errorBuilder: (c, e, s) =>
                                    const CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.white,
                                  child: Text('A',
                                      style: TextStyle(
                                          color: kPrimaryGreen,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 30)),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text('AIMIM',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 26,
                                      letterSpacing: 4)),
                              const Text(
                                  'All India Majlis-E-Ittehadul Muslimeen',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 10)),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('Banner AD',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9)),
                          ),
                        ),
                      ],
                    ),

                    // Welcome + Follow row
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Welcome  👋',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                Text(
                                    'National Membership Platform',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 11)),
                              ],
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.person_add_outlined,
                                size: 14, color: Colors.white),
                            label: const Text('Follow us',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),

                    // Become a Member banner
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        color: kPrimaryGreen,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.card_membership,
                                color: Colors.white, size: 16),
                            SizedBox(width: 8),
                            Text('Become a Member',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.white70, size: 12),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // User card
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 22,
                            backgroundColor: kPrimaryGreen,
                            child: Text('A',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('A. H. A. KHAN',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                                Text('Member ID: 302-123456',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 11)),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.share_outlined,
                                color: kPrimaryGreen),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_vert,
                                color: Colors.grey),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Community stats
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('AIMIM MEMBER APP',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: kDarkGreen)),
                          const SizedBox(height: 12),
                          Row(
                            children: const [
                              _StatChip(
                                  value: '100K',
                                  label: 'Members',
                                  color: kPrimaryGreen),
                              SizedBox(width: 8),
                              _StatChip(
                                  value: '10K',
                                  label: 'Active',
                                  color: Color(0xFF1565C0)),
                              SizedBox(width: 8),
                              _StatChip(
                                  value: '42M+',
                                  label: 'Followers',
                                  color: Color(0xFFD32F2F)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // AIMIM Community platforms
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('AIMIM COMMUNITY ON THIS APP',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: kDarkGreen)),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            children: [
                              _PlatformIcon(
                                  label: 'KITE', sublabel: 'पतंग'),
                              _PlatformIcon(
                                  label: 'Reels', sublabel: 'Videos'),
                              _PlatformIcon(
                                  label: 'Chats', sublabel: 'P2P'),
                              _PlatformIcon(
                                  label: 'Dash', sublabel: 'Control'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    const AdBanner(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // ── Browser bottom bar ─────────────────────────────────
            _BrowserBottomBar(),
          ],
        ),
      ),
    );
  }
}

// ── Browser UI components ────────────────────────────────────────────────────

class _BrowserBar extends StatelessWidget {
  final VoidCallback onRefresh;
  const _BrowserBar({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kDarkGreen,
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
      child: Row(
        children: [
          // QR code icon
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_outlined,
                color: Colors.white, size: 22),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          // URL bar
          Expanded(
            child: Container(
              height: 36,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  const Icon(Icons.lock_outlined,
                      size: 13, color: kPrimaryGreen),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Text(
                      'aimim.app · National Membership',
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh,
                        size: 16, color: Colors.grey),
                    onPressed: onRefresh,
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(minWidth: 28, minHeight: 28),
                  ),
                ],
              ),
            ),
          ),
          // Download / share
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: kPrimaryGreen,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: const [
                Icon(Icons.download_outlined,
                    color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text('App',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BrowserBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kDarkGreen,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                color: Colors.white, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_outlined,
                color: Colors.white38, size: 18),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.home_outlined,
                color: Colors.white, size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.tab_outlined,
                color: Colors.white, size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz,
                color: Colors.white, size: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// ── Small stat/platform widgets ──────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final String value, label;
  final Color color;
  const _StatChip(
      {required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withAlpha(18),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withAlpha(40)),
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w900,
                    fontSize: 18)),
            Text(label,
                style:
                    TextStyle(color: color.withAlpha(180), fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

class _PlatformIcon extends StatelessWidget {
  final String label, sublabel;
  const _PlatformIcon({required this.label, required this.sublabel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: kPrimaryGreen.withAlpha(18),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kPrimaryGreen.withAlpha(40)),
          ),
          child: const Icon(Icons.filter_frames_outlined,
              color: kPrimaryGreen, size: 26),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 11)),
        Text(sublabel,
            style: const TextStyle(color: Colors.grey, fontSize: 9)),
      ],
    );
  }
}
