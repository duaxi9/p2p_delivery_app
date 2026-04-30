import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  static const Color gold = Color(0xFFB8960A);
  static const Color bg = Color(0xFFFAFAFA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Help & Support',
          style: GoogleFonts.syne(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBox(),
            const SizedBox(height: 24),
            _sectionTitle('Topics'),
            _groupCard([
              _topic(Icons.inventory_2_outlined, 'Delivery Issues',
                  'Track, reschedule, report problems'),
              _topic(Icons.flight_takeoff, 'Trip Issues',
                  'Delays, cancellations & rebooking'),
              _topic(Icons.credit_card, 'Payments & Billing',
                  'Refunds, charges & payment methods'),
              _topic(Icons.shield_outlined, 'Account & Security',
                  'Password, privacy & access'),
              _topic(Icons.access_time, 'Orders & Tracking',
                  'Real-time updates & history'),
              _topic(Icons.person_outline, 'Profile & Settings',
                  'Edit info & preferences', isLast: true),
            ]),
            const SizedBox(height: 24),
            _sectionTitle('Common Questions'),
            _faq('How do I cancel an order?'),
            _faq('Where is my refund?'),
            _faq('How to change my delivery address?'),
            _faq('Can I modify my booking?'),
            const SizedBox(height: 24),
            _sectionTitle('Contact Us'),
            _groupCard([
              _contact(Icons.chat_bubble_outline, 'Live Chat',
                  'Average wait: 2 minutes',
                  trailing: _onlineBadge()),
              _contact(Icons.email_outlined, 'Email Support',
                  'Reply within 2 hours'),
              _contact(Icons.phone_outlined, 'Phone',
                  'Mon – Sun, 8 am – 10 pm',
                  isLast: true),
            ]),
            const SizedBox(height: 24),
            _ctaCard(),
          ],
        ),
      ),
    );
  }

   Widget _searchBox() {
  return Container(
    height: 46,
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE8E8E8)),
    ),
    child: TextField(
      style: GoogleFonts.manrope(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        icon: const Icon(Icons.search, color: Colors.black26, size: 20),
        hintText: 'Search for answers...',
        hintStyle: GoogleFonts.manrope(
          color: Colors.black26,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.manrope(
          color: Colors.black38,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _groupCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFEFEF)),
      ),
      child: Column(children: children),
    );
  }

  Widget _topic(
    IconData icon,
    String title,
    String subtitle, {
    bool isLast = false,
  }) {
    return _rowTile(
      icon: icon,
      title: title,
      subtitle: subtitle,
      isLast: isLast,
    );
  }

  Widget _contact(
    IconData icon,
    String title,
    String subtitle, {
    Widget? trailing,
    bool isLast = false,
  }) {
    return _rowTile(
      icon: icon,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      isLast: isLast,
    );
  }

  Widget _rowTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: Color(0xFFF5F5F5)),
              ),
      ),
      child: Row(
        children: [
          Icon(icon, color: gold, size: 20),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.manrope(
                    color: Colors.black38,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          trailing ??
              const Icon(
                Icons.chevron_right,
                color: Colors.black26,
                size: 20,
              ),
        ],
      ),
    );
  }

  Widget _faq(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEFEFEF)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.manrope(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.black26, size: 20),
        ],
      ),
    );
  }

  Widget _onlineBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'Online',
        style: GoogleFonts.manrope(
          color: const Color(0xFF2E7D32),
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _ctaCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFEFEF)),
      ),
      child: Column(
        children: [
          Text(
            'Still need help?',
            style: GoogleFonts.syne(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Our team is available 24/7',
            style: GoogleFonts.manrope(
              color: Colors.black38,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 13),
            decoration: BoxDecoration(
              color: gold,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Contact Support',
                style: GoogleFonts.syne(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}