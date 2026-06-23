import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants.dart';

class KiteCreateScreen extends StatefulWidget {
  const KiteCreateScreen({super.key});

  @override
  State<KiteCreateScreen> createState() => _KiteCreateScreenState();
}

class _KiteCreateScreenState extends State<KiteCreateScreen> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  String _audience = 'Everyone';
  final List<XFile> _images = [];
  final _picker = ImagePicker();
  static const _maxChars = 280;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  int get _remaining => _maxChars - _textController.text.length;
  bool get _canPost => _textController.text.trim().isNotEmpty && _remaining >= 0;

  Future<void> _pickFromGallery() async {
    if (_images.length >= 4) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Max 4 images per post')));
      return;
    }
    final picked = await _picker.pickMultiImage(imageQuality: 85);
    if (picked.isNotEmpty) {
      setState(() {
        final canAdd = 4 - _images.length;
        _images.addAll(picked.take(canAdd));
      });
    }
  }

  Future<void> _pickFromCamera() async {
    if (_images.length >= 4) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Max 4 images per post')));
      return;
    }
    final picked = await _picker.pickImage(
        source: ImageSource.camera, imageQuality: 85);
    if (picked != null) {
      setState(() => _images.add(picked));
    }
  }

  void _removeImage(int i) => setState(() => _images.removeAt(i));

  void _showAudienceSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A2535),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 12),
          const Text('Who can see this post?',
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          ...[
            ('Everyone', Icons.public, 'Anyone on AIMIM can see'),
            ('Followers', Icons.group_outlined, 'Only your followers'),
            ('Members Only', Icons.verified_user_outlined, 'Verified members only'),
          ].map((opt) => ListTile(
            leading: Icon(opt.$2, color: _audience == opt.$1
                ? kPrimaryGreen : Colors.white60),
            title: Text(opt.$1,
                style: TextStyle(
                    color: _audience == opt.$1 ? kPrimaryGreen : Colors.white,
                    fontWeight: _audience == opt.$1
                        ? FontWeight.bold : FontWeight.normal)),
            subtitle: Text(opt.$3,
                style: const TextStyle(color: Colors.white38, fontSize: 11)),
            trailing: _audience == opt.$1
                ? const Icon(Icons.check_circle, color: kPrimaryGreen)
                : null,
            onTap: () {
              setState(() => _audience = opt.$1);
              Navigator.pop(context);
            },
          )),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }

  void _saveDraft() {
    if (_textController.text.trim().isEmpty) {
      Navigator.pop(context);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Draft saved'),
            backgroundColor: Color(0xFF1A6B45)));
    Navigator.pop(context);
  }

  void _submitPost() {
    if (!_canPost) return;
    final post = {
      'author': 'P.M.A. KHAN',
      'handle': '@p_m_ajjukhan',
      'time': 'Just now',
      'location': 'My Location',
      'text': _textController.text.trim(),
      'tags': _extractTags(_textController.text),
      'images': _images.length,
      'imagePaths': _images.map((f) => f.path).toList(),
      'audience': _audience,
    };
    Navigator.pop(context, post);
  }

  String _extractTags(String text) {
    final regex = RegExp(r'#\w+');
    return regex.allMatches(text).map((m) => m.group(0)).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final charFraction = _textController.text.length / _maxChars;
    final charColor = _remaining < 0
        ? Colors.red
        : _remaining < 20
            ? Colors.orange
            : Colors.white38;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1B2A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            if (_textController.text.trim().isNotEmpty || _images.isNotEmpty) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: const Color(0xFF1A2535),
                  title: const Text('Discard post?',
                      style: TextStyle(color: Colors.white)),
                  content: const Text('Your draft will be lost.',
                      style: TextStyle(color: Colors.white70)),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _saveDraft();
                      },
                      child: const Text('Save draft',
                          style: TextStyle(color: kPrimaryGreen)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('Discard',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Image.asset(
          'assets/images/logo_round.png',
          height: 30,
          errorBuilder: (c, e, s) => const Text('AIMIM',
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold, letterSpacing: 2)),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _saveDraft,
            child: const Text('Drafts',
                style: TextStyle(color: Colors.white70, fontSize: 13)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ElevatedButton(
              onPressed: _canPost ? _submitPost : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryGreen,
                disabledBackgroundColor: kPrimaryGreen.withAlpha(80),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Post',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
        ],
      ),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: kPrimaryGreen,
                      child: Text('P',
                          style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Audience selector
                          GestureDetector(
                            onTap: _showAudienceSheet,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: kPrimaryGreen.withAlpha(180)),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(_audience,
                                        style: const TextStyle(
                                            color: kPrimaryGreen,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600)),
                                    const Icon(Icons.keyboard_arrow_down,
                                        color: kPrimaryGreen, size: 16),
                                  ]),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Text input
                          TextField(
                            controller: _textController,
                            focusNode: _focusNode,
                            maxLines: null,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                            decoration: const InputDecoration(
                              hintText: 'What\'s happening?',
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 15),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Selected images preview
              if (_images.isNotEmpty) ...[
                const SizedBox(height: 12),
                SizedBox(
                  height: _images.length == 1 ? 200 : 140,
                  child: _images.length == 1
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(_images[0].path),
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(top: 6, right: 6,
                              child: _RemoveBtn(onTap: () => _removeImage(0))),
                          ]),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          itemCount: _images.length,
                          itemBuilder: (_, i) => Container(
                            width: 120,
                            margin: const EdgeInsets.only(right: 8),
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(_images[i].path),
                                  width: 120, height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(top: 4, right: 4,
                                  child: _RemoveBtn(onTap: () => _removeImage(i))),
                            ]),
                          ),
                        ),
                ),
              ],
            ]),
          ),
        ),

        // Bottom toolbar
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0D1B2A),
            border: Border(top: BorderSide(color: Colors.white12)),
          ),
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
          child: SafeArea(
            top: false,
            child: Column(children: [
              // Audience / schedule row
              Row(children: [
                const Icon(Icons.public, color: Colors.white54, size: 18),
                const SizedBox(width: 6),
                const Text('Everyone can comment',
                    style: TextStyle(color: Colors.white54, fontSize: 12)),
                const Spacer(),
                // Character counter
                SizedBox(
                  width: 28, height: 28,
                  child: Stack(alignment: Alignment.center, children: [
                    CircularProgressIndicator(
                      value: charFraction.clamp(0.0, 1.0),
                      strokeWidth: 2.5,
                      backgroundColor: Colors.white12,
                      color: charColor,
                    ),
                    if (_remaining <= 20)
                      Text('$_remaining',
                          style: TextStyle(
                              color: charColor, fontSize: 9,
                              fontWeight: FontWeight.bold)),
                  ]),
                ),
              ]),
              const SizedBox(height: 8),
              // Media icons
              Row(children: [
                GestureDetector(
                  onTap: _pickFromGallery,
                  child: const Icon(Icons.image_outlined,
                      color: kPrimaryGreen, size: 24),
                ),
                const SizedBox(width: 18),
                GestureDetector(
                  onTap: _pickFromCamera,
                  child: const Icon(Icons.camera_alt_outlined,
                      color: kPrimaryGreen, size: 24),
                ),
                const SizedBox(width: 18),
                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('GIF picker coming soon'))),
                  child: const Icon(Icons.card_giftcard_outlined,
                      color: Colors.white54, size: 22),
                ),
                const SizedBox(width: 18),
                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Location added'))),
                  child: const Icon(Icons.location_on_outlined,
                      color: Colors.white54, size: 22),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _saveDraft,
                  child: const Text('Save draft',
                      style: TextStyle(color: kPrimaryGreen,
                          fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ]),
            ]),
          ),
        ),
      ]),
    );
  }
}

class _RemoveBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _RemoveBtn({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26, height: 26,
        decoration: BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white54),
        ),
        child: const Icon(Icons.close, color: Colors.white, size: 14),
      ),
    );
  }
}
