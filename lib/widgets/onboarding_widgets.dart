import 'package:flutter/material.dart';
import '../constants.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onTap;
  const SkipButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white38),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white10,
        ),
        child: const Text(
          'SKIP',
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const SocialButton({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white, size: 22),
        label: Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}

class TermsText extends StatelessWidget {
  const TermsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(color: Colors.white38, fontSize: 10),
        children: [
          TextSpan(text: 'BY CONTINUING, YOU ARE AGREEING TO OUR '),
          TextSpan(
            text: 'TERMS OF USE',
            style: TextStyle(
                color: Colors.lightGreenAccent,
                decoration: TextDecoration.underline),
          ),
          TextSpan(text: ' & '),
          TextSpan(
            text: 'PRIVACY POLICY',
            style: TextStyle(
                color: Colors.lightGreenAccent,
                decoration: TextDecoration.underline),
          ),
          TextSpan(text: '.'),
        ],
      ),
    );
  }
}

class OnboardingHeader extends StatelessWidget {
  final VoidCallback onSkip;
  const OnboardingHeader({super.key, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryGreen,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo_round.png',
                    width: 40,
                    height: 40,
                    errorBuilder: (ctx, err, st) => const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 36),
                  ),
                  const Spacer(),
                  // AIMIM badge pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.filter_frames_outlined,
                            color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text(
                          'AIMIM',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  SkipButton(onTap: onSkip),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'AIMIM',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w900,
                letterSpacing: 6,
              ),
            ),
            const SizedBox(height: 3),
            const Text(
              'ALL INDIA MAJLIS-E-ITTEHADUL MUSLIMEEN',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 8.5,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
