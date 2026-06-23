import 'package:flutter/material.dart';
import '../../constants.dart';
import 'reel_single_screen.dart';
import 'reels_create_screen.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  static const _stories = [
    {'name': 'AIMIM', 'color': 0xFF1A6B45},
    {'name': 'Asaduddin', 'color': 0xFF2E7D32},
    {'name': 'Imtiaz', 'color': 0xFF388E3C},
    {'name': 'Dr.Shoaib', 'color': 0xFF43A047},
    {'name': 'Shaukat', 'color': 0xFF4CAF50},
  ];

  static const _reels = [
    {'author': 'PASHA JAMEER', 'handle': '@pasha_jaam', 'location': 'UP Â· Yesterday', 'title': 'This is Video Reels New Volume By Big News Todays...'},
    {'author': 'Imtiaz Jaleel', 'handle': '@imtiaz_jaleel', 'location': 'Maharashtra Â· 2 days ago', 'title': 'AIMIM Press Conference â€” Watch Full Coverage...'},
    {'author': 'Dr. Shoaib', 'handle': '@dr_shoaib', 'location': 'Delhi Â· 3 days ago', 'title': 'Community Development Updates from Hyderabad...'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ReelsCreateScreen()),
        ),
        backgroundColor: kPrimaryGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        elevation: 0,
        leading: const SizedBox.shrink(),
        title: GestureDetector(
          onTap: () {},
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('For you',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              Icon(Icons.keyboard_arrow_down, color: Colors.white),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          // Stories row
          Container(
            color: kPrimaryGreen,
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _stories.length,
                itemBuilder: (context, i) {
                  final s = _stories[i];
                  return Container(
                    width: 60,
                    margin: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white, width: 2),
                            color: Color(s['color'] as int),
                          ),
                          child: Center(
                            child: Text(
                              (s['name'] as String)[0],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          s['name'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 9),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // Reels list
          ..._reels.asMap().entries.map((e) => _ReelCard(
                reel: e.value,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ReelSingleScreen(reel: e.value),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class _ReelCard extends StatelessWidget {
  final Map<String, String> reel;
  final VoidCallback onTap;
  const _ReelCard({required this.reel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author row
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: kPrimaryGreen,
                    child: Text(reel['author']![0],
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(reel['author']!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                            const SizedBox(width: 4),
                            const Icon(Icons.verified,
                                color: kPrimaryGreen, size: 13),
                          ],
                        ),
                        Text(reel['handle']!,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: kPrimaryGreen,
                      side: const BorderSide(color: kPrimaryGreen),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('Follow',
                        style: TextStyle(fontSize: 12)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert,
                        color: Colors.grey, size: 20),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Text(reel['location']!,
                  style: const TextStyle(
                      color: Colors.grey, fontSize: 11)),
            ),
            // Video placeholder
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.grey.shade800,
              child: Stack(
                children: [
                  const Center(
                    child: Icon(Icons.play_circle_fill,
                        color: Colors.white54, size: 60),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('LIVE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(Icons.volume_up,
                        color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Text(reel['title']!,
                  style: const TextStyle(fontSize: 13, height: 1.4)),
            ),
          ],
        ),
      ),
    );
  }
}

