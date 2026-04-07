import 'package:flutter/material.dart';

class TravelerPage extends StatelessWidget {
  const TravelerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "i'm Traveling",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topSection(),
            const SizedBox(height: 28),
            _sectionTitle("YOUR TRIP"),
            const SizedBox(height: 14),
            _tripSection(context),
            const SizedBox(height: 22),
            _addAnotherTripCard(),
            const SizedBox(height: 28),
            _sectionTitle("PARCEL REQUESTS"),
            const SizedBox(height: 14),
            _parcelRequestRow(),
          ],
        ),
      ),
    );
  }

  Widget _topSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Travel smarter, earn more",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Carry parcels on your route and make extra money while you travel.",
          style: TextStyle(
            fontSize: 14,
            height: 1.35,
            color: Color(0xFF6F6F6F),
          ),
        ),
        SizedBox(height: 18),
        _ModeBadgeSimple(),
      ],
    );
  }

  Widget _tripSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ALG",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Algiers",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6A6A6A),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Icon(
                  Icons.flight,
                  color: Colors.black,
                  size: 18,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "CDG",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Paris",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6A6A6A),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Wrap(
            spacing: 22,
            runSpacing: 10,
            children: [
              _TripInfoText(text: "Departs Apr 18"),
              _TripInfoText(text: "Flight AF1234"),
              _TripInfoText(text: "12 kg free"),
              _TripInfoText(text: "\$8/kg min"),
            ],
          ),
          const SizedBox(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _TripStatSimple(
                value: "3",
                label: "REQUESTS",
                valueColor: Color(0xFFC88717),
              ),
              _TripStatSimple(
                value: "0",
                label: "ACCEPTED",
                valueColor: Colors.black,
              ),
              _TripStatSimple(
                value: "12 kg",
                label: "AVAILABLE",
                valueColor: Color(0xFF1F5FBF),
              ),
            ],
          ),
          const SizedBox(height: 26),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                    showModalBottomSheet(
                    context: context,
                   isScrollControlled: true,
                   backgroundColor: Colors.transparent,
                   builder: (context) => const ShareTripSheet(),
                     );
                    },
                    icon: const Icon(Icons.share_outlined, size: 18),
                    label: const Text(
                      "Share trip",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      // ignore: deprecated_member_use
                      shadowColor: Colors.black.withOpacity(0.15),
                      backgroundColor: const Color(0xFFB8960A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () {
                    showDialog(
                    context: context,
                    barrierDismissible: true,
                   builder: (context) => const DeleteTripDialog(),
                    );
                       },
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text(
                      "Delete trip",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFD14B3D),
                      side: const BorderSide(
                        color: Color(0xFFF0A19A),
                        width: 1.2,
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
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

  Widget _addAnotherTripCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4E9D2),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 46,
            height: 46,
            child: Center(
              child: Text(
                "+",
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFFC88717),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add another trip",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Flying somewhere else? Add a second route.",
                  style: TextStyle(
                    color: Color(0xFF5F5F5F),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.black,
            size: 22,
          ),
        ],
      ),
    );
  }

  Widget _parcelRequestRow() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFFE1E1E1),
            child: Text(
              "AB",
              style: TextStyle(
                color: Color.fromARGB(255, 68, 68, 68),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Alice Brown",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "2 kg · \$16 · Pending",
                  style: TextStyle(
                    color: Color(0xFF5F5F5F),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF4E9D2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              "Accept",
              style: TextStyle(
                color: Color(0xFFB8960A),
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF9DA3AE),
        letterSpacing: 3,
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ModeBadgeSimple extends StatelessWidget {
  const _ModeBadgeSimple();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF4E9D2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            size: 10,
            color: Color(0xFFC88717),
          ),
          SizedBox(width: 10),
          Text(
            "Traveler mode active",
            style: TextStyle(
              color: Color(0xFF9A6A08),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _TripInfoText extends StatelessWidget {
  final String text;

  const _TripInfoText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _TripStatSimple extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;

  const _TripStatSimple({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 11,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
class ShareTripSheet extends StatelessWidget {
  const ShareTripSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// HANDLE
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 14),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Share your trip",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 4),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "ALG → CDG · Apr 18 · AF1234",
              style: TextStyle(color: Colors.grey),
            ),
          ),

          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.link, size: 18, color: Colors.grey),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    "imtraveling.app/trip/ALG-CDG-AF1234",
                    style: TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4E9D2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Copy",
                    style: TextStyle(
                      color: Color(0xFFB8960A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _ShareItem(Icons.chat, "WhatsApp", Color(0xFF25D366)),
              _ShareItem(Icons.facebook, "Facebook", Color(0xFF1877F2)),
              _ShareItem(Icons.camera_alt, "Instagram", Color.fromARGB(255, 241, 36, 104)),
              _ShareItem(Icons.email_outlined, "Email", Color(0xFFEA4335)),
              _ShareItem(Icons.more_horiz, "More", Colors.grey),
            ],
          ),

          const SizedBox(height: 16),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text("Copy trip details"),
            subtitle: const Text("Copy as text summary"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.qr_code),
            title: const Text("Show QR code"),
            subtitle: const Text("Let others scan to view trip"),
            onTap: () {},
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF0F0F0),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text("Cancel"),
            ),
          ),
        ],
      ),
    );
  }
}
class _ShareItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ShareItem(this.icon, this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
class DeleteTripDialog extends StatelessWidget {
  const DeleteTripDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 22),

            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: Color(0xFFFFEFEF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline,
                color: Color(0xFFE35656),
                size: 34,
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              "Delete this trip?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 12),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Text(
                "Your trip ALG → CDG on Apr 18 will be permanently removed and senders won't be able to find it anymore.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0xFF5F6470),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8EDD0),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.warning_amber_rounded,
                      color: Color(0xFFC88912),
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "You have 3 pending parcel requests. Deleting will automatically decline all of them.",
                      style: TextStyle(
                        color: Color(0xFFAA6E00),
                        fontSize: 13,
                        height: 1.45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            const Divider(height: 1, color: Color(0xFFE7E7E7)),

            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(26),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const SizedBox(
                        height: 56,
                        child: Center(
                          child: Text(
                            "Keep trip",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    color: const Color(0xFFE7E7E7),
                  ),
                  Expanded(
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(26),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const SizedBox(
                        height: 56,
                        child: Center(
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFF4A43),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}