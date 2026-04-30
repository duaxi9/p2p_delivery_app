// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:my_app/models/trip_model.dart';
import 'package:my_app/screens/plan_trip.dart';
import 'package:my_app/screens/share_trip_page.dart';
import 'package:my_app/screens/auth_service.dart';

class TravelerPage extends StatefulWidget {
  const TravelerPage({super.key});

  @override
  State<TravelerPage> createState() => _TravelerPageState();
}

class _TravelerPageState extends State<TravelerPage> {
  TripModel? currentTrip;
  bool _loadingTrip = true;

  @override
  void initState() {
    super.initState();
    _loadMyLatestTrip();
  }

  Future<void> _loadMyLatestTrip() async {
    final trips = await AuthService().getMyTrips();

    if (!mounted) return;

    if (trips.isNotEmpty) {
      final data = trips.first;

      setState(() {
        currentTrip = TripModel(
          fromCode: (data['fromCode'] ?? '').toString(),
          fromCity: (data['fromCity'] ?? '').toString(),
          toCode: (data['toCode'] ?? '').toString(),
          toCity: (data['toCity'] ?? '').toString(),
          departureDate: (data['departureDate'] ?? '').toString(),
          flightNumber: (data['flightNumber'] ?? '').toString(),
          luggageSpace: (data['luggageSpace'] ?? '').toString(),
          pricePerKg: (data['pricePerKg'] ?? '8').toString(),
        );

        _loadingTrip = false;
      });
    } else {
      setState(() {
        _loadingTrip = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final trip = currentTrip;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              const SizedBox(height: 24),

              _sectionTitle('PLAN TRIP'),
              const SizedBox(height: 14),
              _buildPlanTripCard(context),

              const SizedBox(height: 28),

              _sectionTitle('YOUR TRIP'),
              const SizedBox(height: 14),

              _loadingTrip
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(
                          color: Color(0xFFB8960A),
                        ),
                      ),
                    )
                  : trip != null
                      ? _buildTripCard(context, trip)
                      : _buildEmptyTripCard(),

              const SizedBox(height: 28),

              _sectionTitle('PARCEL REQUESTS'),
              const SizedBox(height: 14),
              _emptyParcelSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black87,
            size: 20,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Carry & Earn',
          style: GoogleFonts.syne(
            color: const Color(0xFFB8960A),
            fontSize: 26,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Carry parcels, earn money on every trip',
          style: GoogleFonts.manrope(
            color: Colors.black38,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 20),
        const Divider(color: Colors.black12, thickness: 1),
      ],
    );
  }

  Widget _buildPlanTripCard(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () async {
        final TripModel? newTrip = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PlanTripPage(),
          ),
        );

        if (newTrip != null) {
          setState(() {
            currentTrip = newTrip;
          });

          await _loadMyLatestTrip();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF1E5CC),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(Icons.map, color: Color(0xFFC49A00)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Plan trip',
                style: GoogleFonts.syne(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTripCard(BuildContext context, TripModel trip) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFFB8960A).withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.flight_takeoff_rounded,
            color: Color(0xFFB8960A),
            size: 24,
          ),
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: _tripCityBlock(
                label: 'From',
                code: trip.fromCode,
                city: trip.fromCity,
                alignRight: false,
              ),
            ),
            Column(
              children: [
                const Icon(
                  Icons.flight_rounded,
                  color: Color(0xFFB8960A),
                  size: 20,
                ),
                const SizedBox(height: 6),
                Container(
                  width: 70,
                  height: 1.4,
                  color: const Color(0xFFE6D6A8),
                ),
              ],
            ),
            Expanded(
              child: _tripCityBlock(
                label: 'To',
                code: trip.toCode,
                city: trip.toCity,
                alignRight: true,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7F5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _tripInfoRow(
                icon: Icons.calendar_today_outlined,
                title: 'Departure',
                value: trip.departureDate,
              ),
              const SizedBox(height: 12),
              _tripInfoRow(
                icon: Icons.confirmation_number_outlined,
                title: 'Flight',
                value: trip.flightNumber,
              ),
              const SizedBox(height: 12),
              _tripInfoRow(
                icon: Icons.luggage_rounded,
                title: 'Available space',
                value: '${trip.luggageSpace} kg',
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: _smallStat(
                value: '0',
                label: 'Requests',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _smallStat(
                value: '0',
                label: 'Accepted',
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShareTripPage(trip: trip),
                    ),
                  );
                },
                icon: const Icon(Icons.ios_share_rounded, size: 18),
                label: Text(
                  'Share trip',
                  style: GoogleFonts.syne(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB8960A),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: Text(
          'Delete trip?',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this trip?',
          style: GoogleFonts.manrope(
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: GoogleFonts.manrope(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 228, 50, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.syne(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      );
    },
  );

  if (confirm == true) {
    setState(() {
      currentTrip = null;
    });
  }
},
                icon: const Icon(Icons.delete_outline_rounded, size: 18),
                label: Text(
                  'Delete',
                  style: GoogleFonts.syne(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  side: const BorderSide(color: Color(0xFFE0E0E0)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _tripCityBlock({
  required String label,
  required String code,
  required String city,
  required bool alignRight,
}) {
  return Column(
    crossAxisAlignment:
        alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.manrope(
          color: Colors.black38,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        code,
        style: GoogleFonts.syne(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w900,
        ),
      ),
      Text(
        city,
        style: GoogleFonts.manrope(
          color: Colors.black45,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

Widget _tripInfoRow({
  required IconData icon,
  required String title,
  required String value,
}) {
  return Row(
    children: [
      Icon(icon, color: const Color(0xFFB8960A), size: 18),
      const SizedBox(width: 10),
      Text(
        title,
        style: GoogleFonts.manrope(
          color: Colors.black45,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
      const Spacer(),
      Text(
        value,
        style: GoogleFonts.syne(
          color: Colors.black87,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

Widget _smallStat({
  required String value,
  required String label,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(
      color: const Color(0xFFF7F7F5),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: GoogleFonts.syne(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: GoogleFonts.manrope(
            color: Colors.black38,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

  Widget _buildEmptyTripCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          'No trip yet',
          style: GoogleFonts.syne(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }



  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.manrope(
        letterSpacing: 2,
        color: Colors.grey,
        fontSize: 12,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _emptyParcelSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          'No parcel requests yet',
          style: GoogleFonts.syne(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}