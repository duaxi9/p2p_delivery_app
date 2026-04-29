import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/models/trip_model.dart';

class ShareTripPage extends StatelessWidget {
  final TripModel trip;

  const ShareTripPage({super.key, required this.trip});

  String get tripLink {
    final from = trip.fromCity.toLowerCase().replaceAll(' ', '-');
    final to = trip.toCity.toLowerCase().replaceAll(' ', '-');
    return 'https://linkair.app/trip/$from-$to-${trip.flightNumber.toLowerCase()}';
  }

  void _copyLink(BuildContext context) {
    Clipboard.setData(ClipboardData(text: tripLink));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Link copied!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _ghostCard(),
                  const SizedBox(height: 12),
                  _ghostCard(),
                  const SizedBox(height: 12),
                  _ghostCard(),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 46,
                          height: 5,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD8D3CC),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),

                      const Text(
                        'Share your trip',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Let senders find you and request delivery',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF9A9080),
                        ),
                      ),

                      const SizedBox(height: 24),

                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F2EC),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFE3DDD3)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3E4A5),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.link,
                                color: Color(0xFFC49A00),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                tripLink,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFC49A00),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () => _copyLink(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFC49A00),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Text(
                                'Copy',
                                style: GoogleFonts.syne(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        'SHARE VIA',
                        style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFA0A7B3),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _ShareItem(
                            icon: FontAwesomeIcons.whatsapp,
                            label: 'WhatsApp',
                            color: Color(0xFF25D366),
                            onTap: () => _copyLink(context),
                          ),
                          _ShareItem(
                            icon: FontAwesomeIcons.facebook,
                            label: 'Facebook',
                            color: Color(0xFF1877F2),
                            onTap: () => _copyLink(context),
                          ),
                          _ShareItem(
                            icon: FontAwesomeIcons.instagram,
                            label: 'Instagram',
                            color: Color(0xFFE1306C),
                            onTap: () => _copyLink(context),
                          ),
                          _ShareItem(
                            icon: FontAwesomeIcons.envelope,
                            label: 'Email',
                            color: Color(0xFFB8960A),
                            onTap: () => _copyLink(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _ghostCard() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFE6E4E1),
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}

class _ShareItem extends StatelessWidget {
  final dynamic icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ShareItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F3F1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: FaIcon(
                icon,
                color: color,
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.manrope(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}