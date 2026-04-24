import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:p2p_delivery_app/screens/personal_information_page.dart';
import 'package:p2p_delivery_app/screens/welcome_screens.dart';

class SettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const SettingsPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final LocalAuthentication _localAuth = LocalAuthentication();

  bool pushNotifications = true;
  bool emailNotifications = false;
  bool biometricLogin = false;
  bool twoFactorEnabled = false;
  bool locationTracking = true;
  bool dataSharingAnalytics = false;

  String selectedLanguage = 'English';
  String selectedCurrency = 'DZD – Algerian Dinar';
final List<String> languages = [ 
  'English',
  'Arabic',
  'French',
  'Spanish',
  'Portuguese',
  'German',
  'Italian',
  'Dutch',
  'Turkish',
  'Russian',
  'Ukrainian',
  'Chinese (Simplified)',
  'Chinese (Traditional)',
  'Japanese',
  'Korean',
  'Hindi',
  'Urdu',
  'Bengali',
  'Punjabi',
  'Persian',
  'Indonesian',
  'Malay',
  'Thai',
  'Vietnamese',
  'Filipino',
  'Swahili',
  'Hebrew',
  'Greek',
  'Polish',
  'Romanian',
  'Czech',
  'Hungarian',
  'Swedish',
  'Norwegian',
  'Danish',
  'Finnish',
];
  final List<String> currencies = [
    'DZD – Algerian Dinar',
    'USD – US Dollar',
    'EUR – Euro',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF0F0F10) : const Color(0xFFF3F2EF);
    final cardColor = isDark ? const Color(0xFF1A1A1D) : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black,
        ),
        title: Text(
          'Settings',
          style: GoogleFonts.syne(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Account', isDark),
            const SizedBox(height: 10),
            _menuCard(
              cardColor: cardColor,
              children: [
                _premiumTile(
                  isDark: isDark,
                  icon: Icons.person_outline,
                  iconColor: const Color(0xFF3B82F6),
                  title: 'Personal Information',
                  subtitle: 'View and edit your account details',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PersonalInformationPage(),
                      ),
                    );
                  },
                ),
                _divider(isDark),
                _premiumTile(
                  isDark: isDark,
                  icon: Icons.lock_outline,
                  iconColor: const Color(0xFFA855F7),
                  title: 'Password & Security',
                  subtitle: 'Manage password and account protection',
                  onTap: () => _showSnackBar('Password & Security coming soon'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            _sectionTitle('Language & Region', isDark),
            const SizedBox(height: 10),
            _menuCard(
              cardColor: cardColor,
              children: [
                _dropdownTile(
                  isDark: isDark,
                  icon: Icons.language_outlined,
                  iconColor: const Color(0xFF10B981),
                  title: 'Language',
                  subtitle: 'Choose your preferred language',
                  value: selectedLanguage,
                  items: languages,
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => selectedLanguage = val);
                    }
                  },
                ),
                _divider(isDark),
                _dropdownTile(
                  isDark: isDark,
                  icon: Icons.monetization_on_outlined,
                  iconColor: const Color(0xFFF59E0B),
                  title: 'Currency',
                  subtitle: 'Set your default display currency',
                  value: selectedCurrency,
                  items: currencies,
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => selectedCurrency = val);
                    }
                  },
                ),
                _divider(isDark),
                _infoRow(
                  isDark: isDark,
                  title: 'Time Zone',
                  value: 'GMT+1 · Algiers',
                ),
              ],
            ),

            const SizedBox(height: 24),

            _sectionTitle('Payment Methods', isDark),
            const SizedBox(height: 10),
            _menuCard(
              cardColor: cardColor,
              children: [
                _premiumTile(
                  isDark: isDark,
                  icon: Icons.credit_card_outlined,
                  iconColor: const Color(0xFF3B82F6),
                  title: 'Saved Cards',
                  subtitle: 'Manage your linked payment cards',
                  onTap: () => _showSnackBar('Saved Cards coming soon'),
                ),
                _divider(isDark),
                _premiumTile(
                  isDark: isDark,
                  icon: Icons.account_balance_wallet_outlined,
                  iconColor: const Color(0xFF10B981),
                  title: 'Wallet Balance',
                  subtitle: 'View balance and top up your wallet',
                  onTap: () => _showSnackBar('Wallet coming soon'),
                ),
                _divider(isDark),
                _premiumTile(
                  isDark: isDark,
                  icon: Icons.receipt_long_outlined,
                  iconColor: const Color(0xFFF59E0B),
                  title: 'Transaction History',
                  subtitle: 'Browse past payments and invoices',
                  onTap: () => _showSnackBar('Transaction History coming soon'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            _sectionTitle('Preferences', isDark),
            const SizedBox(height: 10),
            _menuCard(
              cardColor: cardColor,
              children: [
                _premiumSwitchTile(
                  isDark: isDark,
                  icon: Icons.notifications_none,
                  iconColor: const Color(0xFFF59E0B),
                  title: 'Push Notifications',
                  subtitle: 'Parcel updates and real-time alerts',
                  value: pushNotifications,
                  onChanged: (value) {
                    setState(() => pushNotifications = value);
                  },
                ),
                _divider(isDark),
                _premiumSwitchTile(
                  isDark: isDark,
                  icon: Icons.email_outlined,
                  iconColor: const Color(0xFF3B82F6),
                  title: 'Email Notifications',
                  subtitle: 'Receive updates and summaries by email',
                  value: emailNotifications,
                  onChanged: (value) {
                    setState(() => emailNotifications = value);
                  },
                ),
                _divider(isDark),
                _premiumSwitchTile(
                  isDark: isDark,
                  icon: Icons.dark_mode_outlined,
                  iconColor: const Color(0xFF64748B),
                  title: 'Dark Mode',
                  subtitle: 'Switch the app appearance instantly',
                  value: widget.isDarkMode,
                  onChanged: widget.onThemeChanged,
                ),
              ],
            ),

            const SizedBox(height: 24),

            _sectionTitle('Security', isDark),
            const SizedBox(height: 10),
            _menuCard(
              cardColor: cardColor,
              children: [
                _premiumSwitchTile(
                  isDark: isDark,
                  icon: Icons.fingerprint,
                  iconColor: const Color(0xFFA855F7),
                  title: 'Biometric Login',
                  subtitle: 'Use fingerprint or Face ID when available',
                  value: biometricLogin,
                  onChanged: (value) {
                    setState(() => biometricLogin = value);
                  },
                ),
                _divider(isDark),
                _premiumSwitchTile(
                  isDark: isDark,
                  icon: Icons.security,
                  iconColor: const Color(0xFF3B82F6),
                  title: 'Two-Factor Authentication',
                  subtitle: 'Add an extra security layer to your account',
                  value: twoFactorEnabled,
                  onChanged: (value) async {
                    if (value) {
                      final didAuthenticate = await _localAuth.authenticate(
                        localizedReason: 'Enable two-factor authentication',
                      );

                      if (didAuthenticate) {
                        setState(() => twoFactorEnabled = true);
                        _showSnackBar('2FA Enabled');
                      }
                    } else {
                      setState(() => twoFactorEnabled = false);
                      _showSnackBar('2FA Disabled');
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            _sectionTitle('Privacy & Data', isDark),
            const SizedBox(height: 10),
            _menuCard(
              cardColor: cardColor,
              children: [
                _premiumSwitchTile(
                  isDark: isDark,
                  icon: Icons.location_on_outlined,
                  iconColor: const Color(0xFF10B981),
                  title: 'Location Tracking',
                  subtitle: 'Allow the app to access your location',
                  value: locationTracking,
                  onChanged: (value) {
                    setState(() => locationTracking = value);
                  },
                ),
                _divider(isDark),
                _premiumSwitchTile(
                  isDark: isDark,
                  icon: Icons.bar_chart_outlined,
                  iconColor: const Color(0xFFF59E0B),
                  title: 'Analytics & Diagnostics',
                  subtitle: 'Help improve the app by sharing usage data',
                  value: dataSharingAnalytics,
                  onChanged: (value) {
                    setState(() => dataSharingAnalytics = value);
                  },
                ),
                _divider(isDark),
                _premiumTile(
                  isDark: isDark,
                  icon: Icons.shield_outlined,
                  iconColor: const Color(0xFFA855F7),
                  title: 'Privacy Policy',
                  subtitle: 'Read how we handle your personal data',
                  onTap: () => _showSnackBar('Opening Privacy Policy…'),
                ),
                _divider(isDark),
                _premiumTile(
                  isDark: isDark,
                  icon: Icons.delete_outline,
                  iconColor: const Color(0xFFEF4444),
                  title: 'Delete My Account',
                  subtitle: 'Permanently remove your data from our servers',
                  onTap: () => _showDeleteAccountDialog(isDark),
                ),
              ],
            ),

            const SizedBox(height: 24),

            _sectionTitle('Help & Support', isDark),
            const SizedBox(height: 10),
            _menuCard(
              cardColor: cardColor,
              children: [
                _premiumTile(
                  isDark: isDark,
                  icon: Icons.help_outline_rounded,
                  iconColor: const Color(0xFF3B82F6),
                  title: 'FAQ & Help Center',
                  subtitle: 'Find answers to common questions',
                  onTap: () => _showSnackBar('Opening Help Center…'),
                ),
                _divider(isDark),
                _premiumTile(
                  isDark: isDark,
                  icon: Icons.chat_bubble_outline_rounded,
                  iconColor: const Color(0xFF10B981),
                  title: 'Contact Support',
                  subtitle: 'Chat with us or send an email',
                  onTap: () => _showContactSupportSheet(isDark, cardColor),
                ),
                _divider(isDark),
                _premiumTile(
                  isDark: isDark,
                  icon: Icons.star_outline_rounded,
                  iconColor: const Color(0xFFF59E0B),
                  title: 'Rate the App',
                  subtitle: 'Enjoying the app? Leave us a review',
                  onTap: () => _showSnackBar('Opening app store review…'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            _sectionTitle('About / Legal', isDark),
            const SizedBox(height: 10),
            _menuCard(
              cardColor: cardColor,
              children: [
                _infoRow(
                  isDark: isDark,
                  title: 'Version',
                  value: '1.0.0',
                ),
                _divider(isDark),
                _infoRow(
                  isDark: isDark,
                  title: 'Region',
                  value: 'Algeria',
                ),
                _divider(isDark),
                _infoRow(
                  isDark: isDark,
                  title: 'Build',
                  value: '2025.04.001',
                ),
                _divider(isDark),
                _premiumTile(
                  isDark: isDark,
                  icon: Icons.description_outlined,
                  iconColor: const Color(0xFF64748B),
                  title: 'Terms of Service',
                  subtitle: 'Review the terms governing app usage',
                  onTap: () => _showSnackBar('Opening Terms of Service…'),
                ),
                _divider(isDark),
                _premiumTile(
                  isDark: isDark,
                  icon: Icons.copyright_outlined,
                  iconColor: const Color(0xFF64748B),
                  title: 'Licenses',
                  subtitle: 'Open-source libraries and attributions',
                  onTap: () => _showSnackBar('Opening Licenses…'),
                ),
              ],
            ),

            const SizedBox(height: 28),

            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreens(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 17),
                decoration: BoxDecoration(
                  color: const Color(0xFFD93025),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: const Color(0xFFD93025).withOpacity(0.22),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Logout',
                    style: GoogleFonts.syne(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showContactSupportSheet(bool isDark, Color cardColor) {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Contact Support',
                style: GoogleFonts.syne(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Choose how you would like to reach us',
                style: GoogleFonts.manrope(
                  color: isDark ? Colors.white54 : Colors.black54,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              _supportOption(
                isDark: isDark,
                icon: Icons.chat_bubble_outline_rounded,
                iconColor: const Color(0xFF10B981),
                label: 'Live Chat',
                desc: 'Average response time: ~2 min',
                onTap: () {
                  Navigator.pop(ctx);
                  _showSnackBar('Opening Live Chat…');
                },
              ),
              const SizedBox(height: 14),
              _supportOption(
                isDark: isDark,
                icon: Icons.email_outlined,
                iconColor: const Color(0xFF3B82F6),
                label: 'Send an Email',
                desc: 'support@p2pdelivery.dz',
                onTap: () {
                  Navigator.pop(ctx);
                  _showSnackBar('Opening email client…');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _supportOption({
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String label,
    required String desc,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: iconColor.withOpacity(0.09),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: iconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: iconColor, size: 21),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.syne(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: GoogleFonts.manrope(
                    color: isDark ? Colors.white54 : Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right_rounded,
              color: isDark ? Colors.white38 : Colors.black38,
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog(bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1A1A1D) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Delete Account',
          style: GoogleFonts.syne(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        content: Text(
          'This action is irreversible. All your data, parcels, and history will be permanently removed.',
          style: GoogleFonts.manrope(
            color: isDark ? Colors.white70 : Colors.black87,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: GoogleFonts.syne(
                color: isDark ? Colors.white54 : Colors.black54,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showSnackBar('Account deletion requested');
            },
            child: Text(
              'Delete',
              style: GoogleFonts.syne(
                color: const Color(0xFFEF4444),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: GoogleFonts.syne(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: isDark ? Colors.white70 : Colors.black87,
      ),
    );
  }

  Widget _menuCard({
    required Color cardColor,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: children),
    );
  }

  Widget _premiumTile({
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: iconColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: iconColor, size: 21),
      ),
      title: Text(
        title,
        style: GoogleFonts.syne(
          color: isDark ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          subtitle,
          style: GoogleFonts.manrope(
            color: isDark ? Colors.white54 : Colors.black54,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: isDark ? Colors.white38 : Colors.black38,
      ),
    );
  }

  Widget _premiumSwitchTile({
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: iconColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: iconColor, size: 21),
      ),
      title: Text(
        title,
        style: GoogleFonts.syne(
          color: isDark ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          subtitle,
          style: GoogleFonts.manrope(
            color: isDark ? Colors.white54 : Colors.black54,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: const Color(0xFFB8960A),
      ),
    );
  }

  Widget _dropdownTile({
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 21),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.syne(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.manrope(
                    color: isDark ? Colors.white54 : Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              dropdownColor: isDark ? const Color(0xFF1A1A1D) : Colors.white,
              icon: Icon(
                Icons.expand_more_rounded,
                color: isDark ? Colors.white38 : Colors.black38,
                size: 20,
              ),
              style: GoogleFonts.syne(
                color: isDark ? Colors.white70 : Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
              items: items
                  .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required bool isDark,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              color: isDark ? Colors.white70 : Colors.black87,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.syne(
              color: isDark ? Colors.white54 : Colors.black54,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      // ignore: deprecated_member_use
      color: isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.05),
    );
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}