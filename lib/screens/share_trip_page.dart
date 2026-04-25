import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

                      // Trip info
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F6F2),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${trip.fromCity} (${trip.fromCode}) → ${trip.toCity} (${trip.toCode})',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Flight ${trip.flightNumber} • ${trip.departureDate}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8D8374),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Link box
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
                              ),
                              child: const Text('Copy'),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        'SHARE VIA',
                        style: TextStyle(
                          letterSpacing: 3,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFA0A7B3),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Wrap(
                        spacing: 14,
                        children: [
                          _ShareItem(
                            icon: Icons.chat,
                            label: 'WhatsApp',
                            color: Colors.green,
                            onTap: () => _copyLink(context),
                          ),
                          _ShareItem(
                            icon: Icons.facebook,
                            label: 'Facebook',
                            color: Colors.blue,
                            onTap: () => _copyLink(context),
                          ),
                          _ShareItem(
                            icon: Icons.email,
                            label: 'Email',
                            color: Colors.red,
                            onTap: () => _copyLink(context),
                          ),
                          _ShareItem(
                            icon: Icons.camera_alt,
                            label: 'Instagram',
                            color: Colors.purple,
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
  final IconData icon;
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
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 55,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F0EC),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 6),
          Text(label),
        ],
      ),
    );
  }
}