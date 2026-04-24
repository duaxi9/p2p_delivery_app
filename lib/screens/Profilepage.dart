import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2p_delivery_app/screens/welcome_screens.dart';
import 'package:p2p_delivery_app/widgets/MytripsPage.dart';
import 'package:p2p_delivery_app/screens/settings.dart';

class ProfilePage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<Locale> onLanguageChanged;
  final String selectedLanguage;

  const ProfilePage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.onLanguageChanged,
    required this.selectedLanguage,
  });
  Widget _acceptChip(String label, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: GoogleFonts.syne(
          color: textColor,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: NavigationDrawer(
        isDarkMode: isDarkMode,
        onThemeChanged: onThemeChanged,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Container(
                  height: 240,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                ),
                Positioned(
                  top: 28,
                  right: 20,
                  child: Builder(
                    builder: (context) => GestureDetector(
                      onTap: () => Scaffold.of(context).openEndDrawer(),
                      child: const Icon(
                        Icons.menu,
                        color: Colors.white30,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 35,
                  child: Row(
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB8960A),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 6),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'AL',
                            style: GoogleFonts.syne(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Amine Lazar',
                              style: GoogleFonts.syne(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              width: 88,
                              height: 24,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 14, 39, 14),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.check,
                                      color: Color(0xFF009900),
                                      size: 11,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'VERIFIED',
                                      style: GoogleFonts.syne(
                                        color: const Color(0xFF009900),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: 35,
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '48',
                              style: GoogleFonts.syne(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Trips',
                              style: GoogleFonts.syne(
                                color: Colors.white30,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 110,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '4.9',
                              style: GoogleFonts.syne(
                                color: const Color(0xFFB8960A),
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Rating',
                              style: GoogleFonts.syne(
                                color: Colors.white30,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 110,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '120',
                              style: GoogleFonts.syne(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Deliveries',
                              style: GoogleFonts.syne(
                                color: Colors.white30,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Personal Information',
                    style: GoogleFonts.syne(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Icon(
                    Icons.edit,
                    color: Color(0xFFB8960A),
                    size: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color(0xFFB8960A),
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current city',
                        style: GoogleFonts.manrope(
                          color: isDark ? Colors.white54 : Colors.black38,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Algiers',
                        style: GoogleFonts.syne(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.house_rounded,
                    color: Color(0xFFB8960A),
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hometown',
                        style: GoogleFonts.manrope(
                          color: isDark ? Colors.white54 : Colors.black38,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Oran',
                        style: GoogleFonts.syne(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.cake,
                    color: Color(0xFFB8960A),
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Birthday',
                        style: GoogleFonts.manrope(
                          color: isDark ? Colors.white54 : Colors.black38,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '25 March',
                        style: GoogleFonts.syne(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.card_membership,
                    color: Color(0xFFB8960A),
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Member Since',
                        style: GoogleFonts.manrope(
                          color: isDark ? Colors.white54 : Colors.black38,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Jun 21, 2025',
                        style: GoogleFonts.syne(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: isDark ? Colors.white12 : Colors.black12,
              thickness: 1,
            ),
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Accepts',
                style: GoogleFonts.syne(
                  color: isDark ? Colors.white38 : Colors.black26,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
              child: Container(
                width: 380,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _acceptChip('Documents', const Color(0xFFE37400),
                        const Color(0xFFFEF7E0)),
                    _acceptChip('Gift', const Color(0xFFE37400),
                        const Color(0xFFFEF7E0)),
                    _acceptChip('Electronics', const Color(0xFFE37400),
                        const Color(0xFFFEF7E0)),
                    _acceptChip('Fragile', const Color(0xFFE37400),
                        const Color(0xFFFEF7E0)),
                    _acceptChip('Clothes', const Color(0xFFE37400),
                        const Color(0xFFFEF7E0)),
                    _acceptChip('Other', const Color(0xFFE37400),
                        const Color(0xFFFEF7E0)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const NavigationDrawer({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: const Color.fromARGB(255, 48, 44, 44),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 24,
          bottom: 24,
          left: 20,
          right: 20,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFF0D0D0D),
          border: Border(
            bottom: BorderSide(color: Colors.white10, width: 1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFFB8960A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'AL',
                  style: GoogleFonts.syne(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Amine Lazar',
              style: GoogleFonts.syne(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'amine.lazar@email.com',
              style: GoogleFonts.manrope(
                color: Colors.white38,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: Color(0xFFB8960A),
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  '4.9 Rating  •  48 Trips',
                  style: GoogleFonts.manrope(
                    color: Colors.white54,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _drawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? badge,
    Color iconColor = const Color(0xFFB8960A),
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: iconColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      title: Text(
        title,
        style: GoogleFonts.manrope(
          color: Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFB8960A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                badge,
                style: GoogleFonts.syne(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : const Icon(Icons.chevron_right, color: Colors.white12, size: 18),
      onTap: onTap ?? () {},
    );
  }

  Widget buildMenuItems(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 8, bottom: 6),
              child: Text(
                'ACTIVITY',
                style: GoogleFonts.syne(
                  color: Colors.white24,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            _drawerItem(
              context: context,
              icon: Icons.local_shipping_outlined,
              title: 'My Deliveries',
              badge: '3',
              iconColor: const Color(0xFF1A73E8),
            ),
            _drawerItem(
              context: context,
              icon: Icons.flight_takeoff_outlined,
              title: 'My Trips',
              iconColor: const Color(0xFF1E8E3E),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MytripsPage(),
                  ),
                );
              },
            ),
            _drawerItem(
              context: context,
              icon: Icons.notifications_none,
              title: 'Notifications',
              badge: '5',
              iconColor: const Color(0xFFE37400),
            ),
            _drawerItem(
              context: context,
              icon: Icons.account_balance_wallet_outlined,
              title: 'Wallet',
              iconColor: const Color(0xFF9334E6),
            ),
            _drawerItem(
              context: context,
              icon: Icons.history,
              title: 'History',
              iconColor: const Color(0xFF00897B),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Divider(color: Colors.white10, thickness: 1),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 6),
              child: Text(
                'ACCOUNT',
                style: GoogleFonts.syne(
                  color: Colors.white24,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            _drawerItem(
              context: context,
              icon: Icons.settings_outlined,
              title: 'Settings',
              iconColor: Colors.white38,
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(
                      isDarkMode: isDarkMode,
                      onThemeChanged: onThemeChanged,
                    ),
                  ),
                );
              },
            ),
            _drawerItem(
              context: context,
              icon: Icons.help_outline,
              title: 'Help & Support',
              iconColor: Colors.white38,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Divider(color: Colors.white10, thickness: 1),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: const Color(0xFFD93025).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.logout,
                  color: Color(0xFFD93025),
                  size: 18,
                ),
              ),
              title: Text(
                'Logout',
                style: GoogleFonts.manrope(
                  color: const Color(0xFFD93025),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const WelcomeScreens(),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      );
}