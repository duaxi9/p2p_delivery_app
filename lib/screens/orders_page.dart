import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2p_delivery_app/screens/tracking_page.dart';
// ignore: unused_import
import 'package:p2p_delivery_app/screens/home_screen.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isParcels = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: _isParcels ? _parcelsList() : _deliveriesList(),
            ),
          ],
        ),
      ),
    );
  }

  // ── HEADER / TAB SWITCHER ────────────────────────────────
  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 15),
      child: Row(
        children: [
          // MY DELIVERIES tab
          GestureDetector(
            onTap: () => setState(() => _isParcels = false),
            child: Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: !_isParcels ? const Color(0xFFB8960A) : Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "My deliveries",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.syne(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: !_isParcels ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 25),

          // MY PARCELS tab
          GestureDetector(
            onTap: () => setState(() => _isParcels = true),
            child: Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: _isParcels ? const Color(0xFFB8960A) : Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "My Parcels",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.syne(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _isParcels ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _parcelsList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _parcelCard(
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
        _parcelCard(
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
        _parcelCard(
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
    );
  }

  Widget _deliveriesList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _deliveryCard(
          name: "Karim Bensaid",
          route: "Algiers → Lyon",
          weight: "1.4 kg",
          date: "18 Apr 2026",
          earning: "+\$55",
          status: "Picked up",
          isCompleted: false,
        ),
        const SizedBox(height: 16),
        _deliveryCard(
          name: "Nour Hamidi",
          route: "Oran → Paris",
          weight: "0.6 kg",
          date: "17 Apr 2026",
          earning: "+\$38",
          status: "In Transit",
          isCompleted: false,
        ),
        const SizedBox(height: 16),
        _deliveryCard(
          name: "Amira Tazi",
          route: "Tunis → Marseille",
          weight: "2.1 kg",
          date: "14 Apr 2026",
          earning: "+\$62",
          status: "Delivered",
          isCompleted: true,
        ),
      ],
    );
  }

  Widget _parcelCard({
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

  Widget _deliveryCard({
    required String name,
    required String route,
    required String weight,
    required String date,
    required String earning,
    required String status,
    required bool isCompleted,
  }) {
    final Color statusColor =
        isCompleted ? Colors.black38 : const Color(0xFFB8960A);
    final Color statusBg =
        isCompleted ? const Color(0xFFE8E8E8) : const Color(0xFFF3E7C3);

    return Opacity(
      opacity: isCompleted ? 0.6 : 1.0,
      child: Container(
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
                    color: statusBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.manrope(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _infoRow(Icons.route, "Route: $route · $weight"),
            const SizedBox(height: 6),
            _infoRow(Icons.calendar_today, "Date: $date"),
            const SizedBox(height: 6),
            _infoRow(
              Icons.attach_money,
              "Earning: $earning",
              textColor: isCompleted ? Colors.black38 : const Color(0xFFB8960A),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (!isCompleted) {
                    Navigator.push(context, route as Route<Object?>);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCompleted
                      ? const Color(0xFFDDDDDD)
                      : const Color(0xFFB8960A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  isCompleted ? "Completed" : "View Details",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:
                        isCompleted ? Colors.black38 : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, {Color? textColor}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFFB8960A)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: textColor ?? Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}