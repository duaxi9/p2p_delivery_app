import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/screens/chat_page.dart';

class TrackingPage extends StatelessWidget {
  final String orderId;
  final String carrierName;
  final String routeFrom;
  final String routeTo;
  final String date;
  final String price;
  final String parcelType;
  final String weight;
  final String status;
  final String eta;
  final double progress;

  // ── Carrier chat params ──────────────────────
  final String carrierInitials;
  final Color carrierColor;
  final double carrierRating;
  final int carrierTrips;
  final int carrierDeliveries;
  final List<Map<String, dynamic>> carrierMessages;

  const TrackingPage({
    super.key,
    required this.orderId,
    required this.carrierName,
    required this.routeFrom,
    required this.routeTo,
    required this.date,
    required this.price,
    required this.parcelType,
    required this.weight,
    required this.status,
    required this.eta,
    required this.progress,
    this.carrierInitials = '',
    this.carrierColor = const Color(0xFFB8960A),
    this.carrierRating = 0.0,
    this.carrierTrips = 0,
    this.carrierDeliveries = 0,
    this.carrierMessages = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: _buildMapSection(context),
          ),
          Expanded(
            flex: 6,
            child: _buildBottomSheet(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF1A2535),
      ),
      child: Stack(
        children: [
          const Positioned.fill(child: _MapBackground()),
          CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: RealisticRoutePainter(),
          ),
          const Positioned(left: 34, bottom: 52, child: _OriginMarker()),
          const Positioned(left: 148, top: 130, child: _ParcelDot()),
          const Positioned(right: 42, top: 62, child: _DestinationMarker()),
          Positioned(left: 22, bottom: 72, child: _cityLabel(routeFrom)),
          Positioned(left: 118, top: 108, child: _cityLabel("Transit")),
          Positioned(right: 18, top: 90, child: _cityLabel(routeTo)),
          Positioned(
            top: 18,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: const Color(0xFF0E1620).withOpacity(0.95),
                  borderRadius: BorderRadius.circular(22),
                  // ignore: deprecated_member_use
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFFB8960A),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      status,
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "· ETA $eta",
                      style: GoogleFonts.manrope(
                        color: Colors.white54,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 18,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: const Color(0xFF0E1620).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(12),
                  // ignore: deprecated_member_use
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFD6D6D6),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: const Color(0xFFB8960A).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.inventory_2_outlined,
                      color: Color(0xFFB8960A),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderId,
                          style: GoogleFonts.syne(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: const Color.fromARGB(255, 237, 187, 88).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.manrope(
                        color: const Color(0xFFB8960A),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "DELIVERY PROGRESS",
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: const Color(0xFF9A9A9A),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: GoogleFonts.syne(
                    fontSize: 14,
                    color: const Color(0xFFB8960A),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 7,
                backgroundColor: const Color(0xFFF0F0F0),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFB8960A),
                ),
              ),
            ),
            const SizedBox(height: 22),
            _StopsRow(
              routeFrom: routeFrom,
              routeTo: routeTo,
            ),
            const SizedBox(height: 22),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Parcel details",
                    style: GoogleFonts.syne(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _detailRow("From", routeFrom),
                  const SizedBox(height: 10),
                  _detailRow("To", routeTo),
                  const SizedBox(height: 10),
                  _detailRow("Date", date),
                  const SizedBox(height: 10),
                  _detailRow("Type", parcelType),
                  const SizedBox(height: 10),
                  _detailRow("Weight", weight),
                  const SizedBox(height: 10),
                  _detailRow("Price", price),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: const Color(0xFFB8960A).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Color(0xFFB8960A),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Carrier: $carrierName",
                          style: GoogleFonts.syne(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Parcel handler",
                          style: GoogleFonts.manrope(
                            fontSize: 11,
                            color: const Color(0xFF8A8A8A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                // ── Navigate to carrier's ChatPage ──
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatPage(
                      initials: carrierInitials.isNotEmpty
                          ? carrierInitials
                          : carrierName
                              .split(' ')
                              .map((e) => e.isNotEmpty ? e[0] : '')
                              .take(2)
                              .join()
                              .toUpperCase(),
                      color: carrierColor,
                      name: carrierName,
                      messages: carrierMessages,
                      rating: carrierRating,
                      trips: carrierTrips,
                      deliveries: carrierDeliveries,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A1A1A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Contact carrier",
                  style: GoogleFonts.syne(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String title, String value) {
    return Row(
      children: [
        SizedBox(
          width: 62,
          child: Text(
            "$title:",
            style: GoogleFonts.manrope(
              fontSize: 13,
              color: const Color(0xFF8A8A8A),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.syne(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _cityLabel(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(0.28),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: GoogleFonts.manrope(
          color: Colors.white70,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _MapBackground extends StatelessWidget {
  const _MapBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MapGridPainter(),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFF1A2535),
    );

    final blockPaint = Paint()
      ..color = const Color(0xFF1F2D40)
      ..style = PaintingStyle.fill;

    final roadPaint = Paint()
      ..color = const Color(0xFF243347)
      ..style = PaintingStyle.fill;

    final majorRoadPaint = Paint()
      ..color = const Color(0xFF2C3E55)
      ..style = PaintingStyle.fill;

    final blocks = [
      Rect.fromLTWH(0, 0, 60, 35),
      Rect.fromLTWH(68, 0, 80, 35),
      Rect.fromLTWH(156, 0, 55, 35),
      Rect.fromLTWH(219, 0, 70, 35),
      Rect.fromLTWH(297, 0, 60, 35),
      Rect.fromLTWH(0, 43, 45, 50),
      Rect.fromLTWH(53, 43, 90, 50),
      Rect.fromLTWH(151, 43, 60, 50),
      Rect.fromLTWH(219, 43, 50, 50),
      Rect.fromLTWH(277, 43, 80, 50),
      Rect.fromLTWH(0, 101, 70, 45),
      Rect.fromLTWH(78, 101, 60, 45),
      Rect.fromLTWH(146, 101, 75, 45),
      Rect.fromLTWH(229, 101, 55, 45),
      Rect.fromLTWH(292, 101, 65, 45),
      Rect.fromLTWH(0, 154, 50, 55),
      Rect.fromLTWH(58, 154, 85, 55),
      Rect.fromLTWH(151, 154, 65, 55),
      Rect.fromLTWH(224, 154, 75, 55),
      Rect.fromLTWH(307, 154, 50, 55),
      Rect.fromLTWH(10, 217, 60, 60),
      Rect.fromLTWH(78, 217, 70, 60),
      Rect.fromLTWH(156, 217, 55, 60),
      Rect.fromLTWH(219, 217, 80, 60),
      Rect.fromLTWH(307, 217, 50, 60),
    ];

    for (final block in blocks) {
      final rRect = RRect.fromRectAndRadius(block, const Radius.circular(3));
      canvas.drawRRect(rRect, blockPaint);
    }

    final hRoads = [
      Rect.fromLTWH(0, 37, size.width, 4),
      Rect.fromLTWH(0, 97, size.width, 4),
      Rect.fromLTWH(0, 150, size.width, 4),
      Rect.fromLTWH(0, 211, size.width, 4),
    ];
    for (final r in hRoads) {
      canvas.drawRect(r, roadPaint);
    }

    final vRoads = [
      Rect.fromLTWH(62, 0, 4, size.height),
      Rect.fromLTWH(145, 0, 4, size.height),
      Rect.fromLTWH(217, 0, 4, size.height),
      Rect.fromLTWH(290, 0, 4, size.height),
    ];
    for (final r in vRoads) {
      canvas.drawRect(r, roadPaint);
    }

    canvas.drawRect(Rect.fromLTWH(0, 118, size.width, 7), majorRoadPaint);
    canvas.drawRect(Rect.fromLTWH(150, 0, 7, size.height), majorRoadPaint);

    final waterPaint = Paint()..color = const Color(0xFF162030);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(-10, size.height - 60, 120, 80),
        const Radius.circular(40),
      ),
      waterPaint,
    );

    final parkPaint = Paint()..color = const Color(0xFF1C3028);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width - 90, 40, 100, 60),
        const Radius.circular(6),
      ),
      parkPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _OriginMarker extends StatelessWidget {
  const _OriginMarker();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: const Color(0xFF1D9E75),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2.5),
          ),
        ),
      ],
    );
  }
}

class _DestinationMarker extends StatelessWidget {
  const _DestinationMarker();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFFE24B4A),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Icon(Icons.place, color: Colors.white, size: 16),
        ),
        Container(width: 2, height: 8, color: const Color(0xFFE24B4A)),
        Container(
          width: 6,
          height: 3,
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: const Color(0xFFE24B4A).withOpacity(0.4),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ],
    );
  }
}

class _ParcelDot extends StatelessWidget {
  const _ParcelDot();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: const Color(0xFFB8960A),
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: const Color(0xFFB8960A).withOpacity(0.35),
                blurRadius: 8,
              ),
            ],
          ),
          child: const Icon(Icons.inventory_2, size: 15, color: Colors.white),
        ),
        Container(width: 2, height: 6, color: const Color(0xFFB8960A)),
        Container(
          width: 5,
          height: 3,
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: const Color(0xFFB8960A).withOpacity(0.3),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ],
    );
  }
}

