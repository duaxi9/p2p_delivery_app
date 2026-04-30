// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/screens/auth_service.dart';
import 'package:my_app/screens/settings.dart';
import 'package:my_app/screens/welcome_screens.dart';
import 'package:my_app/widgets/Mytrips_page.dart';
import 'package:my_app/screens/help_support_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? _userData;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final data = await AuthService().getUserData();
    if (mounted) {
      setState(() {
        _userData = data;
        _loading = false;
      });
    }
  }

  String get _fullName {
    if (_userData == null) return '';
    final first = (_userData!['firstname'] ?? '').toString().trim();
    final last = (_userData!['lastname'] ?? '').toString().trim();
    return '$first $last'.trim();
  }

  String get _initials {
    if (_userData == null) return '?';
    final first = (_userData!['firstname'] ?? '').toString().trim();
    final last = (_userData!['lastname'] ?? '').toString().trim();
    return '${first.isNotEmpty ? first[0] : ''}${last.isNotEmpty ? last[0] : ''}'
        .toUpperCase();
  }

  String get _email => (_userData?['email'] ?? '').toString();
  String get _birthday => (_userData?['date'] ?? '—').toString();
  String get _username => (_userData?['username'] ?? '—').toString();

  String get _memberSince {
    final raw = _userData?['createdAt'];
    if (raw == null) return '—';

    DateTime? dt;

    if (raw is DateTime) {
      dt = raw;
    } else {
      try {
        dt = (raw as dynamic).toDate();
      } catch (_) {}
    }

    if (dt == null) return '—';

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }
  
  Null get _userTrips => null;
  
  Null get _userRating => null;
  
  Null get _userDeliveries => null;

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF7E0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFFB8960A), size: 18),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.manrope(
                  color: Colors.black38,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.syne(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _acceptChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF7E0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFB8960A).withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: GoogleFonts.syne(
          color: const Color(0xFFB8960A),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _statBox(String value, String label, {Color? valueColor}) {
    return Expanded(
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: GoogleFonts.syne(
                color: valueColor ?? Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.manrope(
                color: Colors.white38,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF2F2F0),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFB8960A)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F0),
      endDrawer: NavigationDrawerWidget(
        fullName: _fullName,
        initials: _initials,
        email: _email,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 199, 180, 103),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 55, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Builder(
                        builder: (context) => GestureDetector(
                          onTap: () => Scaffold.of(context).openEndDrawer(),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.menu,
                              color: Colors.white54,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDEDED),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            _initials,
                            style: GoogleFonts.syne(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _fullName.isEmpty ? 'User' : _fullName,
                            style: GoogleFonts.syne(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0A2A0A),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.check_circle,
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
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                     _statBox(_userTrips.toString(), 'Trips'),
                      const SizedBox(width: 8),
                      _statBox(_userRating.toString(), 'Rating'),
                      const SizedBox(width: 8),
                      _statBox(_userDeliveries.toString(), 'Deliveries'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Personal Information',
                    style: GoogleFonts.syne(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF7E0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Color(0xFFB8960A),
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _infoRow(Icons.person, 'Username', _username),
                  Divider(
                    height: 1,
                    color: Colors.black.withOpacity(0.05),
                    indent: 20,
                    endIndent: 20,
                  ),
                  _infoRow(Icons.cake, 'Birthday', _birthday),
                  Divider(
                    height: 1,
                    color: Colors.black.withOpacity(0.05),
                    indent: 20,
                    endIndent: 20,
                  ),
                  _infoRow(Icons.card_membership, 'Member Since', _memberSince),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Accepts',
                style: GoogleFonts.syne(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _acceptChip('Documents'),
                  _acceptChip('Gift'),
                  _acceptChip('Electronics'),
                  _acceptChip('Fragile'),
                  _acceptChip('Clothes'),
                  _acceptChip('Other'),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class NavigationDrawerWidget extends StatelessWidget {
  final String fullName;
  final String initials;
  final String email;

  const NavigationDrawerWidget({
    super.key,
    required this.fullName,
    required this.initials,
    required this.email,
  });

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: const Color(0xFF1A1A1A),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              _buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget _buildHeader(BuildContext context) => Container(
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
                  initials,
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
              fullName.isEmpty ? 'User' : fullName,
              style: GoogleFonts.syne(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              email.isEmpty ? '—' : email,
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
                  '— Rating  •  0 Trips',
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
  }) =>
      ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
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
            : const Icon(
                Icons.chevron_right,
                color: Colors.white12,
                size: 18,
              ),
        onTap: onTap ?? () {},
      );

  Widget _buildMenuItems(BuildContext context) => Padding(
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
                  MaterialPageRoute(builder: (_) => const MytripsPage()),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                    builder: (_) => SettingsPage(),
                  ),
                );
              },
            ),
           _drawerItem(
  context: context,
  icon: Icons.help_outline,
  title: 'Help & Support',
  iconColor: Colors.white38,
  onTap: () {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const HelpSupportPage(),
      ),
    );
  },
),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Divider(color: Colors.white10, thickness: 1),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
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
                MaterialPageRoute(builder: (_) => const WelcomeScreens()),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      );
}