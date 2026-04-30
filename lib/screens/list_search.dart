// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/screens/user_profile_page.dart';
import 'package:my_app/screens/auth_service.dart';

class ParcelRequest {
  final String fromCity;
  final String toCity;
  final String description;
  final String packageType;
  final double weight;
  final String price;

  const ParcelRequest({
    required this.fromCity,
    required this.toCity,
    required this.description,
    required this.packageType,
    required this.weight,
    required this.price,
  });
}

class ListSearch extends StatefulWidget {
  final ParcelRequest parcel;

  const ListSearch({
    super.key,
    required this.parcel,
    required String fromCity,
    required String toCity,
  });

  @override
  State<ListSearch> createState() => _ListSearchState();
}

class _ListSearchState extends State<ListSearch> {
  String _activeFilter = 'All';
  final Set<String> _savedCards = {};
  List<Map<String, dynamic>> _trips = [];
  bool _loading = true;

  final Map<String, String> _requestStatuses = {};
  final Map<String, bool> _sendingRequest = {};

  @override
  void initState() {
    super.initState();
    _loadTrips();
  }

  Future<void> _loadTrips() async {
    final trips = await AuthService().getTrips(
      fromCity: widget.parcel.fromCity,
      toCity: widget.parcel.toCity,
    );

    for (final trip in trips) {
      final tripId = (trip['id'] ?? '').toString();
      final travelerUid = (trip['uid'] ?? '').toString();

      if (tripId.isNotEmpty && travelerUid.isNotEmpty) {
        final status = await AuthService().checkRequestStatus(
          toUid: travelerUid,
          tripId: tripId,
        );

        _requestStatuses[tripId] = status.toString();
      }
    }

    if (mounted) {
      setState(() {
        _trips = trips;
        _loading = false;
      });
    }
  }

  bool _matchesFilter(Map<String, dynamic> trip) {
    switch (_activeFilter) {
      case 'Plane':
        return true;
      case '⭐ 4.5+':
        return true;
      case 'Online now':
        return true;
      default:
        return true;
    }
  }

  Future<void> _sendRequest(Map<String, dynamic> trip) async {
    final tripId = (trip['id'] ?? '').toString();
    final travelerUid = (trip['uid'] ?? '').toString();
    final travelerName = (trip['travelerName'] ?? 'Traveler').toString();

    if (tripId.isEmpty || travelerUid.isEmpty) return;

    setState(() => _sendingRequest[tripId] = true);

    final result = await AuthService().sendDeliveryRequest(
      toUid: travelerUid,
      toName: travelerName,
      tripId: tripId,
      packageNote: widget.parcel.description,
      packageType: widget.parcel.packageType,
      weight: widget.parcel.weight.toStringAsFixed(1),
      destination: widget.parcel.toCity,
      proposedPayment: widget.parcel.price,
    );

    final resultText = result.toString();

    if (mounted) {
      setState(() {
        _sendingRequest[tripId] = false;

        if (resultText == 'success' || resultText == 'already_sent') {
          _requestStatuses[tripId] = 'pending';
        }
      });

      if (resultText == 'success' || resultText == 'already_sent') {
        _showRequestSnack(travelerName, success: true);
      } else {
        _showRequestSnack(
          travelerName,
          success: false,
          error: resultText,
        );
      }
    }
  }

