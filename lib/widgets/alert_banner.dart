import 'package:flutter/material.dart';

class AlertBanner extends StatefulWidget {
  const AlertBanner({super.key});

  @override
  State<AlertBanner> createState() => _AlertBannerState();
}

class _AlertBannerState extends State<AlertBanner> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    if (!_visible) return const SizedBox.shrink();
    return Container(
      color: const Color(0xFFB71C1C),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded,
              color: Colors.white, size: 15),
          const SizedBox(width: 6),
          const Expanded(
            child: Text(
              'Beware of fraud, AIMIM never ask OTP, Passcode, or any kind of payments ETC.',
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _visible = false),
            child: const Icon(Icons.close, color: Colors.white, size: 15),
          ),
        ],
      ),
    );
  }
}
