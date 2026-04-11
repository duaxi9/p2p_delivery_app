import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchSystem extends StatelessWidget {
  const MatchSystem({super.key});

  Widget _travelerCard({
    required BuildContext context,
    required String initials,
    required Color color,
    required String name,
    required String route,
    required String details,
    required double rating,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Avatar + Info ──────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: GoogleFonts.syne(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
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
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      route,
                      style: GoogleFonts.manrope(
                        color: Colors.black54,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          details,
                          style: GoogleFonts.manrope(
                            color: Colors.black38,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.star, color: Color(0xFFB8960A), size: 14),
                        const SizedBox(width: 3),
                        Text(
                          rating.toString(),
                          style: GoogleFonts.manrope(
                            color: Color(0xFFB8960A),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ── Buttons ───────────────────────────
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: Colors.black12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'View Profile',
                    style: GoogleFonts.syne(
                      color: Colors.black87,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Color(0xFFB8960A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Send Request',
                    style: GoogleFonts.syne(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDEC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black12,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 7),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios, size: 19, color: Colors.black87),
              ),
              const SizedBox(width:30),
              Text(
                'Matching Travelers',
                style: GoogleFonts.syne(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        
      
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Matching Travelers Found (3)',
              style: GoogleFonts.manrope(
                color: Colors.black54,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            _travelerCard(
              context: context,
              initials: 'AB',
              color: Colors.orange,
              name: 'Aimen Bacha',
              route: 'Paris → Algiers',
              details: 'May 12 · 5 kg available',
              rating: 4.8,
            ),

            _travelerCard(
              context: context,
              initials: 'FS',
              color: Colors.blueGrey,
              name: 'Fredric Simon',
              route: 'Germany → Nice',
              details: 'Dec 31 · 20 kg available',
              rating: 4.6,
            ),

            _travelerCard(
              context: context,
              initials: 'SD',
              color: Color(0xFF0EA5A4),
              name: 'Sophie Dubois',
              route: 'New York → Dubai',
              details: 'feb 5 · 16 kg available',
              rating: 4.7,
            ),

            

            const Divider(color: Colors.black12, thickness: 1),
            const SizedBox(height: 16),

            Center(
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'See More Travelers',
                      style: GoogleFonts.syne(
                        color: Color(0xFFB8960A),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(Icons.arrow_forward, color: Color(0xFFB8960A), size: 18),
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