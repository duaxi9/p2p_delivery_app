import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2p_delivery_app/screens/Profilepage.dart';
import 'package:p2p_delivery_app/screens/messages.dart';
import 'package:p2p_delivery_app/screens/traveler_page.dart';
import 'package:p2p_delivery_app/screens/posting.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
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
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Chats"),
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
              ? const Scaffold(body: Center(child: Text("Search")))
              : _selectedIndex == 2
                  ? const Scaffold(body: Center(child: Text("Orders")))
                  : _selectedIndex == 3
    ? Messages()
    
    : ProfilePage(),
  
                      
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
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.04),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _LogoText(),
                  const SizedBox(height: 2),


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
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
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
                    Positioned(
                      right: 1,
                      top: 1,
                      child: Container(
                        width: 11,
                        height: 11,
                        
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              "Good morning,",
              style: GoogleFonts.manrope(
                fontSize: 15, color: Colors.black38, fontWeight: FontWeight.w400),
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
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Posting()),
            ),
            child: Container(
              height: 135,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF0E0E0E),
                    Color.fromARGB(255, 34, 34, 34),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.inventory_2_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Send Parcel",
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Ship with a traveler",
                      style: GoogleFonts.manrope(color: Colors.white70, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(

          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TravelerPage()),
            ),
          child: Container(
            height: 135,
            decoration: BoxDecoration(
              color: const Color(0xFFB8960A),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.flight, color: Colors.white, size: 24),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "I'm Traveling",
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Earn by carrying parcels",
                    style: GoogleFonts.manrope(color: Colors.white70, fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
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
    return const Column(
      children: [
        DeliveryCard(
          initials: "MS",
          avatarColor: Color.fromARGB(255, 234, 138, 218),
          name: "Mehdi Saidi",
          rating: 4.9,
          details: "Paris → ALG · Apr 12 · 9 kg",
          price: "\$15/kg",
          status: "Accepted",
          statusColor: Color(0xFF2DC830),
        ),
        DeliveryCard(
          initials: "YM",
          avatarColor: Colors.black,
          name: "Yacine Mansouri",
          rating: 4.8,
          details: "ALG → IST · Apr 14 · 5 kg",
          price: "\$10/kg",
          status: "Accepted",
          statusColor: Color(0xFF2DC830),
        ),
      ],
    );
  }

  Widget _activeDeliveries() {
    return Column(
      children: [
        ActiveDeliveryCard(
          initials: "SL",
          avatarColor: Color(0xFF0EA5A4),
          name: "Sofia Lopez",
          route: "València → DXB · 3 kg",
          price: "\$8/kg",
          progress: 0.58,
        ),
      ],
    );
  }

  Widget _pastDeliveries() {
    return const Column(
      children: [
        DeliveryCard(
          initials: "DC",
          avatarColor: Colors.red,
          name: "Daniel Costa",
          rating: 4.7,
          details: "Germany → CDG · Mar 18 · 4 kg free",
          price: "\$8/kg",
          status: "2 days",
          statusColor: Colors.grey,
        ),
        DeliveryCard(
          initials: "DK",
          avatarColor: Color(0xFF3467EB),
          name: "Douaa Kebaili",
          rating: 4.3,
          details: "ALG → LHR · Mar 20 · 6 kg",
          price: "\$10/kg",
          status: "4 days",
          statusColor: Colors.grey,
        ),
        DeliveryCard(
          initials: "CM",
          avatarColor: Color.fromARGB(255, 81, 80, 80),
          name: "Chloe Martin",
          rating: 4.7,
          details: "Paris → Berlin · Mar 23 · 12 kg free",
          price: "\$21/kg",
          status: "7 days",
          statusColor: Colors.grey,
        ),
      ],
    );
  }
}

class _LogoText extends StatelessWidget {
  const _LogoText();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.syne(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
              height: 1,
            ),
            children: const [
              TextSpan(text: 'Link', style: TextStyle(color: Color(0xFF000000))),
              TextSpan(text: 'Air', style: TextStyle(color: Color(0xFFB8960A))),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'EXPRESS DELIVERY',
          style: GoogleFonts.manrope(
            fontSize: 11,
            letterSpacing: 3.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFAAAAAA),
          ),
        ),
      ],
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
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
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
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
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
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 78, 159, 225),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "València",
                      style: TextStyle(
                        color: Color(0xFF408CE3),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "In transit",
                      style: TextStyle(
                        color: Color(0xFF408CE3),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "DXB",
                      style: TextStyle(
                        color: Color.fromARGB(255, 91, 90, 90),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "On the way",
                style: TextStyle(
                  color: Color(0xFF408CE3),
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.syne(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
              height: 1,
            ),
            children: const [
              TextSpan(text: 'Link', style: TextStyle(color: Color(0xFF000000))),
              TextSpan(text: 'Air', style: TextStyle(color: Color(0xFFB8960A))),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'EXPRESS DELIVERY',
          style: GoogleFonts.manrope(
            fontSize: 11,
            letterSpacing: 3.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFAAAAAA),
          ),
        ),
      ],
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
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (rating != null) ...[
                      const SizedBox(width: 6),
                      Text(
                        "⭐️ ${rating!.toStringAsFixed(1)}",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
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