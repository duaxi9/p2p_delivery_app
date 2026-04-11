import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2p_delivery_app/models/trip_model.dart';
import 'package:p2p_delivery_app/screens/plan_trip.dart';
import 'package:p2p_delivery_app/screens/share_trip_page.dart';


class TravelerPage extends StatefulWidget {
  const TravelerPage({super.key});

  @override
  State<TravelerPage> createState() => _TravelerPageState();
}

class _TravelerPageState extends State<TravelerPage> {
  TripModel? currentTrip;

  @override
  Widget build(BuildContext context) {
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

              currentTrip != null
                  ? _buildTripCard(context)
                  : _buildEmptyTripCard(context),

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

  // ================= HEADER =================
  Widget _header(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
      ),
      const SizedBox(height: 10),
      Text(
        'Carry & Earn',
        style: GoogleFonts.syne(
          color: Color(0xFFB8960A),
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
      Divider(color: Colors.black12, thickness: 1),
    ],
  );
}
  // ================= PLAN TRIP =================
  Widget _buildPlanTripCard(BuildContext context) {
    return InkWell(
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
            Icon(Icons.map, color: Color(0xFFC49A00)),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                "Plan trip",
                style: GoogleFonts.syne(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  // ================= TRIP CARD =================
  Widget _buildTripCard(BuildContext context) {
    if (currentTrip == null) {
      return _buildEmptyTripCard(context);
    }

    final trip = currentTrip!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // Route
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _city(trip.fromCode, trip.fromCity),
              const Icon(Icons.flight),
              _city(trip.toCode, trip.toCity),
            ],
          ),

          const SizedBox(height: 16),

          // Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Departs ${trip.departureDate}"),
              Text("Flight ${trip.flightNumber}"),
            ],
          ),

          const SizedBox(height: 20),

          // Stats
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
                  valueColor: Colors.blue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: currentTrip == null
    ? null
    : () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShareTripPage(trip: currentTrip!),
          ),
        );
      },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC49A00),
                  ),
                  child: const Text("Share trip"),
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
                  child: const Text("Delete trip"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= EMPTY TRIP =================
  Widget _buildEmptyTripCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child:
        Text('No trip yet',
        style: GoogleFonts.syne(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  
                )
        
        ),
        
      ),
    );
  }

  // ================= HELPERS =================
  Widget _city(String code, String city) {
    return Column(
      children: [
        Text(code, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(city, style: const TextStyle(color: Colors.grey)),
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
        Text(label),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        letterSpacing: 2,
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _emptyParcelSection() {
    return Center(
      child: Text('No parcel requests yet',
      style: GoogleFonts.syne(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  
                )
      
      ),
    );
  }
}