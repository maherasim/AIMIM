import 'dart:io';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'kite_single_screen.dart';
import 'kite_create_screen.dart';

class KiteScreen extends StatefulWidget {
  const KiteScreen({super.key});

  @override
  State<KiteScreen> createState() => _KiteScreenState();
}

class _KiteScreenState extends State<KiteScreen> {
  final List<Map<String, dynamic>> _posts = [
    {
      'author': 'PASHA JAMEER',
      'handle': '@PashaJaam',
      'time': '1 week ago',
      'location': 'UP',
      'text': 'This is the text and image based headline of news feed post with maximum of 160 words length.',
      'tags': '#160_World #NewPost @mention hyperlink added in this post',
      'images': 4,
      'imagePaths': <String>[],
    },
    {
      'author': 'Imtiaz Jaleel',
      'handle': '@imtiaz_jaleel',
      'time': '2 days ago',
      'location': 'Maharashtra',
      'text': 'AIMIM is committed to true democracy where every citizen matters, beyond identity and religion.',
      'tags': '#AIMIM #Democracy @AsaduddinOwaisi',
      'images': 1,
      'imagePaths': <String>[],
    },
    {
      'author': 'Dr. Shoaib Jemai',
      'handle': '@dr_shoaib',
      'time': '3 days ago',
      'location': 'Delhi',
      'text': 'Community development work ongoing in our constituency. Join us to make a difference.',
      'tags': '#Community #Development #Delhi',
      'images': 2,
      'imagePaths': <String>[],
    },
  ];

