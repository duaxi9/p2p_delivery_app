import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfilePage extends StatelessWidget {
  final String initials;
  final Color color;
  final String name;
  final double rating;
  final int trips;
  final int deliveries;

  const UserProfilePage({
    super.key,
    required this.initials,
    required this.color,
    required this.name,
    required this.rating,
    required this.trips,
    required this.deliveries, String? otherUid, required tripId, required packageType, required weight, required destination, required proposedPayment, required packageNote,
  });

  Widget _acceptChip(String label, Color textColor, Color bgColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: GoogleFonts.syne(
          color: textColor,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _statBox(String value, String label, Color valueColor, double width) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value,
            style: GoogleFonts.syne(color: valueColor, fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 2),
          Text(label,
            style: GoogleFonts.syne(color: Colors.white30, fontSize: 10, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFFB8960A), size: 22),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                style: GoogleFonts.manrope(color: Colors.black38, fontSize: 12, fontWeight: FontWeight.w500),
              ),
              Text(value,
                style: GoogleFonts.syne(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
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
      backgroundColor: Color(0xFFEDEDEC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Container(
                  height: 240,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.black),
                ),
                Positioned(
                  top: 48,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios_new, color: Colors.white54, size: 22),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 35,
                  child: Row(
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                        ),
                        child: Center(
                          child: Text(initials,
                            style: GoogleFonts.syne(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name,
                              style: GoogleFonts.syne(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              width: 88,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 14, 39, 14),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    Icon(Icons.check, color: Color(0xFF009900), size: 11),
                                    const SizedBox(width: 4),
                                    Text('VERIFIED',
                                      style: GoogleFonts.syne(
                                        color: Color(0xFF009900),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 35,
                  child: Row(
                    children: [
                      _statBox('$trips', 'Trips', Colors.white, 100),
                      const SizedBox(width: 8),
                      _statBox(rating.toStringAsFixed(1), 'Rating', Color(0xFFB8960A), 110),
                      const SizedBox(width: 8),
                      _statBox('$deliveries', 'Deliveries', Colors.white, 110),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 26),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('Personal Information',
                style: GoogleFonts.syne(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            const SizedBox(height: 16),

            _infoRow(Icons.location_on, 'Current city', 'Algiers'),
            _infoRow(Icons.house_rounded, 'Hometown', 'Oran'),
            _infoRow(Icons.cake, 'Birthday', '25 March'),
            _infoRow(Icons.card_membership, 'Member Since', 'Jun 21, 2025'),

            Divider(color: Colors.black12, thickness: 1),
            const SizedBox(height: 7),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Accepts',
                style: GoogleFonts.syne(
                  color: Colors.black26,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13, vertical: 20),
              child: Container(
                width: 380,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))
                  ],
                ),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _acceptChip('Documents', Color(0xFFE37400), Color(0xFFFEF7E0)),
                    _acceptChip('Gift', Color(0xFFE37400), Color(0xFFFEF7E0)),
                    _acceptChip('Electronics', Color(0xFFE37400), Color(0xFFFEF7E0)),
                    _acceptChip('Fragile', Color(0xFFE37400), Color(0xFFFEF7E0)),
                    _acceptChip('Clothes', Color(0xFFE37400), Color(0xFFFEF7E0)),
                    _acceptChip('Other', Color(0xFFE37400), Color(0xFFFEF7E0)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}