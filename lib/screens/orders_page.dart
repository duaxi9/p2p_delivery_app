// ignore_for_file: deprecated_member_use

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
    setState(() => _loading = true);
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

  Color _statusTextColor(String status) {
    switch (status.toLowerCase()) {
      case "accepted": return const Color(0xFF2E7D32);
      case "active":   return const Color(0xFF1565C0);
      case "picked up": return Colors.orange;
      case "delivered": return Colors.grey;
      default:         return const Color(0xFFB8960A);
    }
  }

  Color _statusBgColor(String status) {
    switch (status.toLowerCase()) {
      case "accepted":  return const Color(0xFFE8F5E9);
      case "active":    return const Color(0xFFE3F2FD);
      case "picked up": return const Color(0xFFFFF3E0);
      case "delivered": return const Color(0xFFE8E8E8);
      default:          return const Color(0xFFF3E7C3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F0),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFFB8960A)))
                  : RefreshIndicator(
                      color: const Color(0xFFB8960A),
                      onRefresh: _loadData,
                      child: _isParcels ? _parcelsList() : _deliveriesList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ── HEADER TAB ────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        Row(
              children: [
                _tabBtn('My Parcels', true),
                _tabBtn('My Deliveries', false),
              ],
            ),
        ],
          ),
      
      
    );
  }

  Widget _tabBtn(String label, bool isParcelsTab) {
    final active = _isParcels == isParcelsTab;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _isParcels = isParcelsTab),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? const Color(0xFFB8960A) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(label,
                style: GoogleFonts.syne(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: active ? Colors.white : Colors.black54)),
          ),
        ),
      ),
    );
  }

  // ── MY PARCELS (sender view — read only) ──────────────────
  Widget _parcelsList() {
    if (_myParcels.isEmpty) {
      return _emptyState(
        icon: Icons.inventory_2_outlined,
        title: 'No parcels posted yet',
        subtitle: 'Post a parcel to find a traveler',
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _myParcels.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final p = _myParcels[index];
        final status = (p['status'] ?? 'Pending').toString();
        return _parcelCard(p, status);
      },
    );
  }

  Widget _parcelCard(Map<String, dynamic> p, String status) {
    final orderId = 'LA-${(p['id'] ?? '------').toString().substring(0, 6).toUpperCase()}';
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top row ──────────────────────────────────────
          Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF7E0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.inventory_2_outlined, color: Color(0xFFB8960A), size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order #$orderId',
                        style: GoogleFonts.syne(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black)),
                    Text('${p['packageType'] ?? '—'} · ${p['weight'] ?? '—'}',
                        style: GoogleFonts.manrope(fontSize: 12, color: Colors.black45, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _statusBgColor(status),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(status,
                    style: GoogleFonts.manrope(
                        color: _statusTextColor(status), fontSize: 11, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFF0F0EE)),
          const SizedBox(height: 12),
          // ── Route ────────────────────────────────────────
          _infoChip(Icons.route, '${p['pickupLocation'] ?? '—'} → ${p['destination'] ?? '—'}'),
          const SizedBox(height: 8),
          _infoChip(Icons.calendar_today, 'Deadline: ${p['deadline'] ?? '—'}'),
          const SizedBox(height: 8),
          _infoChip(Icons.attach_money, 'Proposed: \$${p['price'] ?? '—'}'),
          if ((p['deliveryType'] ?? '').isNotEmpty) ...[
            const SizedBox(height: 8),
            _infoChip(Icons.local_shipping_outlined, p['deliveryType']),
          ],
          const SizedBox(height: 14),
          // ── Tracking progress (READ ONLY for sender) ──────
          _senderProgressBar(status),
        ],
      ),
    );
  }

  Widget _senderProgressBar(String status) {
    final steps = ['Posted', 'Matched', 'Picked up', 'In Transit', 'Delivered'];
    int activeStep = 0;
    switch (status.toLowerCase()) {
      case 'pending': activeStep = 0; break;
      case 'matched': activeStep = 1; break;
      case 'picked up': activeStep = 2; break;
      case 'in transit': activeStep = 3; break;
      case 'delivered': activeStep = 4; break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Delivery Status',
            style: GoogleFonts.manrope(fontSize: 11, color: Colors.black38, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
        const SizedBox(height: 10),
        Row(
          children: List.generate(steps.length, (i) {
            final done = i <= activeStep;
            final isLast = i == steps.length - 1;
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 20, height: 20,
                          decoration: BoxDecoration(
                            color: done ? const Color(0xFFB8960A) : const Color(0xFFEDEDED),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: done ? const Color(0xFFB8960A) : const Color(0xFFD0D0D0),
                              width: 2,
                            ),
                          ),
                          child: done
                              ? const Icon(Icons.check, color: Colors.white, size: 11)
                              : null,
                        ),
                        const SizedBox(height: 4),
                        Text(steps[i],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.manrope(
                                fontSize: 8,
                                color: done ? const Color(0xFFB8960A) : Colors.black26,
                                fontWeight: done ? FontWeight.w600 : FontWeight.w500)),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        height: 2,
                        margin: const EdgeInsets.only(bottom: 20),
                        color: i < activeStep ? const Color(0xFFB8960A) : const Color(0xFFEDEDED),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  // ── MY DELIVERIES (traveler view — interactive) ───────────
  Widget _deliveriesList() {
    if (_myTrips.isEmpty) {
      return _emptyState(
        icon: Icons.flight_outlined,
        title: 'No trips posted yet',
        subtitle: 'Plan a trip to start carrying parcels',
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _myTrips.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final t = _myTrips[index];
        return _tripCard(t);
      },
    );
  }

  Widget _tripCard(Map<String, dynamic> t) {
    final fromCity = t['fromCity'] ?? '—';
    final toCity = t['toCity'] ?? '—';
    final fromCode = t['fromCode'] ?? '—';
    final toCode = t['toCode'] ?? '—';
    final date = t['departureDate'] ?? '—';
    final flight = t['flightNumber'] ?? '—';
    final luggage = t['luggageSpace'] ?? '—';
    final price = t['pricePerKg'] ?? '—';
    final tripId = t['id']?.toString() ?? '';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Route header ──────────────────────────────────
          Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.flight, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$fromCode → $toCode',
                        style: GoogleFonts.syne(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black)),
                    Text('$fromCity → $toCity',
                        style: GoogleFonts.manrope(fontSize: 12, color: Colors.black45, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Active',
                    style: GoogleFonts.manrope(color: const Color(0xFF1565C0), fontSize: 11, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFF0F0EE)),
          const SizedBox(height: 12),
          // ── Trip details ──────────────────────────────────
          Row(
            children: [
              Expanded(child: _infoChip(Icons.calendar_today, date)),
              const SizedBox(width: 8),
              Expanded(child: _infoChip(Icons.flight_takeoff, flight)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _infoChip(Icons.luggage, '$luggage kg available')),
              const SizedBox(width: 8),
              Expanded(child: _infoChip(Icons.attach_money, '\$$price/kg')),
            ],
          ),
          const SizedBox(height: 16),
          // ── View Details button ───────────────────────────
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TrackingPage(
                    orderId: 'Trip #${tripId.substring(0, 6).toUpperCase()}',
                    carrierName: t['travelerName'] ?? '—',
                    routeFrom: fromCity,
                    routeTo: toCity,
                    date: date,
                    price: '\$$price/kg',
                    parcelType: 'Trip',
                    weight: '$luggage kg',
                    status: 'Active',
                    eta: '—',
                    progress: 0.3,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF111111),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: Text('View & Update Delivery',
                  style: GoogleFonts.syne(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFFB8960A)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text,
              style: GoogleFonts.manrope(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  Widget _emptyState({required IconData icon, required String title, required String subtitle}) {
    return ListView(
      children: [
        SizedBox(height: 120),
        Icon(icon, size: 64, color: Colors.black12),
        const SizedBox(height: 16),
        Center(
          child: Text(title,
              style: GoogleFonts.syne(color: Colors.black38, fontSize: 16, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(subtitle,
              style: GoogleFonts.manrope(color: Colors.black26, fontSize: 13)),
        ),
      ],
    );
  }

}