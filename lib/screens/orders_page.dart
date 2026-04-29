import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/screens/auth_service.dart';
import 'package:my_app/screens/tracking_page.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isParcels = true;
  bool _loading = true;
  List<Map<String, dynamic>> _myParcels = [];
  List<Map<String, dynamic>> _myTrips = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final parcels = await AuthService().getMyParcels();
    final trips = await AuthService().getMyTrips();
    if (mounted) {
      setState(() {
        _myParcels = parcels;
        _myTrips = trips;
        _loading = false;
      });
    }
  }

  // ── STATUS COLORS ────────────────────────────────────────
  Color _statusTextColor(String status) {
    switch (status.toLowerCase()) {
      case "accepted":
        return const Color(0xFF2E7D32);
      case "active":
        return const Color(0xFF1565C0);
      case "picked up":
        return Colors.orange;
      case "delivered":
        return Colors.grey;
      case "in transit":
      default:
        return const Color(0xFFB8960A);
    }
  }

  Color _statusBgColor(String status) {
    switch (status.toLowerCase()) {
      case "accepted":
        return const Color(0xFFE8F5E9);
      case "active":
        return const Color(0xFFE3F2FD);
      case "picked up":
        return const Color(0xFFFFF3E0);
      case "delivered":
        return const Color(0xFFE8E8E8);
      case "in transit":
      default:
        return const Color(0xFFF3E7C3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: Color(0xFFB8960A)))
                  : _isParcels
                      ? _parcelsList()
                      : _deliveriesList(),
            ),
          ],
        ),
      ),
    );
  }

  // ── HEADER ───────────────────────────────────────────────
  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 15),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => setState(() => _isParcels = false),
            child: Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: !_isParcels
                    ? const Color(0xFFB8960A)
                    : Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 3,
                      offset: Offset(0, 2))
                ],
              ),
              child: Center(
                child: Text(
                  "My Deliveries",
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
          GestureDetector(
            onTap: () => setState(() => _isParcels = true),
            child: Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: _isParcels
                    ? const Color(0xFFB8960A)
                    : Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 3,
                      offset: Offset(0, 2))
                ],
              ),
              child: Center(
                child: Text(
                  "My Parcels",
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

  // ── PARCELS LIST ─────────────────────────────────────────
  Widget _parcelsList() {
    if (_myParcels.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inventory_2_outlined,
                size: 60, color: Colors.black12),
            const SizedBox(height: 16),
            Text(
              'No parcels posted yet.',
              style: GoogleFonts.syne(
                  color: Colors.black38,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Post a parcel to get started.',
              style: GoogleFonts.manrope(
                  color: Colors.black26, fontSize: 13),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: const Color(0xFFB8960A),
      onRefresh: _loadData,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _myParcels.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final p = _myParcels[index];
          final status = p['status'] ?? 'Active';
          return _parcelCard(
            context: context,
            name: p['receiverName'] ?? 'Unknown receiver',
            route:
                '${p['pickupLocation'] ?? '—'} → ${p['destination'] ?? '—'}',
            date: p['deadline'] ?? '—',
            price: p['price'] != null ? '\$${p['price']}' : '—',
            orderId: 'Order #${p['id']?.toString().substring(0, 6).toUpperCase() ?? '------'}',
            from: p['pickupLocation'] ?? '—',
            to: p['destination'] ?? '—',
            parcelType: p['packageType'] ?? '—',
            weight: p['weight'] ?? '—',
            eta: '—',
            progress: 0.3,
            status: status,
          );
        },
      ),
    );
  }

  // ── DELIVERIES LIST ──────────────────────────────────────
  Widget _deliveriesList() {
    if (_myTrips.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.flight_outlined,
                size: 60, color: Colors.black12),
            const SizedBox(height: 16),
            Text(
              'No trips posted yet.',
              style: GoogleFonts.syne(
                  color: Colors.black38,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Plan a trip to start earning.',
              style: GoogleFonts.manrope(
                  color: Colors.black26, fontSize: 13),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: const Color(0xFFB8960A),
      onRefresh: _loadData,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _myTrips.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final t = _myTrips[index];
          return _deliveryCard(
            name:
                '${t['fromCity'] ?? '—'} → ${t['toCity'] ?? '—'}',
            route:
                '${t['fromCode'] ?? '—'} → ${t['toCode'] ?? '—'}',
            weight: '${t['luggageSpace'] ?? '—'} kg',
            date: t['departureDate'] ?? '—',
            earning: '\$${t['pricePerKg'] ?? '—'}/kg',
            status: 'Active',
            isCompleted: false,
          );
        },
      ),
    );
  }

  // ── PARCEL CARD ──────────────────────────────────────────
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
    required String status,
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
                  orderId,
                  style: GoogleFonts.syne(
                      fontSize: 15, fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _statusBgColor(status),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.manrope(
                    color: _statusTextColor(status),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            name.isEmpty ? 'No receiver name' : 'To: $name',
            style: GoogleFonts.manrope(
                color: Colors.black54,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 14),
          _infoRow(Icons.route, "Route: $route"),
          const SizedBox(height: 6),
          _infoRow(Icons.calendar_today, "Deadline: $date"),
          const SizedBox(height: 6),
          _infoRow(Icons.inventory_2_outlined, "$parcelType · $weight"),
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
                    builder: (_) => TrackingPage(
                      orderId: orderId,
                      carrierName: name,
                      routeFrom: from,
                      routeTo: to,
                      date: date,
                      price: price,
                      parcelType: parcelType,
                      weight: weight,
                      status: status,
                      eta: eta,
                      progress: progress,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB8960A),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                elevation: 0,
              ),
              child: const Text(
                "Track",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── DELIVERY CARD ────────────────────────────────────────
  Widget _deliveryCard({
    required String name,
    required String route,
    required String weight,
    required String date,
    required String earning,
    required String status,
    required bool isCompleted,
  }) {
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
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _statusBgColor(status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.manrope(
                      color: _statusTextColor(status),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _infoRow(Icons.route, "Route: $route · $weight"),
            const SizedBox(height: 6),
            _infoRow(Icons.calendar_today, "Departure: $date"),
            const SizedBox(height: 6),
            _infoRow(
              Icons.attach_money,
              "Price: $earning",
              textColor: isCompleted
                  ? Colors.black38
                  : const Color(0xFFB8960A),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isCompleted ? null : () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCompleted
                      ? const Color(0xFFDDDDDD)
                      : const Color(0xFFB8960A),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  elevation: 0,
                ),
                child: Text(
                  isCompleted ? "Completed" : "View Details",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? Colors.black38 : Colors.white,
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