import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            child: _buildBottomSheet(),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1D2732),
            Color(0xFF233445),
            Color(0xFF1C2835),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          const Positioned.fill(child: _MapBackground()),
          CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: RealisticRoutePainter(),
          ),
          const Positioned(
            left: 34,
            bottom: 52,
            child: _OriginMarker(),
          ),
          const Positioned(
            left: 150,
            top: 132,
            child: _ParcelPulse(),
          ),
          const Positioned(
            left: 160,
            top: 142,
            child: _ParcelDot(),
          ),
          const Positioned(
            right: 42,
            top: 66,
            child: _DestinationMarker(),
          ),
          Positioned(
            left: 64,
            bottom: 84,
            child: _cityLabel(routeFrom),
          ),
          Positioned(
            left: 122,
            top: 112,
            child: _cityLabel("Transit"),
          ),
          Positioned(
            right: 24,
            top: 98,
            child: _cityLabel(routeTo),
          ),
          Positioned(
            top: 18,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: const Color(0xFF121212).withOpacity(0.92),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE24B4A),
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
                        color: Colors.white70,
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
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.22),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
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
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "$parcelType · $weight",
                          style: GoogleFonts.manrope(
                            fontSize: 13,
                            color: const Color(0xFF8A8A8A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: const Color(0xFF1D9E75).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF0F6E56),
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
            Row(
              children: [
                Expanded(
                  child: _InfoCard(
                    label: "Status",
                    value: status,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _InfoCard(
                    label: "Expected",
                    value: eta,
                    gold: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _InfoCard(
                    label: "Price",
                    value: price,
                  ),
                ),
              ],
            ),
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
                onPressed: () {},
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
    return Stack(
      children: [
        Positioned(
          left: -30,
          top: 30,
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: const Color(0xFF2A3948).withOpacity(0.35),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          right: -40,
          bottom: 20,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: const Color(0xFF2A3948).withOpacity(0.25),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 42,
          left: -10,
          right: 40,
          child: Container(
            height: 2,
            // ignore: deprecated_member_use
            color: const Color(0xFF34485B).withOpacity(0.65),
          ),
        ),
        Positioned(
          top: 92,
          left: 20,
          right: -20,
          child: Container(
            height: 2,
            // ignore: deprecated_member_use
            color: const Color(0xFF34485B).withOpacity(0.55),
          ),
        ),
        Positioned(
          top: 170,
          left: -10,
          right: 30,
          child: Container(
            height: 2,
            // ignore: deprecated_member_use
            color: const Color(0xFF34485B).withOpacity(0.55),
          ),
        ),
        Positioned(
          left: 72,
          top: -10,
          bottom: 0,
          child: Container(
            width: 2,
            // ignore: deprecated_member_use
            color: const Color(0xFF34485B).withOpacity(0.6),
          ),
        ),
        Positioned(
          left: 228,
          top: 0,
          bottom: -10,
          child: Container(
            width: 2,
            // ignore: deprecated_member_use
            color: const Color(0xFF34485B).withOpacity(0.45),
          ),
        ),
        Positioned(
          right: 78,
          top: 0,
          bottom: 10,
          child: Container(
            width: 2,
            // ignore: deprecated_member_use
            color: const Color(0xFF34485B).withOpacity(0.55),
          ),
        ),
        Positioned(
          top: 122,
          left: -10,
          right: -10,
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: const Color(0xFF526B82).withOpacity(0.8),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        Positioned(
          left: 154,
          top: -10,
          bottom: -10,
          child: Container(
            width: 5,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: const Color(0xFF526B82).withOpacity(0.75),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}

class _OriginMarker extends StatelessWidget {
  const _OriginMarker();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: const Color(0xFF1D9E75),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: const Color(0xFF1D9E75).withOpacity(0.35),
            blurRadius: 10,
          ),
        ],
      ),
    );
  }
}

class _DestinationMarker extends StatelessWidget {
  const _DestinationMarker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFFE24B4A),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: const Color(0xFFE24B4A).withOpacity(0.35),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        Container(
          width: 2,
          height: 9,
          color: const Color(0xFFE24B4A),
        ),
      ],
    );
  }
}

class _ParcelDot extends StatelessWidget {
  const _ParcelDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: const Color(0xFFB8960A),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.white, width: 2.5),
      ),
      child: const Icon(
        Icons.inventory_2,
        size: 12,
        color: Colors.white,
      ),
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

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final bool gold;

  const _InfoCard({
    required this.label,
    required this.value,
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
    final shadowPaint = Paint()
      // ignore: deprecated_member_use
      ..color = Colors.black.withOpacity(0.18)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dashedPaint = Paint()
      ..color = const Color(0xFFB8960A)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final activePaint = Paint()
      ..color = const Color(0xFFB8960A)
      ..strokeWidth = 4.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final glowPaint = Paint()
      // ignore: deprecated_member_use
      ..color = const Color(0xFFB8960A).withOpacity(0.18)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(42, size.height - 54)
      ..quadraticBezierTo(88, size.height - 88, 128, size.height - 100)
      ..quadraticBezierTo(170, size.height - 112, 194, size.height - 126)
      ..quadraticBezierTo(235, size.height - 150, size.width - 92, 84);

    final activePath = Path()
      ..moveTo(42, size.height - 54)
      ..quadraticBezierTo(88, size.height - 88, 128, size.height - 100)
      ..quadraticBezierTo(170, size.height - 112, 194, size.height - 126);

    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, glowPaint);
    _drawDashedPath(canvas, path, dashedPaint);
    canvas.drawPath(activePath, activePaint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const dashWidth = 9.0;
    const dashSpace = 6.0;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final nextDistance = distance + dashWidth;
        final extractPath = metric.extractPath(
          distance,
          nextDistance.clamp(0, metric.length),
        );
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}