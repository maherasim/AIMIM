import 'package:flutter/material.dart';
import '../../constants.dart';

class ReelSingleScreen extends StatefulWidget {
  final Map<String, String> reel;
  const ReelSingleScreen({super.key, required this.reel});

  @override
  State<ReelSingleScreen> createState() => _ReelSingleScreenState();
}

class _ReelSingleScreenState extends State<ReelSingleScreen> {
  bool _liked = false;
  bool _following = false;
  bool _muted = false;
  int _likeCount = 100;

  void _toggleLike() {
    setState(() {
      _liked = !_liked;
      _likeCount += _liked ? 1 : -1;
    });
  }

  void _toggleFollow() => setState(() => _following = !_following);
  void _toggleMute() => setState(() => _muted = !_muted);

  String _fmt(int n) => n >= 1000 ? '${(n / 1000).toStringAsFixed(0)}K' : '$n';

  void _showComments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.92,
        builder: (_, sc) => Column(children: [
          const SizedBox(height: 8),
          Container(width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 8),
          const Text('Comments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Divider(),
          Expanded(
            child: ListView.builder(
              controller: sc,
              itemCount: 8,
              itemBuilder: (_, i) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: kPrimaryGreen,
                  child: Text(String.fromCharCode(65 + i),
                      style: const TextStyle(color: Colors.white, fontSize: 12)),
                ),
                title: Text('User ${i + 1}',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                subtitle: const Text('Great content! Keep it up 🎉',
                    style: TextStyle(fontSize: 12)),
                trailing: const Icon(Icons.favorite_border, size: 16, color: Colors.grey),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 12, right: 12, bottom: MediaQuery.of(ctx).viewInsets.bottom + 8),
              child: Row(children: [
                const CircleAvatar(radius: 16, backgroundColor: kPrimaryGreen,
                    child: Text('Y', style: TextStyle(color: Colors.white, fontSize: 12))),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      hintStyle: const TextStyle(fontSize: 13),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send, color: kPrimaryGreen),
                    onPressed: () => Navigator.pop(ctx)),
              ]),
            ),
          ),
        ]),
      ),
    );
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
            const Text('Share Reel', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _ShareOption(Icons.chat_rounded, 'WhatsApp', const Color(0xFF25D366)),
              _ShareOption(Icons.send, 'Telegram', const Color(0xFF0088CC)),
              _ShareOption(Icons.facebook, 'Facebook', const Color(0xFF1877F2)),
              _ShareOption(Icons.link, 'Copy Link', Colors.grey),
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
          ListTile(leading: const Icon(Icons.report_outlined), title: const Text('Report'),
              onTap: () { Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Report submitted'))); }),
          ListTile(leading: const Icon(Icons.block), title: const Text('Block user'),
              onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.download_outlined), title: const Text('Save video'),
              onTap: () { Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Video saved'))); }),
          ListTile(leading: const Icon(Icons.close), title: const Text('Cancel'),
              onTap: () => Navigator.pop(context)),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('For you',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_muted ? Icons.volume_off : Icons.volume_up, color: Colors.white),
            onPressed: _toggleMute,
          ),
          IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          // Video area
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.shade900,
            child: const Center(
              child: Icon(Icons.play_circle_fill, color: Colors.white24, size: 80),
            ),
          ),

          // Right action buttons
          Positioned(
            right: 12,
            bottom: 120,
            child: Column(children: [
              // Like
              GestureDetector(
                onTap: _toggleLike,
                child: Column(children: [
                  Icon(_liked ? Icons.favorite : Icons.favorite_border,
                      color: _liked ? Colors.red : Colors.white, size: 28),
                  const SizedBox(height: 2),
                  Text(_fmt(_likeCount),
                      style: const TextStyle(color: Colors.white,
                          fontSize: 11, fontWeight: FontWeight.w600)),
                ]),
              ),
              const SizedBox(height: 20),

              // Comment
              GestureDetector(
                onTap: _showComments,
                child: const Column(children: [
                  Icon(Icons.comment_outlined, color: Colors.white, size: 28),
                  SizedBox(height: 2),
                  Text('10K', style: TextStyle(color: Colors.white,
                      fontSize: 11, fontWeight: FontWeight.w600)),
                ]),
              ),
              const SizedBox(height: 20),

              // Repost
              GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reposted!'))),
                child: const Column(children: [
                  Icon(Icons.repeat_rounded, color: Colors.white, size: 28),
                  SizedBox(height: 2),
                  Text('1K', style: TextStyle(color: Colors.white,
                      fontSize: 11, fontWeight: FontWeight.w600)),
                ]),
              ),
              const SizedBox(height: 20),

              // Stats
              GestureDetector(
                onTap: () {},
                child: const Column(children: [
                  Icon(Icons.bar_chart, color: Colors.white, size: 28),
                  SizedBox(height: 2),
                  Text('200K', style: TextStyle(color: Colors.white,
                      fontSize: 11, fontWeight: FontWeight.w600)),
                ]),
              ),
              const SizedBox(height: 20),

              // Share
              GestureDetector(
                onTap: _showShare,
                child: const Icon(Icons.share_outlined, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 20),

              // More
              GestureDetector(
                onTap: _showMore,
                child: const Icon(Icons.more_horiz, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 20),

              // Grid view
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.grid_view, color: Colors.white, size: 20),
                ),
              ),
            ]),
          ),

          // Bottom author info
          Positioned(
            left: 12, right: 70, bottom: 80,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: kPrimaryGreen,
                  child: Text(widget.reel['author']![0],
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 8),
                Text(widget.reel['author']!,
                    style: const TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(width: 4),
                const Icon(Icons.verified, color: Colors.white70, size: 13),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _toggleFollow,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _following ? kPrimaryGreen : Colors.transparent,
                      border: Border.all(
                          color: _following ? kPrimaryGreen : Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(_following ? 'Following' : 'Follow',
                        style: const TextStyle(color: Colors.white, fontSize: 11)),
                  ),
                ),
              ]),
              const SizedBox(height: 6),
              Text(widget.reel['title']!,
                  style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.4)),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _ShareOption(this.icon, this.label, this.color);

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
          decoration: BoxDecoration(
              color: color.withAlpha(25), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 26),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.black87)),
      ]),
    );
  }
}
