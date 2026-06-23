import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/pin_input_row.dart';
import '../widgets/onboarding_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idController = TextEditingController();
  final _pinKey = GlobalKey<PinInputRowState>();
  bool _rememberMe = false;
  bool _obscurePin = true;

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGreen,
      body: Column(
        children: [
          // ── Green header ───────────────────────────────────────────
          OnboardingHeader(
            onSkip: () =>
                Navigator.pushReplacementNamed(context, '/home'),
          ),

          // ── White form card ────────────────────────────────────────
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Login with Passcode
                    Row(
                      children: [
                        const Icon(Icons.person_outline,
                            size: 15, color: kPrimaryGreen),
                        const SizedBox(width: 5),
                        const Text(
                          'Login with Passcode',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        const Text(' *',
                            style:
                                TextStyle(color: Colors.red, fontSize: 13)),
                        const Spacer(),
                        const Text(
                          'SAFE & SECURE',
                          style: TextStyle(
                              color: kPrimaryGreen,
                              fontSize: 10,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // ID input
                    TextField(
                      controller: _idController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 13),
                      decoration: _inputDecoration(
                          'Enter member Id, mobile number or email'),
                    ),
                    const SizedBox(height: 16),

                    // Passcode label
                    Row(
                      children: [
                        const Icon(Icons.lock_outline,
                            size: 15, color: kPrimaryGreen),
                        const SizedBox(width: 5),
                        const Text('Passcode',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600)),
                        const Text(' *',
                            style:
                                TextStyle(color: Colors.red, fontSize: 13)),
                        const Spacer(),
                        const Text(
                          'ENTER YOUR 6 DIGIT PIN',
                          style: TextStyle(
                              color: kPrimaryGreen,
                              fontSize: 10,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // PIN row + eye toggle
                    Row(
                      children: [
                        Expanded(
                          child: PinInputRow(
                            key: _pinKey,
                            obscure: _obscurePin,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () =>
                              setState(() => _obscurePin = !_obscurePin),
                          child: Icon(
                            _obscurePin
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Remember me + Need help
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: _rememberMe,
                            onChanged: (v) =>
                                setState(() => _rememberMe = v ?? false),
                            activeColor: kPrimaryGreen,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text('REMEMBER ME.',
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w600)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'NEED HELP?',
                            style: TextStyle(
                                color: kPrimaryGreen,
                                fontSize: 11,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Fingerprint + LOGIN NOW
                    Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: kDarkGreen,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(Icons.fingerprint,
                              color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () =>
                                  Navigator.pushReplacementNamed(
                                      context, '/home'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryGreen,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'LOGIN NOW',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    SocialButton(
                      label: 'Login with WhatsApp',
                      color: kWhatsAppGreen,
                      icon: Icons.chat_rounded,
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),

                    SocialButton(
                      label: 'Login with Google',
                      color: const Color(0xFF1A1A1A),
                      icon: Icons.g_mobiledata_rounded,
                      onTap: () {},
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),

          // ── Dark bottom ────────────────────────────────────────────
          Container(
            color: kDarkGreen,
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/register'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white38),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'CREATE A NEW ACCOUNT',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const TermsText(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kPrimaryGreen),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }
}
