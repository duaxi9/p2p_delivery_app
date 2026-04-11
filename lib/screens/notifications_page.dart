import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SectionTitle(title: "TODAY"),
                    const SizedBox(height: 12),

                    _notificationCard(
                      borderColor: const Color(0xFFB8960A),
                      iconBg: const Color(0xFFF1E0A6),
                      icon: Icons.call_outlined,
                      iconColor: const Color(0xFF8A6A00),
                      title: "Mehdi Saidi accepted",
                      time: "2 min ago",
                      message:
                          "Your parcel Paris → ALG (9 kg) has been accepted. Expected Apr 12.",
                      actions: [
                        _actionButton(
                          text: "Track",
                          bgColor: Colors.black,
                          textColor: Colors.white,
                          borderColor: Colors.black,
                          onTap: () {},
                        ),
                        const SizedBox(width: 10),
                        _actionButton(
                          text: "Message",
                          bgColor: Colors.white,
                          textColor: const Color(0xFFB8960A),
                          borderColor: const Color(0xFFB8960A),
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    _notificationCard(
                      borderColor: const Color(0xFF59B96B),
                      iconBg: const Color(0xFFE6F3E8),
                      icon: Icons.check,
                      iconColor: const Color(0xFF59B96B),
                      title: "Delivery confirmed",
                      time: "1 hr ago",
                      message:
                          "Yacine Mansouri confirmed receipt of your parcel. ALG → IST (5 kg).",
                      bottomWidget: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6F3E8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Completed",
                          style: GoogleFonts.manrope(
                            color: const Color(0xFF3E9A55),
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    _notificationCard(
                      borderColor: const Color(0xFF4A90FF),
                      iconBg: const Color(0xFFEAF2FD),
                      icon: Icons.chat_bubble_outline,
                      iconColor: const Color(0xFF4A90FF),
                      title: "New message",
                      time: "3 hrs ago",
                      message:
                          'Mehdi: "I\'ll be at Algiers airport around 6 PM, is that OK?"',
                      actions: [
                        _actionButton(
                          text: "Reply",
                          bgColor: Colors.white,
                          textColor: const Color(0xFF4A90FF),
                          borderColor: const Color(0xFF4A90FF),
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    const _SectionTitle(title: "YESTERDAY"),
                    const SizedBox(height: 12),

                    _notificationCard(
                      borderColor: const Color(0xFFE25C5C),
                      iconBg: const Color(0xFFF8E8EC),
                      icon: Icons.error_outline,
                      iconColor: const Color(0xFFE25C5C),
                      title: "Delivery delayed",
                      time: "Apr 8",
                      message:
                          "Your parcel CDG → ALG was delayed due to a flight change. New ETA: Apr 13.",
                    ),

                    const SizedBox(height: 14),

                    _notificationCard(
                      borderColor: const Color(0xFF9B59B6),
                      iconBg: const Color(0xFFF2E8F7),
                      icon: Icons.layers_outlined,
                      iconColor: const Color(0xFF9B59B6),
                      title: "New traveler nearby",
                      time: "Apr 8",
                      message:
                          "A traveler is going from ALG → DXB on Apr 16. Match your parcel now.",
                      actions: [
                        _actionButton(
                          text: "View traveler",
                          bgColor: const Color(0xFFB8960A),
                          textColor: Colors.white,
                          borderColor: const Color(0xFFB8960A),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Notifications",
              style: GoogleFonts.syne(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Mark all read",
              style: GoogleFonts.manrope(
                color: const Color(0xFFB8960A),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationCard({
    required Color borderColor,
    required Color iconBg,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String time,
    required String message,
    List<Widget>? actions,
    Widget? bottomWidget,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border(
          left: BorderSide(
            color: borderColor,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.syne(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    height: 1.45,
                    color: const Color(0xFF555555),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (bottomWidget != null) ...[
                  const SizedBox(height: 12),
                  bottomWidget,
                ],
                if (actions != null && actions.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: actions,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _actionButton({
    required String text,
    required Color bgColor,
    required Color textColor,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 40,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: bgColor,
          side: BorderSide(color: borderColor, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Text(
          text,
          style: GoogleFonts.manrope(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.manrope(
        fontSize: 14,
        color: const Color(0xFF9D9D9D),
        fontWeight: FontWeight.w800,
        letterSpacing: 1,
      ),
    );
  }
}