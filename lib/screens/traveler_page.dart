import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:my_app/models/trip_model.dart';
import 'package:my_app/screens/plan_trip.dart';
import 'package:my_app/screens/share_trip_page.dart';

class TravelerPage extends StatefulWidget {
  const TravelerPage({super.key});

  @override
  State<TravelerPage> createState() => _TravelerPageState();
}

class _TravelerPageState extends State<TravelerPage> {
  TripModel? currentTrip;

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
              trip != null ? _buildTripCard(context, trip) : _buildEmptyTripCard(),

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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _city(trip.fromCode, trip.fromCity),
              const Icon(Icons.flight),
              _city(trip.toCode, trip.toCity),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Departs ${trip.departureDate}',
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Flight ${trip.flightNumber}',
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  value: '0',
                  label: 'REQUESTS',
                  valueColor: Colors.orange,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  value: '0',
                  label: 'ACCEPTED',
                  valueColor: Colors.black,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  value: '${trip.luggageSpace} kg',
                  label: 'AVAILABLE',
                  valueColor: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShareTripPage(trip: trip),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC49A00),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Share trip',
                    style: GoogleFonts.syne(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      currentTrip = null;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black12),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Delete trip',
                    style: GoogleFonts.syne(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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

  Widget _city(String code, String city) {
    return Column(
      children: [
        Text(
          code,
          style: GoogleFonts.syne(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          city,
          style: GoogleFonts.manrope(
            color: Colors.grey,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required String value,
    required String label,
    required Color valueColor,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w800,
            color: valueColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 11,
            color: Colors.black45,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
      ],
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