class _ParcelPulse extends StatefulWidget {
  const _ParcelPulse();

  @override
  State<_ParcelPulse> createState() => _ParcelPulseState();
}

class _ParcelPulseState extends State<_ParcelPulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = 1 + (_controller.value * 1.2);
        final opacity = 1 - _controller.value;

        return Opacity(
          opacity: opacity * 0.5,
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFB8960A),
                  width: 2,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StopsRow extends StatelessWidget {
  final String routeFrom;
  final String routeTo;

  const _StopsRow({
    required this.routeFrom,
    required this.routeTo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StopItem(
          title: routeFrom,
          subtitle: "Picked up",
          color: const Color(0xFF1D9E75),
          active: true,
        ),
        const _StopLine(color: Color(0xFF1D9E75)),
        const _StopItem(
          title: "Sorting",
          subtitle: "Passed",
          color: Color(0xFF1D9E75),
          active: true,
        ),
        const _StopLine(color: Color(0xFFB8960A)),
        const _StopItem(
          title: "Transit",
          subtitle: "Now",
          color: Color(0xFFB8960A),
          active: true,
          highlightText: true,
        ),
        const _StopLine(color: Color(0xFFE4E4E4)),
        _StopItem(
          title: routeTo,
          subtitle: "Arriving",
          color: const Color(0xFFE24B4A),
          active: true,
        ),
      ],
    );
  }
}

