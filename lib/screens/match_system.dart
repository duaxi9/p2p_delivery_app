import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/screens/Search_page.dart';
import 'package:my_app/screens/auth_service.dart';

class MatchSystem extends StatefulWidget {
  /// Pass the sender's pickup and destination so we can match real trips
  final String? pickupLocation;
  final String? destination;

  const MatchSystem({super.key, this.pickupLocation, this.destination});

  @override
  State<MatchSystem> createState() => _MatchSystemState();
}

class _MatchSystemState extends State<MatchSystem> {
  List<Map<String, dynamic>> _trips = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadTrips();
  }

  Future<void> _loadTrips() async {
    // Extract city names from "City (CODE)" format if needed
    String? from = widget.pickupLocation;
    String? to = widget.destination;

    if (from != null && from.contains('(')) from = from.split('(').first.trim();
    if (to != null && to.contains('(')) to = to.split('(').first.trim();

    final trips = await AuthService().getTrips(fromCity: from, toCity: to);
    setState(() {
      _trips = trips;
      _loading = false;
    });
  }

  Widget _travelerCard(Map<String, dynamic> trip) {
    final initials = (trip['travelerName'] ?? '?')
        .toString()
        .split(' ')
        .map((e) => e.isNotEmpty ? e[0] : '')
        .take(2)
        .join()
        .toUpperCase();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52, height: 52,
                decoration: BoxDecoration(color: const Color(0xFFB8960A), borderRadius: BorderRadius.circular(14)),
                child: Center(child: Text(initials, style: GoogleFonts.syne(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(trip['travelerName'] ?? 'Unknown', style: GoogleFonts.syne(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text('${trip['fromCity']} → ${trip['toCity']}', style: GoogleFonts.manrope(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(
                      '${trip['departureDate']} · ${trip['luggageSpace']} kg · \$${trip['pricePerKg']}/kg',
                      style: GoogleFonts.manrope(color: Colors.black38, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(color: Colors.black12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('View Profile', style: GoogleFonts.syne(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: const Color(0xFFB8960A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: Text('Send Request', style: GoogleFonts.syne(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDEC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black12,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 7),
          child: Row(
            children: [
              GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios, size: 19, color: Colors.black87)),
              const SizedBox(width: 30),
              Text('Matching Travelers', style: GoogleFonts.syne(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800)),
            ],
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFB8960A)))
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.pickupLocation != null && widget.destination != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        // ignore: deprecated_member_use
                        decoration: BoxDecoration(color: const Color(0xFFB8960A).withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            const Icon(Icons.route, color: Color(0xFFB8960A), size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${widget.pickupLocation} → ${widget.destination}',
                                style: GoogleFonts.manrope(color: const Color(0xFFB8960A), fontSize: 13, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Text(
                    'Matching Travelers Found (${_trips.length})',
                    style: GoogleFonts.manrope(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  if (_trips.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Column(
                          children: [
                            const Icon(Icons.search_off, color: Colors.black26, size: 48),
                            const SizedBox(height: 12),
                            Text(
                              'No travelers found for this route yet.\nCheck back soon or search manually.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.manrope(color: Colors.black38, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ..._trips.map((t) => _travelerCard(t)),
                  const Divider(color: Colors.black12, thickness: 1),
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Search())),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('See More Travelers', style: GoogleFonts.syne(color: const Color(0xFFB8960A), fontSize: 15, fontWeight: FontWeight.w700)),
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward, color: Color(0xFFB8960A), size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }
}