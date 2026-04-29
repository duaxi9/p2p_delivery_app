import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListSearch extends StatefulWidget {
  const ListSearch({super.key, required String fromCity, required String toCity});

  @override
  State<ListSearch> createState() => _ListSearchState();
}

class _ListSearchState extends State<ListSearch> {
  String _activeFilter = 'All';
  final Set<String> _savedCards = {};

  bool _matchesFilter(String type, double rating, bool online, String delivery) {
    switch (_activeFilter) {
      case 'Plane':
        return type == 'Plane';
      case 'Car':
        return type == 'Car';
      case '⭐ 4.5+':
        return rating >= 4.5;
      case 'Fast':
        return type == 'Plane' || delivery == 'Airport';
      case 'Online now':
        return online == true;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Plane', 'Car', '⭐ 4.5+', 'Fast', 'Online now'];

    // ── Edit your cards here directly ──────────────
    final cards = [
      {'initials': 'MS', 'color': Color(0xFFE48ADA), 'name': 'Mehdi Saidi',    'rating': 4.9, 'trips': 48, 'route': 'ALG → CDG', 'date': 'Apr 22', 'kg': '12 kg free', 'price': '\$12/kg', 'type': 'Car',   'delivery': 'Hand-to-hand', 'online': true},
      {'initials': 'TL', 'color': Color(0xFF3467EB), 'name': 'Travis Loren',   'rating': 4.6, 'trips': 31, 'route': 'BRU → YUL', 'date': 'Apr 25', 'kg': '8 kg free',  'price': '\$10/kg', 'type': 'Plane', 'delivery': 'Airport',      'online': false},
      {'initials': 'SL', 'color': Color(0xFF0EA5A4), 'name': 'Sofia Lopez',    'rating': 4.8, 'trips': 22, 'route': 'NRT → PEK', 'date': 'Apr 28', 'kg': '5 kg free',  'price': '\$19/kg', 'type': 'Car',   'delivery': 'Home delivery','online': true},
      {'initials': 'ZD', 'color': Colors.blue,       'name': 'Zahra Deraji',   'rating': 4.3, 'trips': 35, 'route': 'CAI → TUN', 'date': 'Apr 22', 'kg': '12 kg free', 'price': '\$8/kg',  'type': 'Car',   'delivery': 'Hand-to-hand', 'online': true},
      {'initials': 'CB', 'color': Colors.orangeAccent,'name': 'Chris Brown',   'rating': 4.5, 'trips': 48, 'route': 'MRS → LHR', 'date': 'Apr 22', 'kg': '12 kg free', 'price': '\$22/kg', 'type': 'Plane', 'delivery': 'Airport',      'online': false},
    ];
    // ───────────────────────────────────────────────

    final filtered = cards.where((r) => _matchesFilter(
      r['type'] as String,
      (r['rating'] as num).toDouble(),
      r['online'] as bool,
      r['delivery'] as String,
    )).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F3),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Filters ─────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('FILTERS',
                      style: GoogleFonts.manrope(
                          color: Colors.black38,
                          fontSize: 11,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: filters.map((f) {
                        final isActive = _activeFilter == f;
                        return GestureDetector(
                          onTap: () => setState(() => _activeFilter = f),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFFB8960A)
                                  : const Color(0xFFF0F0EE),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              f,
                              style: GoogleFonts.manrope(
                                color: isActive ? Colors.white : Colors.black54,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 1),

            // ── Results ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('RESULTS (${filtered.length})',
                      style: GoogleFonts.manrope(
                          color: Colors.black38,
                          fontSize: 11,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w600)),
                  Text('Sort by price ↓',
                      style: GoogleFonts.manrope(
                          color: const Color(0xFFB8960A),
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: filtered.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text(
                          'No travelers found for this filter.',
                          style: GoogleFonts.manrope(
                            color: Colors.black38,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        ...filtered.map((r) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _resultCard(
                                initials: r['initials'] as String,
                                color: r['color'] as Color,
                                name: r['name'] as String,
                                rating: (r['rating'] as num).toDouble(),
                                trips: r['trips'] as int,
                                route: r['route'] as String,
                                date: r['date'] as String,
                                kg: r['kg'] as String,
                                price: r['price'] as String,
                                type: r['type'] as String,
                                delivery: r['delivery'] as String,
                                online: r['online'] as bool,
                              ),
                            )),
                        const SizedBox(height: 10),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultCard({
    required String initials,
    required Color color,
    required String name,
    required double rating,
    required int trips,
    required String route,
    required String date,
    required String kg,
    required String price,
    required String type,
    required String delivery,
    required bool online,
  }) {
    final isSaved = _savedCards.contains(name);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(initials,
                      style: GoogleFonts.syne(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (online)
                          Container(
                            width: 7,
                            height: 7,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2DC830),
                              shape: BoxShape.circle,
                            ),
                          ),
                        Text(name,
                            style: GoogleFonts.syne(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Text('⭐ $rating · $trips trips',
                        style: GoogleFonts.manrope(
                            color: Colors.black45, fontSize: 11)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSaved) {
                      _savedCards.remove(name);
                    } else {
                      _savedCards.add(name);
                    }
                  });
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSaved
                        ? const Color(0xFFFFE4E4)
                        : const Color(0xFFFFF3D4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isSaved ? Icons.favorite : Icons.favorite_border,
                    color: isSaved
                        ? const Color(0xFFE24B4A)
                        : const Color(0xFFB8960A),
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(route,
                  style: GoogleFonts.syne(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w700)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(date,
                    style: GoogleFonts.manrope(
                        color: Colors.black54, fontSize: 11)),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(kg,
                    style: GoogleFonts.manrope(
                        color: Colors.black54, fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0EE),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(type,
                        style: GoogleFonts.manrope(
                            color: Colors.black54, fontSize: 10)),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0EE),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(delivery,
                        style: GoogleFonts.manrope(
                            color: Colors.black54, fontSize: 10)),
                  ),
                ],
              ),
              Text(price,
                  style: GoogleFonts.syne(
                      color: const Color(0xFFB8960A),
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }
}