class _StopItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final bool active;
  final bool highlightText;

  const _StopItem({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.active,
    this.highlightText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 62,
      child: Column(
        children: [
          Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              color: active ? color : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 10,
              color: highlightText ? const Color(0xFFB8960A) : color,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 9,
              color: const Color(0xFF9A9A9A),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _StopLine extends StatelessWidget {
  final Color color;

  const _StopLine({required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 30),
        color: color,
      ),
    );
  }
}

// ignore: unused_element
class _InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final bool gold;

  const _InfoCard({
    required this.label,
    required this.value,
    // ignore: unused_element_parameter
    this.gold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: GoogleFonts.manrope(
              fontSize: 10,
              color: const Color(0xFF9A9A9A),
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.syne(
              fontSize: 14,
              color: gold ? const Color(0xFFB8960A) : Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class RealisticRoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(42, size.height - 54)
      ..quadraticBezierTo(90, size.height - 90, 130, size.height - 102)
      ..quadraticBezierTo(172, size.height - 116, 196, size.height - 130)
      ..quadraticBezierTo(238, size.height - 155, size.width - 90, 80);

    canvas.drawPath(
      path,
      Paint()
        // ignore: deprecated_member_use
        ..color = const Color(0xFFB8960A).withOpacity(0.12)
        ..strokeWidth = 14
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    _drawDashed(
      canvas,
      path,
      Paint()
        // ignore: deprecated_member_use
        ..color = const Color(0xFF8A7A5A).withOpacity(0.5)
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    final activePath = Path()
      ..moveTo(42, size.height - 54)
      ..quadraticBezierTo(90, size.height - 90, 130, size.height - 102)
      ..quadraticBezierTo(172, size.height - 116, 196, size.height - 130);

    canvas.drawPath(
      activePath,
      Paint()
        ..color = const Color(0xFFB8960A)
        ..strokeWidth = 3.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  void _drawDashed(Canvas canvas, Path path, Paint paint) {
    const dashWidth = 8.0;
    const dashSpace = 5.0;
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}