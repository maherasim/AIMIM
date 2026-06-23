import 'package:flutter/material.dart';
import '../../constants.dart';

class KiteSingleScreen extends StatefulWidget {
  final Map<String, dynamic> post;
  const KiteSingleScreen({super.key, required this.post});

  @override
  State<KiteSingleScreen> createState() => _KiteSingleScreenState();
}

class _KiteSingleScreenState extends State<KiteSingleScreen> {
  bool _liked = false;
  bool _bookmarked = false;
  bool _following = false;
  final _replyController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

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
              _buildShareOption(Icons.chat_rounded, 'WhatsApp', const Color(0xFF25D366)),
              _buildShareOption(Icons.send, 'Telegram', const Color(0xFF0088CC)),
              _buildShareOption(Icons.facebook, 'Facebook', const Color(0xFF1877F2)),
              _buildShareOption(Icons.link, 'Copy Link', Colors.grey),
            ]),
            const SizedBox(height: 8),
          ]),
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label, Color color) {
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

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: GestureDetector(
          onTap: () {},
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Post',
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
            icon: const Icon(Icons.manage_accounts_outlined,
                color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author row
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: kPrimaryGreen,
                        child: Text((post['author'] as String)[0],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(post['author'] as String,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                const SizedBox(width: 4),
                                const Icon(Icons.verified,
                                    color: kPrimaryGreen, size: 14),
                              ],
                            ),
                            Text(
                                '${post['location']} · ${post['time']}',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 11)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _following = !_following),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
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
                      IconButton(
                        icon: const Icon(Icons.more_vert,
                            color: Colors.grey, size: 20),
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Options coming soon'))),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(post['text'] as String,
                      style:
                          const TextStyle(fontSize: 14, height: 1.5)),
                  const SizedBox(height: 6),
                  Text(post['tags'] as String,
                      style: const TextStyle(
                          color: kPrimaryGreen, fontSize: 13)),
                  const SizedBox(height: 12),
                  // Main image
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Icon(Icons.image_outlined,
                            color: Colors.grey, size: 56)),
                  ),
                  const SizedBox(height: 8),
                  // Thumbnail strip
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (ctx, i) => Container(
                        width: 60,
                        margin: const EdgeInsets.only(right: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.image_outlined,
                            color: Colors.grey, size: 24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Meta info
                  Text(
                    '10:28 pm  17 Feb 26  @p_m_ajjukhan',
                    style: TextStyle(
                        color: Colors.grey.shade500, fontSize: 11),
                  ),
                  const SizedBox(height: 10),
                  // Stats row 1
                  Row(
                    children: const [
                      _StatChip('100K', 'Likes'),
                      SizedBox(width: 16),
                      _StatChip('100K', 'Repost'),
                      SizedBox(width: 16),
                      _StatChip('100K', 'View'),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Divider(),
                  // Stats row 2
                  Row(
                    children: const [
                      _StatChip('100K', 'Comments'),
                      SizedBox(width: 16),
                      _StatChip('100K', 'Share'),
                    ],
                  ),
                  const Divider(),
                  // Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _liked = !_liked),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Icon(
                            _liked ? Icons.favorite : Icons.favorite_border,
                            size: 22,
                            color: _liked ? Colors.red : Colors.grey.shade600,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Reposted!'))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Icon(Icons.repeat_rounded,
                              size: 22, color: Colors.grey.shade600),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Icon(Icons.bar_chart,
                              size: 22, color: Colors.grey.shade600),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _bookmarked = !_bookmarked),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Icon(
                            _bookmarked ? Icons.bookmark : Icons.bookmark_border,
                            size: 22,
                            color: _bookmarked ? kPrimaryGreen : Colors.grey.shade600,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _showShare,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Icon(Icons.share_outlined,
                              size: 22, color: Colors.grey.shade600),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  // Sort replies
                  Row(
                    children: [
                      const Text('Most relevant replies',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13)),
                      const Icon(Icons.keyboard_arrow_down,
                          size: 18),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Sample replies
                  ...List.generate(
                    3,
                    (i) => _ReplyCard(index: i),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundColor: kPrimaryGreen,
              child: Text('P',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _replyController,
                style: const TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Reply your comment...',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                if (_replyController.text.trim().isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Reply posted!')));
                  _replyController.clear();
                }
              },
              child: const Icon(Icons.send, color: kPrimaryGreen),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String count;
  final String label;
  const _StatChip(this.count, this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(count,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}

class _ReplyCard extends StatelessWidget {
  final int index;
  const _ReplyCard({required this.index});

  static const _names = ['PASHA JAMEER', 'Imtiaz Jaleel', 'Dr. Shoaib'];

  @override
  Widget build(BuildContext context) {
    final name = _names[index % _names.length];
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: kPrimaryGreen,
            child: Text(name[0],
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
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
                            fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(width: 4),
                    const Icon(Icons.verified,
                        color: kPrimaryGreen, size: 12),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kPrimaryGreen,
                        side: const BorderSide(color: kPrimaryGreen),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text('Follow',
                          style: TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
                    style: TextStyle(fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