  Future<void> _openCreate() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const KiteCreateScreen()),
    );
    if (result != null && mounted) {
      setState(() => _posts.insert(0, result));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreate,
        backgroundColor: kPrimaryGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        elevation: 0,
        leading: const SizedBox.shrink(),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('For you',
                style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold, fontSize: 16)),
            Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, i) => _KitePostCard(
          key: ValueKey(i),
          post: _posts[i],
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => KiteSingleScreen(post: _posts[i]),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Stateful post card with like / bookmark / follow toggles ──────────────────

class _KitePostCard extends StatefulWidget {
  final Map<String, dynamic> post;
  final VoidCallback onTap;
  const _KitePostCard({super.key, required this.post, required this.onTap});

  @override
  State<_KitePostCard> createState() => _KitePostCardState();
}

class _KitePostCardState extends State<_KitePostCard> {
  bool _liked = false;
  bool _bookmarked = false;
  bool _following = false;
  int _likeCount = 100;

  void _showShare() {
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
            const Text('Share Post',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _ShareIcon(Icons.chat_rounded, 'WhatsApp', const Color(0xFF25D366)),
              _ShareIcon(Icons.send, 'Telegram', const Color(0xFF0088CC)),
              _ShareIcon(Icons.facebook, 'Facebook', const Color(0xFF1877F2)),
              _ShareIcon(Icons.link, 'Copy Link', Colors.grey),
            ]),
            const SizedBox(height: 8),
          ]),
        ),
      ),
    );
  }

  void _showMore() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(leading: const Icon(Icons.bookmark_add_outlined),
              title: Text(_bookmarked ? 'Remove bookmark' : 'Bookmark post'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _bookmarked = !_bookmarked);
              }),
          ListTile(leading: const Icon(Icons.report_outlined, color: Colors.orange),
              title: const Text('Report post'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Report submitted')));
              }),
          ListTile(leading: const Icon(Icons.close),
              title: const Text('Cancel'),
              onTap: () => Navigator.pop(context)),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final imgCount = (post['images'] as int?) ?? 0;
    final imagePaths = (post['imagePaths'] as List?)?.cast<String>() ?? <String>[];
    final hasRealImages = imagePaths.isNotEmpty;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          // Author row
          Row(children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: kPrimaryGreen,
              child: Text((post['author'] as String)[0],
                  style: const TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Flexible(
                        child: Text(post['author'] as String,
                            style: const TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 13),
                            overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.verified, color: kPrimaryGreen, size: 13),
                    ]),
                    Text('${post['location']} · ${post['time']}',
                        style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  ]),
            ),
            GestureDetector(
              onTap: () => setState(() => _following = !_following),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _following ? kPrimaryGreen : Colors.transparent,
                  border: Border.all(color: kPrimaryGreen),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(_following ? 'Following' : 'Follow',
                    style: TextStyle(
                        fontSize: 12,
                        color: _following ? Colors.white : kPrimaryGreen,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: _showMore,
              child: const Icon(Icons.more_vert, color: Colors.grey, size: 20),
            ),
          ]),

          const SizedBox(height: 10),

          // Post text
          Text(post['text'] as String,
              style: const TextStyle(fontSize: 13, height: 1.45)),

          // Tags
          if ((post['tags'] as String?)?.isNotEmpty == true) ...[
            const SizedBox(height: 6),
            Text(post['tags'] as String,
                style: const TextStyle(color: kPrimaryGreen, fontSize: 12)),
          ],

          const SizedBox(height: 10),

          // Images
          if (hasRealImages) ...[
            _buildRealImages(imagePaths),
            const SizedBox(height: 10),
          ] else if (imgCount > 0) ...[
            _buildPlaceholderImages(imgCount),
            const SizedBox(height: 10),
          ],

          // Action row
          Row(children: [
            // Like
            GestureDetector(
              onTap: () => setState(() {
                _liked = !_liked;
                _likeCount += _liked ? 1 : -1;
              }),
              child: Row(children: [
                Icon(_liked ? Icons.favorite : Icons.favorite_border,
                    size: 17,
                    color: _liked ? Colors.red : Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(_liked ? '${_likeCount}K' : '100K',
                    style: TextStyle(fontSize: 12,
                        color: _liked ? Colors.red : Colors.grey.shade600)),
              ]),
            ),
            const SizedBox(width: 16),

            // Comment (opens detail)
            GestureDetector(
              onTap: widget.onTap,
              child: Row(children: [
                Icon(Icons.comment_outlined, size: 17,
                    color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text('10K', style: TextStyle(fontSize: 12,
                    color: Colors.grey.shade600)),
              ]),
            ),
            const SizedBox(width: 16),

            // Repost
            GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Reposted!'))),
              child: Row(children: [
                Icon(Icons.repeat_rounded, size: 17,
                    color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text('1K', style: TextStyle(fontSize: 12,
                    color: Colors.grey.shade600)),
              ]),
            ),
            const SizedBox(width: 16),

            // Bookmark
            GestureDetector(
              onTap: () => setState(() => _bookmarked = !_bookmarked),
              child: Icon(
                _bookmarked ? Icons.bookmark : Icons.bookmark_border,
                size: 17,
                color: _bookmarked ? kPrimaryGreen : Colors.grey.shade600,
              ),
            ),

            const Spacer(),

            // Share
            GestureDetector(
              onTap: _showShare,
              child: Icon(Icons.share_outlined, size: 18,
                  color: Colors.grey.shade600),
            ),
          ]),
        ]),
      ),
    );
  }

  Widget _buildRealImages(List<String> paths) {
    if (paths.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(File(paths[0]),
            width: double.infinity, height: 180, fit: BoxFit.cover),
      );
    }
    return SizedBox(
      height: 180,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        children: paths.take(4).map((p) => ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.file(File(p), fit: BoxFit.cover),
        )).toList(),
      ),
    );
  }

  Widget _buildPlaceholderImages(int count) {
    if (count == 1) {
      return Container(
        height: 180,
        decoration: BoxDecoration(color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)),
        child: const Center(child: Icon(Icons.image_outlined,
            color: Colors.grey, size: 48)),
      );
    }
    return SizedBox(
      height: 180,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        children: List.generate(count > 4 ? 4 : count, (_) =>
            Container(
              decoration: BoxDecoration(color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6)),
              child: const Icon(Icons.image_outlined, color: Colors.grey),
            )),
      ),
    );
  }
}

// ── Share icon helper ─────────────────────────────────────────────────────────

class _ShareIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _ShareIcon(this.icon, this.label, this.color);

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
          decoration: BoxDecoration(color: color.withAlpha(25),
              shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 26),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.black87)),
      ]),
    );
  }
}
