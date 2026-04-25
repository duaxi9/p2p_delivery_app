import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/screens/privacy_policy.dart';

class PrivacySecurityPage extends StatelessWidget {
  const PrivacySecurityPage({super.key});

  static const Color gold = Color(0xFFB8960A);
  static const Color goldLight = Color(0xFFF5EFC7);
  static const Color bg = Color(0xFFF6F5F2);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF111111);
  static const Color textSoft = Color(0xFF9A9086);
  static const Color border = Color(0xFFEDE8DD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: textDark, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Privacy & Security",
          style: GoogleFonts.syne(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: textDark,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: goldLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_rounded, color: gold, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    "Secure",
                    style: GoogleFonts.manrope(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: gold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
        children: [
          // ── Account Security ───────────────────────────────────────
          const _SectionTitle("Account Security"),
          _SettingTile(
            icon: Icons.lock_outline_rounded,
            title: "Change Password",
            subtitle: "Last changed 3 months ago",
            tag: "Recommended",
            onTap: () {},
          ),
          _SettingTile(
            icon: Icons.shield_outlined,
            title: "Two-Step Verification",
            subtitle: "Add an extra layer of login protection",
            trailingText: "Off",
            onTap: () {},
          ),
          _SettingTile(
            icon: Icons.fingerprint_rounded,
            title: "Biometric Login",
            subtitle: "Use Face ID or fingerprint to sign in",
            trailingText: "On",
            onTap: () {},
          ),
          _SettingTile(
            icon: Icons.devices_rounded,
            title: "Logged-in Devices",
            subtitle: "3 active sessions",
            onTap: () {},
          ),
          _SettingTile(
            icon: Icons.key_rounded,
            title: "Passkeys",
            subtitle: "Manage passwordless login keys",
            onTap: () {},
          ),
          const SizedBox(height: 22),

          // ── Privacy ────────────────────────────────────────────────
          const _SectionTitle("Privacy"),
          _SwitchTile(
            icon: Icons.visibility_off_outlined,
            title: "Hide My Profile",
            subtitle: "Limit who can view your public profile",
            value: false,
          ),
          _SwitchTile(
            icon: Icons.location_off_outlined,
            title: "Hide Exact Location",
            subtitle: "Show only approximate delivery areas",
            value: true,
          ),
          _SwitchTile(
            icon: Icons.notifications_active_outlined,
            title: "Security Alerts",
            subtitle: "Get notified about suspicious activity",
            value: true,
          ),
          _SwitchTile(
            icon: Icons.bar_chart_rounded,
            title: "Activity Status",
            subtitle: "Let others see when you're active",
            value: false,
          ),
          _SwitchTile(
            icon: Icons.receipt_long_outlined,
            title: "Read Receipts",
            subtitle: "Show when you've read messages",
            value: true,
          ),
          const SizedBox(height: 22),

          // ── Communications ─────────────────────────────────────────
          const _SectionTitle("Communications"),
          _SettingTile(
            icon: Icons.block_rounded,
            title: "Blocked Users",
            subtitle: "Manage your blocked contacts list",
            trailingText: "2",
            onTap: () {},
          ),
          _SettingTile(
            icon: Icons.mark_email_read_outlined,
            title: "Email Preferences",
            subtitle: "Control marketing and security emails",
            onTap: () {},
          ),
          _SettingTile(
            icon: Icons.phonelink_lock_outlined,
            title: "Login Notifications",
            subtitle: "Alert me on new device sign-ins",
            onTap: () {},
          ),
          const SizedBox(height: 22),

          // ── Data & Account ─────────────────────────────────────────
          const _SectionTitle("Data & Account"),
          _SettingTile(
            icon: Icons.download_rounded,
            title: "Download My Data",
            subtitle: "Get a full copy of your LinkAir data",
            onTap: () {},
          ),
          _SettingTile(
            icon: Icons.history_rounded,
            title: "Activity Log",
            subtitle: "Review your recent account activity",
            onTap: () {},
          ),
          _SettingTile(
            icon: Icons.policy_outlined,
            title: "Privacy Policy",
            subtitle: "Read our full privacy commitment",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyPage(),
                ),
              );
            },
          ),
          _SettingTile(
            icon: Icons.manage_history_rounded,
            title: "Data Retention Settings",
            subtitle: "Choose how long we store your data",
            onTap: () {},
          ),
          const SizedBox(height: 10),
          _SettingTile(
            icon: Icons.delete_forever_rounded,
            title: "Delete Account",
            subtitle: "Permanently remove all your data",
            isDanger: true,
            onTap: () {},
          ),

          const SizedBox(height: 24),
          const _FooterNote(),
        ],
      ),
    );
  }
}

