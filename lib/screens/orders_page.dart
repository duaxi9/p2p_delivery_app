import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2p_delivery_app/screens/tracking_page.dart';
import 'package:p2p_delivery_app/screens/home_screen.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: SafeArea(
        child: Column(
          children: [
            _header(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _orderCard(
                    context: context,
                    name: "Sofia Martinez",
                    route: "Algiers → Paris",
                    date: "16 Apr 2026",
                    price: "\$45",
                    orderId: "Order #LA-2048",
                    from: "Algiers",
                    to: "Paris",
                    parcelType: "Documents",
                    weight: "0.8 kg",
                    eta: "2h 15m",
                    progress: 0.62,
                  ),

                  const SizedBox(height: 16),

                  _orderCard(
                    context: context,
                    name: "Adam Lee",
                    route: "Dubai → London",
                    date: "15 Apr 2026",
                    price: "\$60",
                    orderId: "Order #LA-2051",
                    from: "Dubai",
                    to: "London",
                    parcelType: "Electronics",
                    weight: "1.2 kg",
                    eta: "5h 40m",
                    progress: 0.48,
                  ),

                  const SizedBox(height: 16),

                  _orderCard(
                    context: context,
                    name: "Lina Karim",
                    route: "Istanbul → Montreal",
                    date: "14 Apr 2026",
                    price: "\$72",
                    orderId: "Order #LA-2057",
                    from: "Istanbul",
                    to: "Montreal",
                    parcelType: "Clothes",
                    weight: "2.4 kg",
                    eta: "8h 10m",
                    progress: 0.35,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HEADER
  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ),
    (route) => false,
  );
},
            child: const Icon(Icons.arrow_back_ios_new),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Orders",
              textAlign: TextAlign.center,
              style: GoogleFonts.syne(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  // ORDER CARD
  Widget _orderCard({
    required BuildContext context,
    required String name,
    required String route,
    required String date,
    required String price,
    required String orderId,
    required String from,
    required String to,
    required String parcelType,
    required String weight,
    required String eta,
    required double progress,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // NAME + STATUS
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: GoogleFonts.syne(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E7C3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "In Transit",
                  style: GoogleFonts.manrope(
                    color: const Color(0xFFB8960A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          _infoRow(Icons.route, "Route: $route"),
          const SizedBox(height: 6),
          _infoRow(Icons.calendar_today, "Date: $date"),
          const SizedBox(height: 6),
          _infoRow(Icons.attach_money, "Price: $price"),

          const SizedBox(height: 18),

          // TRACK BUTTON
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrackingPage(
                      orderId: orderId,
                      carrierName: name,
                      routeFrom: from,
                      routeTo: to,
                      date: date,
                      price: price,
                      parcelType: parcelType,
                      weight: weight,
                      status: "In transit",
                      eta: eta,
                      progress: progress,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB8960A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Track",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // INFO ROW
  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFFB8960A)),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.manrope(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}