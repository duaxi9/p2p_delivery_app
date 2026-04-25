import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_app/screens/Notifications_page.dart';
import 'package:my_app/screens/orders_page.dart';
import 'package:my_app/screens/profile_page.dart';
import 'package:my_app/screens/user_profile_page.dart';
import 'package:my_app/screens/messages.dart';
import 'package:my_app/screens/traveler_page.dart';
import 'package:my_app/screens/posting.dart';
import 'package:my_app/screens/search_page.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<Locale> onLanguageChanged;
  final String selectedLanguage;

  const HomeScreen({
    super.key,
    required this.onLanguageChanged,
    required this.selectedLanguage,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2EF),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFB8960A),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        iconSize: 22,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Iconsax.category), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
      body: _selectedIndex == 0
          ? SafeArea(
              child: Column(
                children: [
                  _header(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 19),
                          const Text(
                            "ACTIONS",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black26,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _quickActions(context),
                          const SizedBox(height: 24),
                          _sectionTitle("ACCEPTED DELIVERIES"),
                          _acceptedDeliveries(),
                          const SizedBox(height: 14),
                          _sectionTitle("ACTIVE DELIVERIES"),
                          _activeDeliveries(),
                          const SizedBox(height: 14),
                          _sectionTitle("PAST DELIVERIES"),
                          _pastDeliveries(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : _selectedIndex == 1
              ? const Search()
              : _selectedIndex == 2
                  ? const OrdersPage()
                  : _selectedIndex == 3
                      ? Messages()
                      : ProfilePage(
                          onLanguageChanged: widget.onLanguageChanged,
                          selectedLanguage: widget.selectedLanguage,
                        ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LogoText(),
                    SizedBox(height: 2),
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.grey,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationsPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE0C13A),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_none,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              "Good morning,",
              style: GoogleFonts.manrope(
                fontSize: 15,
                color: Colors.black38,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Karim Amir",
              style: GoogleFonts.syne(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickActions(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Posting()),
          ),
          child: Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E5E3),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 195, 195, 191),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.inventory_2_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Send Parcel",
                        style: GoogleFonts.syne(
                          color: Colors.black45,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Ship with a traveler",
                        style: GoogleFonts.manrope(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black26,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TravelerPage()),
          ),
          child: Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFB8960A),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFB8960A).withAlpha(77),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.flight,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "I'm Traveling",
                        style: GoogleFonts.syne(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Earn by carrying parcels",
                        style: GoogleFonts.manrope(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black26,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          letterSpacing: 3,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _acceptedDeliveries() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const UserProfilePage(
                initials: 'MS',
                color: Color.fromARGB(255, 234, 138, 218),
                name: 'Mehdi Saidi',
                rating: 4.9,
                trips: 48,
                deliveries: 120,
              ),
            ),
          ),
          child: const DeliveryCard(
            initials: "MS",
            avatarColor: Color.fromARGB(255, 234, 138, 218),
            name: "Mehdi Saidi",
            rating: 4.9,
            details: "Paris → ALG · Apr 12 · 9 kg",
            price: "\$15/kg",
            status: "Accepted",
            statusColor: Color(0xFF2DC830),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const UserProfilePage(
                initials: 'YM',
                color: Colors.black,
                name: 'Yacine Mansouri',
                rating: 4.8,
                trips: 31,
                deliveries: 74,
              ),
            ),
          ),
          child: const DeliveryCard(
            initials: "YM",
            avatarColor: Colors.black,
            name: "Yacine Mansouri",
            rating: 4.8,
            details: "ALG → IST · Apr 14 · 5 kg",
            price: "\$10/kg",
            status: "Accepted",
            statusColor: Color(0xFF2DC830),
          ),
        ),
      ],
    );
  }

  Widget _activeDeliveries() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const UserProfilePage(
                initials: 'SL',
                color: Color(0xFF0EA5A4),
                name: 'Sofia Lopez',
                rating: 4.7,
                trips: 22,
                deliveries: 55,
              ),
            ),
          ),
          child: const ActiveDeliveryCard(
            initials: "SL",
            avatarColor: Color(0xFF0EA5A4),
            name: "Sofia Lopez",
            route: "València → DXB · 3 kg",
            price: "\$8/kg",
            progress: 0.58,
          ),
        ),
      ],
    );
  }

  Widget _pastDeliveries() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const UserProfilePage(
                initials: 'DC',
                color: Colors.red,
                name: 'Daniel Costa',
                rating: 4.7,
                trips: 18,
                deliveries: 40,
              ),
            ),
          ),
          child: const DeliveryCard(
            initials: "DC",
            avatarColor: Colors.red,
            name: "Daniel Costa",
            rating: 4.7,
            details: "MAD → CDG · Mar 18 · 4 kg free",
            price: "\$8/kg",
            status: "2 days",
            statusColor: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _LogoText extends StatelessWidget {
  const _LogoText();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.syne(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
          height: 1,
        ),
        children: const [
          TextSpan(
            text: 'Link',
            style: TextStyle(color: Color(0xFF000000)),
          ),
          TextSpan(
            text: 'Air',
            style: TextStyle(color: Color(0xFFB8960A)),
          ),
        ],
      ),
    );
  }
}

class ActiveDeliveryCard extends StatelessWidget {
  final String initials;
  final Color avatarColor;
  final String name;
  final String route;
  final String price;
  final double progress;

  const ActiveDeliveryCard({
    super.key,
    required this.initials,
    required this.avatarColor,
    required this.name,
    required this.route,
    required this.price,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 49,
            height: 49,
            decoration: BoxDecoration(
              color: avatarColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                initials,
                style: GoogleFonts.syne(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.syne(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  route,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 144, 142, 142),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 3,
                    backgroundColor: Colors.black,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 78, 159, 225),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            price,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class DeliveryCard extends StatelessWidget {
  final String initials;
  final Color avatarColor;
  final String name;
  final double? rating;
  final String details;
  final String price;
  final String status;
  final Color? statusColor;

  const DeliveryCard({
    super.key,
    required this.initials,
    required this.avatarColor,
    required this.name,
    this.rating,
    required this.details,
    required this.price,
    required this.status,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: avatarColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                initials,
                style: GoogleFonts.syne(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.syne(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                style: TextStyle(
                  color: statusColor ?? Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}