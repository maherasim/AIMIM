import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../widgets/alert_banner.dart';
import 'profile_screen.dart';
import '../awards/awards_screen.dart';
import '../chats/chats_screen.dart';
import '../webmode/web_mode_screen.dart';

class NavMenuDrawer extends StatefulWidget {
  const NavMenuDrawer({super.key});

  @override
  State<NavMenuDrawer> createState() => _NavMenuDrawerState();
}

class _NavMenuDrawerState extends State<NavMenuDrawer> {
  bool _prefsExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // â”€â”€ User profile header â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Container(
            color: kPrimaryGreen,
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              const ProfileScreen(name: 'PASHA JAMEER')),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white24,
                    child: Text('P',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text('PASHA JAMEER',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          SizedBox(width: 4),
                          Icon(Icons.verified, color: Colors.white70, size: 14),
                        ],
                      ),
                      const Text('@PashaJaam',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 12)),
                      const SizedBox(height: 2),
                      const Text('New User Â· Joined May 2025',
                          style:
                              TextStyle(color: Colors.white54, fontSize: 10)),
                      const Text('Last login 26 November 2025',
                          style:
                              TextStyle(color: Colors.white54, fontSize: 10)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const AlertBanner(),

                // Location row
                Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          color: kPrimaryGreen, size: 18),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          '580 Lucknow, Uttar Pradesh, 272165',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: kPrimaryGreen,
                          side: const BorderSide(color: kPrimaryGreen),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text('Update',
                            style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                // Account Preferences
                ExpansionTile(
                  leading: const Icon(Icons.manage_accounts_outlined,
                      color: kPrimaryGreen, size: 20),
                  title: const Text('Account Preferences',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13)),
                  initiallyExpanded: _prefsExpanded,
                  onExpansionChanged: (v) =>
                      setState(() => _prefsExpanded = v),
                  children: [
                    _PrefRow(
                        label: 'Current Residence',
                        value: 'Mumbai, Maharashtra'),
                    _PrefRow(
                        label: 'Voting Location',
                        value: 'Noida, Uttar Pradesh'),
                  ],
                ),
                const Divider(height: 1),

                _DrawerItem(
                  icon: Icons.contacts_outlined,
                  title: 'My Contacts',
                  trailing: '1200',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (_) => const ChatsScreen()));
                  },
                ),
                _DrawerItem(
                  icon: Icons.support_agent_outlined,
                  title: 'Support Center',
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Support Center'),
                        content: const Text(
                            'For help, contact us on WhatsApp:\n+91 40 2457 7788\n\nOr email: support@aimim.app'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK',
                                style: TextStyle(color: kPrimaryGreen)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: Icons.settings_outlined,
                  title: 'Advanced Settings',
                  onTap: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16))),
                      builder: (_) => SafeArea(
                        child: Column(mainAxisSize: MainAxisSize.min,
                            children: [
                          ListTile(
                              leading: const Icon(Icons.notifications_outlined),
                              title: const Text('Notification Settings'),
                              onTap: () => Navigator.pop(context)),
                          ListTile(
                              leading: const Icon(Icons.lock_outline),
                              title: const Text('Privacy & Security'),
                              onTap: () => Navigator.pop(context)),
                          ListTile(
                              leading: const Icon(Icons.language_outlined),
                              title: const Text('Language'),
                              onTap: () => Navigator.pop(context)),
                          ListTile(
                              leading: const Icon(Icons.logout,
                                  color: Colors.red),
                              title: const Text('Logout',
                                  style: TextStyle(color: Colors.red)),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context)
                                    .pushNamedAndRemoveUntil(
                                        '/login', (_) => false);
                              }),
                        ]),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: Icons.emoji_events_outlined,
                  title: 'Awards & Medals',
                  onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const AwardsScreen())); },
                ),
                _DrawerItem(
                  icon: Icons.public_outlined,
                  title: 'Web Mode',
                  onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const WebModeScreen())); },
                ),

                const SizedBox(height: 12),

                // WhatsApp chat
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.chat_rounded,
                        color: Colors.white, size: 20),
                    label: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Chat with Us',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 10)),
                        Text('WhatsApp',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Center(
                    child: Text('Managed by: Third Party',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 10)),
                  ),
                ),

                // Social icons
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _SocialIcon(Icons.alternate_email, Colors.black),
                      _SocialIcon(Icons.facebook, const Color(0xFF1877F2)),
                      _SocialIcon(Icons.play_arrow, Colors.red),
                      _SocialIcon(Icons.camera_alt_outlined,
                          const Color(0xFFE1306C)),
                      _SocialIcon(Icons.send, const Color(0xFF0088CC)),
                      _SocialIcon(Icons.chat, const Color(0xFF25D366)),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Text('Privacy Policy',
                            style: TextStyle(
                                color: kPrimaryGreen, fontSize: 11)),
                      ),
                      const Text(' Â· ',
                          style:
                              TextStyle(color: Colors.grey, fontSize: 11)),
                      GestureDetector(
                        onTap: () {},
                        child: const Text('Terms of Service',
                            style: TextStyle(
                                color: kPrimaryGreen, fontSize: 11)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrefRow extends StatelessWidget {
  final String label;
  final String value;
  const _PrefRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(56, 4, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: kPrimaryGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
                Text(value,
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: kPrimaryGreen,
              side: const BorderSide(color: kPrimaryGreen),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Edit', style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback onTap;
  const _DrawerItem(
      {required this.icon,
      required this.title,
      this.trailing,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kPrimaryGreen, size: 20),
      title: Text(title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      trailing: trailing != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(trailing!,
                    style: const TextStyle(
                        color: kPrimaryGreen, fontWeight: FontWeight.bold)),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            )
          : const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      dense: true,
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _SocialIcon(this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 18),
    );
  }
}

