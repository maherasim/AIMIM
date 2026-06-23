import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../widgets/alert_banner.dart';

class ChatSingleScreen extends StatefulWidget {
  final String name;
  const ChatSingleScreen({super.key, required this.name});

  @override
  State<ChatSingleScreen> createState() => _ChatSingleScreenState();
}

class _ChatSingleScreenState extends State<ChatSingleScreen> {
  final _msgController = TextEditingController();

  static const _messages = [
    {'me': false, 'text': 'This is the main chat template', 'time': '9:41 AM'},
    {'me': false, 'text': 'Hmmm', 'time': '9:42 AM'},
    {'me': false, 'text': 'I think I get it', 'time': '9:42 AM'},
    {'me': false, 'text': 'Will head to the Help Center if I have more questions tho', 'time': '9:43 AM'},
    {'me': true, 'text': 'You just edit any text to type in the conversation you want to show, and delete any bubbles you don\'t want to use', 'time': '9:44 AM'},
    {'me': true, 'text': 'Boom!', 'time': '9:44 AM'},
    {'me': false, 'text': 'Oh?', 'time': '9:45 AM'},
    {'me': false, 'text': 'Cool', 'time': '9:45 AM'},
    {'me': false, 'text': 'How does it work?', 'time': '9:46 AM'},
  ];

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white24,
              child: Text(widget.name[0],
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(width: 4),
                      const Icon(Icons.verified,
                          color: Colors.white70, size: 13),
                    ],
                  ),
                  const Text('Online',
                      style:
                          TextStyle(color: Colors.white70, fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.call_outlined, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.videocam_outlined, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          const AlertBanner(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length + 1,
              itemBuilder: (context, i) {
                if (i == 0) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text('Nov 30, 2025, 9:41 AM',
                          style:
                              TextStyle(color: Colors.grey, fontSize: 11)),
                    ),
                  );
                }
                final msg = _messages[i - 1];
                return _ChatBubble(
                  text: msg['text'] as String,
                  isMe: msg['me'] as bool,
                  time: msg['time'] as String,
                );
              },
            ),
          ),
          // Input bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.emoji_emotions_outlined,
                    color: Colors.grey, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    decoration: InputDecoration(
                      hintText: 'Messages',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: kPrimaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.mic, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;
  const _ChatBubble(
      {required this.text, required this.isMe, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.72),
        decoration: BoxDecoration(
          color: isMe ? kPrimaryGreen : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: const Offset(0, 1)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(text,
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black87,
                    fontSize: 13,
                    height: 1.4)),
            const SizedBox(height: 2),
            Text(time,
                style: TextStyle(
                    color: isMe ? Colors.white60 : Colors.grey,
                    fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