  void _showRequestSnack(
    String name, {
    required bool success,
    String? error,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? '✓ Request sent to $name! They\'ll be notified.'
              : 'Failed: $error',
          style: GoogleFonts.manrope(fontSize: 13),
        ),
        backgroundColor: success ? const Color(0xFF111111) : Colors.red,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> get filtered =>
      _trips.where((t) => _matchesFilter(t)).toList();

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Plane', '⭐ 4.5+', 'Online now'];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F3),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildParcelSummary(),
            _buildFilters(filters),
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFB8960A),
                      ),
                    )
                  : filtered.isEmpty
                      ? _buildEmpty()
                      : _buildList(filtered),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    // ignore: duplicate_ignore
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black87,
                size: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Matching Travelers',
                  style: GoogleFonts.syne(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '${widget.parcel.fromCity} → ${widget.parcel.toCity}',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: Colors.black38,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParcelSummary() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.inventory_2_outlined,
            color: Color(0xFFB8960A),
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '${widget.parcel.packageType}  •  ${widget.parcel.weight.toStringAsFixed(1)} kg  •  ${widget.parcel.fromCity} → ${widget.parcel.toCity}',
              style: GoogleFonts.manrope(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (widget.parcel.price.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFB8960A),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${widget.parcel.price} DA',
                style: GoogleFonts.syne(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilters(List<String> filters) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: filters.map((f) {
                  final isActive = _activeFilter == f;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _activeFilter = f;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFFB8960A)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                          ),
                        ],
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
          ),
          Text(
            '${filtered.length} found',
            style: GoogleFonts.manrope(
              color: Colors.black38,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0EE),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.search_off_rounded,
              color: Colors.black26,
              size: 32,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'No travelers found',
            style: GoogleFonts.syne(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try different cities or a later date',
            style: GoogleFonts.manrope(
              fontSize: 13,
              color: Colors.black38,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> trips) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: trips.length,
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _travelerCard(trips[i]),
      ),
    );
  }

  Widget _travelerCard(Map<String, dynamic> trip) {
    final name = (trip['travelerName'] ?? 'Unknown').toString();
    final tripId = (trip['id'] ?? '').toString();
    final travelerUid = (trip['uid'] ?? '').toString();
    final isSaved = _savedCards.contains(tripId);
    final status = (_requestStatuses[tripId] ?? 'none').toString();
    final isSending = _sendingRequest[tripId] ?? false;

    final rating = double.tryParse((trip['rating'] ?? '4.5').toString()) ?? 4.5;
    final tripsCount = int.tryParse((trip['tripsCount'] ?? '0').toString()) ?? 0;
    final deliveriesCount =
        int.tryParse((trip['deliveriesCount'] ?? '0').toString()) ?? 0;

    final initials = name
        .split(' ')
        .map((e) => e.isNotEmpty ? e[0] : '')
        .take(2)
        .join()
        .toUpperCase();

    final avatarColors = [
      const Color(0xFFB8960A),
      const Color(0xFF3467EB),
      Colors.red,
      const Color(0xFF2E7D32),
      const Color(0xFF6A1B9A),
      const Color(0xFF00838F),
    ];

    final avatarColor = avatarColors[name.length % avatarColors.length];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserProfilePage(
                            initials: initials,
                            color: avatarColor,
                            name: name,
                            rating: rating,
                            trips: tripsCount,
                            deliveries: deliveriesCount,
                            otherUid: travelerUid,
                            tripId: tripId,
                            packageType: widget.parcel.packageType,
                            weight: widget.parcel.weight.toStringAsFixed(1),
                            destination: widget.parcel.toCity,
                            proposedPayment: widget.parcel.price,
                            packageNote: widget.parcel.description,
                          ),
                        ),
                      ),
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: avatarColor,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Center(
                          child: Text(
                            initials,
                            style: GoogleFonts.syne(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.syne(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Color(0xFFB8960A),
                                size: 13,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                rating.toStringAsFixed(1),
                                style: GoogleFonts.manrope(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Flight ${(trip['flightNumber'] ?? '—').toString()}',
                                style: GoogleFonts.manrope(
                                  fontSize: 11,
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSaved) {
                            _savedCards.remove(tripId);
                          } else {
                            _savedCards.add(tripId);
                          }
                        });
                      },
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: isSaved
                              ? const Color(0xFFFFE4E4)
                              : const Color(0xFFF5F5F3),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Icon(
                          isSaved ? Icons.favorite : Icons.favorite_border,
                          color: isSaved
                              ? const Color(0xFFE24B4A)
                              : Colors.black26,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFF0F0EE)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${(trip['fromCity'] ?? '').toString()} → ${(trip['toCity'] ?? '').toString()}',
                        style: GoogleFonts.syne(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    _chip(
                      (trip['departureDate'] ?? '—').toString(),
                      Icons.calendar_today_rounded,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _chip(
                      '${(trip['luggageSpace'] ?? '?').toString()} kg free',
                      Icons.luggage_rounded,
                    ),
                    const SizedBox(width: 6),
                    _chip('Plane', Icons.flight_rounded),
                    const Spacer(),
                    Text(
                      '\$${(trip['pricePerKg'] ?? '0').toString()}/kg',
                      style: GoogleFonts.syne(
                        color: const Color(0xFFB8960A),
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: _buildRequestButton(
              trip: trip,
              status: status,
              isSending: isSending,
              tripId: tripId,
              travelerUid: travelerUid,
              name: name,
              initials: initials,
              avatarColor: avatarColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestButton({
    required Map<String, dynamic> trip,
    required String status,
    required bool isSending,
    required String tripId,
    required String travelerUid,
    required String name,
    required String initials,
    required Color avatarColor,
  }) {
    if (isSending) {
      return Container(
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    switch (status) {
      case 'pending':
        return Container(
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFFEF7E0),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFB8960A).withOpacity(0.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.hourglass_top_rounded,
                color: Color(0xFFB8960A),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Request Sent',
                style: GoogleFonts.syne(
                  color: const Color(0xFFB8960A),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );

      case 'accepted':
        return Container(
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: Color(0xFF2E7D32),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Accepted ✓',
                style: GoogleFonts.syne(
                  color: const Color(0xFF2E7D32),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );

      case 'declined':
        return GestureDetector(
          onTap: () => _sendRequest(trip),
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE25C5C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.refresh, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Try Again',
                  style: GoogleFonts.syne(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );

      default:
        return GestureDetector(
          onTap: () => _sendRequest(trip),
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.send_rounded,
                  color: Color(0xFFB8960A),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Send Request',
                  style: GoogleFonts.syne(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }

  Widget _chip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: Colors.black38),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.manrope(
              color: Colors.black54,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}