// ── Section title ─────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.syne(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: const Color.fromARGB(255, 83, 82, 82),
          letterSpacing: -0.3,
        ),
      ),
    );
  }
}

// ── Setting tile ──────────────────────────────────────────────────────────────

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? trailingText;
  final String? tag;
  final bool isDanger;
  final VoidCallback onTap;

  const _SettingTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailingText,
    this.tag,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDanger ? const Color(0xFFD93025) : PrivacySecurityPage.gold;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: PrivacySecurityPage.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: PrivacySecurityPage.border),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          // ignore: deprecated_member_use
          splashColor: color.withOpacity(0.06),
          // ignore: deprecated_member_use
          highlightColor: color.withOpacity(0.04),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isDanger
                        ? const Color(0xFFFFEDEC)
                        // ignore: deprecated_member_use
                        : PrivacySecurityPage.gold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: isDanger
                                  ? const Color(0xFFD93025)
                                  : PrivacySecurityPage.textDark,
                              letterSpacing: -0.1,
                            ),
                          ),
                          if (tag != null) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                // ignore: deprecated_member_use
                                color: PrivacySecurityPage.gold.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                tag!,
                                style: GoogleFonts.manrope(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: PrivacySecurityPage.gold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          color: PrivacySecurityPage.textSoft,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                trailingText != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDanger
                              ? const Color(0xFFFFEDEC)
                              : const Color(0xFFF0EDE5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          trailingText!,
                          style: GoogleFonts.manrope(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: isDanger
                                ? const Color(0xFFD93025)
                                : PrivacySecurityPage.textSoft,
                          ),
                        ),
                      )
                    : Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 13,
                        // ignore: deprecated_member_use
                        color: PrivacySecurityPage.textSoft.withOpacity(0.6),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Switch tile ───────────────────────────────────────────────────────────────

class _SwitchTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;

  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
  });

  @override
  State<_SwitchTile> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<_SwitchTile> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: PrivacySecurityPage.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: PrivacySecurityPage.border),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isOn
                    // ignore: deprecated_member_use
                    ? PrivacySecurityPage.gold.withOpacity(0.1)
                    : const Color(0xFFF2F1EE),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                widget.icon,
                color: isOn
                    ? PrivacySecurityPage.gold
                    : PrivacySecurityPage.textSoft,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: PrivacySecurityPage.textDark,
                      letterSpacing: -0.1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.subtitle,
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      color: PrivacySecurityPage.textSoft,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: 0.82,
              child: Switch(
                value: isOn,
                activeThumbColor: Colors.white,
                activeTrackColor: PrivacySecurityPage.gold,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: const Color(0xFFDDD8CE),
                trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                onChanged: (v) => setState(() => isOn = v),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Footer note ───────────────────────────────────────────────────────────────

class _FooterNote extends StatelessWidget {
  const _FooterNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: PrivacySecurityPage.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 17,
            color: PrivacySecurityPage.textSoft,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Your data is encrypted end-to-end and never sold to third parties. Changes to security settings may require re-authentication.",
              style: GoogleFonts.manrope(
                fontSize: 11.5,
                color: PrivacySecurityPage.textSoft,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}