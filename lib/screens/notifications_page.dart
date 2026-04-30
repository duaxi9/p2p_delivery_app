// ignore_for_file: deprecated_member_use, duplicate_ignore, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/screens/auth_service.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = AuthService().currentUid;

    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, uid),
            Expanded(
              child: uid == null
                  ? _empty('No Notifications yet ')
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('notifications')
                          .where('uid', isEqualTo: uid)
                          .orderBy('createdAt', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: Color(0xFFB8960A)));
                        }
                        if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return _empty(
                              'No notifications yet.\nYou\'ll be notified about your deliveries here.');
                        }
                        final docs = snapshot.data!.docs;
                        return ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(12, 12, 12, 20),
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            final data = docs[index].data()
                                as Map<String, dynamic>;
                            return _notificationCard(
                                context, data, docs[index].id, uid);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _empty(String msg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.notifications_none,
              color: Colors.black26, size: 52),
          const SizedBox(height: 12),
          Text(msg,
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.manrope(color: Colors.black38, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String? uid) {
    return Container(
      color: const Color(0xFFEDEDED),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios_new, size: 20)),
          const SizedBox(width: 10),
          Expanded(
            child: Text("Notifications",
                style: GoogleFonts.syne(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
          ),
          if (uid != null)
            TextButton(
              onPressed: () async {
                final batch = FirebaseFirestore.instance.batch();
                final snap = await FirebaseFirestore.instance
                    .collection('notifications')
                    .where('uid', isEqualTo: uid)
                    .where('read', isEqualTo: false)
                    .get();
                for (final doc in snap.docs) {
                  batch.update(doc.reference, {'read': true});
                }
                await batch.commit();
              },
              child: Text("Mark all read",
                  style: GoogleFonts.manrope(
                      color: const Color(0xFFB8960A),
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
            ),
        ],
      ),
    );
  }

  Widget _notificationCard(BuildContext context,
      Map<String, dynamic> data, String docId, String uid) {
    final type = (data['type'] ?? 'info').toString();
    final title = (data['title'] ?? 'Notification').toString();
    final message = (data['message'] ?? '').toString();
    final bool isRead = data['read'] ?? false;
    final timestamp = data['createdAt'];

    String time = '';
    if (timestamp != null) {
      try {
        final dt = (timestamp as Timestamp).toDate();
        final diff = DateTime.now().difference(dt);
        if (diff.inMinutes < 60)
          time = '${diff.inMinutes}m ago';
        else if (diff.inHours < 24)
          time = '${diff.inHours}h ago';
        else
          time = '${diff.inDays}d ago';
      } catch (_) {}
    }

    // ── Request card: tap to view parcel details ──────────────────
    if (type == 'request') {
      return _requestNotificationCard(
          context, data, docId, isRead, time, title, message);
    }

    final config = _typeConfig(type);

    return GestureDetector(
      onTap: () async {
        if (!isRead) {
          await FirebaseFirestore.instance
              .collection('notifications')
              .doc(docId)
              .update({'read': true});
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isRead ? Colors.white : const Color(0xFFFFFBF0),
          borderRadius: BorderRadius.circular(24),
          border: Border(
              left: BorderSide(
                  color: config['borderColor'] as Color, width: 4)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 3))
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                  color: config['iconBg'] as Color,
                  shape: BoxShape.circle),
              child: Icon(config['icon'] as IconData,
                  color: config['iconColor'] as Color, size: 26),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(title,
                              style: GoogleFonts.syne(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black))),
                      if (!isRead)
                        Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                                color: Color(0xFFB8960A),
                                shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      Text(time,
                          style: GoogleFonts.manrope(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(message,
                      style: GoogleFonts.manrope(
                          fontSize: 14,
                          height: 1.45,
                          color: const Color(0xFF555555),
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _requestNotificationCard(
    BuildContext context,
    Map<String, dynamic> data,
    String docId,
    bool isRead,
    String time,
    String title,
    String message,
  ) {
    final requestId = (data['requestId'] ?? '').toString();
    final fromName = (data['fromName'] ?? 'Someone').toString();

    final initials = fromName
        .split(' ')
        .map((e) => e.isNotEmpty ? e[0] : '')
        .take(2)
        .join()
        .toUpperCase();

    final avatarColors = [
      const Color(0xFF3467EB),
      Colors.red,
      const Color(0xFF2E7D32),
      const Color(0xFF6A1B9A),
      const Color(0xFF00838F),
      const Color(0xFFB8960A),
    ];
    final avatarColor = avatarColors[fromName.length % avatarColors.length];

    return _RequestCard(
      docId: docId,
      requestId: requestId,
      initials: initials,
      avatarColor: avatarColor,
      fromName: fromName,
      packageNote: (data['packageNote'] ?? '').toString(),
      packageType: (data['packageType'] ?? '').toString(),
      weight: (data['weight'] ?? '').toString(),
      destination: (data['destination'] ?? '').toString(),
      proposedPayment: (data['proposedPayment'] ?? '').toString(),
      time: time,
      isRead: isRead,
    );
  }

  Map<String, dynamic> _typeConfig(String type) {
    switch (type) {
      case 'accepted':
        return {
          'borderColor': const Color(0xFFB8960A),
          'iconBg': const Color(0xFFF1E0A6),
          'icon': Icons.check_circle_outline,
          'iconColor': const Color(0xFF8A6A00)
        };
      case 'declined':
        return {
          'borderColor': const Color(0xFFE25C5C),
          'iconBg': const Color(0xFFF8E8EC),
          'icon': Icons.cancel_outlined,
          'iconColor': const Color(0xFFE25C5C)
        };
      case 'delivered':
        return {
          'borderColor': const Color(0xFF59B96B),
          'iconBg': const Color(0xFFE6F3E8),
          'icon': Icons.done_all,
          'iconColor': const Color(0xFF59B96B)
        };
      case 'message':
        return {
          'borderColor': const Color(0xFF4A90FF),
          'iconBg': const Color(0xFFEAF2FD),
          'icon': Icons.chat_bubble_outline,
          'iconColor': const Color(0xFF4A90FF)
        };
      case 'delayed':
        return {
          'borderColor': const Color(0xFFE25C5C),
          'iconBg': const Color(0xFFF8E8EC),
          'icon': Icons.error_outline,
          'iconColor': const Color(0xFFE25C5C)
        };
      case 'match':
        return {
          'borderColor': const Color(0xFF9B59B6),
          'iconBg': const Color(0xFFF2E8F7),
          'icon': Icons.layers_outlined,
          'iconColor': const Color(0xFF9B59B6)
        };
      default:
        return {
          'borderColor': Colors.grey,
          'iconBg': const Color(0xFFF2F2F2),
          'icon': Icons.notifications_outlined,
          'iconColor': Colors.grey
        };
    }
  }
}

// ── Stateful request card with parcel detail sheet ────────────────────
class _RequestCard extends StatefulWidget {
  final String docId;
  final String requestId;
  final String initials;
  final Color avatarColor;
  final String fromName;
  final String packageNote;
  final String packageType;
  final String weight;
  final String destination;
  final String proposedPayment;
  final String time;
  final bool isRead;

  const _RequestCard({
    required this.docId,
    required this.requestId,
    required this.initials,
    required this.avatarColor,
    required this.fromName,
    required this.packageNote,
    required this.packageType,
    required this.weight,
    required this.destination,
    required this.proposedPayment,
    required this.time,
    required this.isRead,
  });

  @override
  State<_RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<_RequestCard> {
  bool _loading = false;
  String? _responded; // 'accepted' | 'declined'

  Future<void> _respond(String response) async {
    if (widget.requestId.isEmpty) return;
    setState(() => _loading = true);

    await AuthService().respondToRequest(
      requestId: widget.requestId,
      response: response,
    );

    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(widget.docId)
        .update({'read': true});

    if (mounted) {
      setState(() {
        _responded = response;
        _loading = false;
      });
    }
  }

  void _showParcelDetails() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Sender header
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: widget.avatarColor,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Center(
                    child: Text(widget.initials,
                        style: GoogleFonts.syne(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w800)),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.fromName,
                        style: GoogleFonts.syne(
                            fontSize: 16, fontWeight: FontWeight.w800)),
                    Text('Delivery Request · ${widget.time}',
                        style: GoogleFonts.manrope(
                            fontSize: 12, color: Colors.black38)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(height: 1, color: Color(0xFFF0F0F0)),
            const SizedBox(height: 16),

            Text('Parcel Details',
                style: GoogleFonts.syne(
                    fontSize: 14, fontWeight: FontWeight.w800)),
            const SizedBox(height: 14),

            _detailRow(Icons.category_outlined, 'Package Type',
                widget.packageType.isEmpty ? '—' : widget.packageType),
            _detailRow(Icons.scale_outlined, 'Weight',
                widget.weight.isEmpty ? '—' : '${widget.weight} kg'),
            _detailRow(Icons.location_on_outlined, 'Destination',
                widget.destination.isEmpty ? '—' : widget.destination),
            _detailRow(Icons.payments_outlined, 'Proposed Payment',
                widget.proposedPayment.isEmpty
                    ? '—'
                    : '${widget.proposedPayment} DA'),

            if (widget.packageNote.isNotEmpty) ...[
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F3),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.notes, size: 14, color: Colors.black38),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(widget.packageNote,
                          style: GoogleFonts.manrope(
                              fontSize: 13, color: Colors.black54)),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Action buttons inside sheet
            if (_loading)
              const Center(
                  child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Color(0xFFB8960A))))
            else if (_responded != null)
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: _responded == 'accepted'
                        ? const Color(0xFFE6F3E8)
                        : const Color(0xFFF8E8EC),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _responded == 'accepted' ? 'Accepted ✓' : 'Declined',
                    style: GoogleFonts.syne(
                        color: _responded == 'accepted'
                            ? const Color(0xFF2E7D32)
                            : const Color(0xFFE25C5C),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await _respond('declined');
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Colors.black12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Decline',
                          style: GoogleFonts.syne(
                              color: Colors.black54,
                              fontSize: 13,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await _respond('accepted');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color(0xFF111111),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Accept',
                          style: GoogleFonts.syne(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF7E0),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, size: 16, color: const Color(0xFFB8960A)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: GoogleFonts.manrope(
                      fontSize: 11,
                      color: Colors.black38,
                      fontWeight: FontWeight.w500)),
              Text(value,
                  style: GoogleFonts.syne(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showParcelDetails,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: widget.isRead ? Colors.white : const Color(0xFFFFFBF0),
          borderRadius: BorderRadius.circular(24),
          border: const Border(
              left: BorderSide(color: Color(0xFF9B59B6), width: 4)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 3))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                      color: widget.avatarColor,
                      borderRadius: BorderRadius.circular(14)),
                  child: Center(
                    child: Text(widget.initials,
                        style: GoogleFonts.syne(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text('New delivery request',
                                style: GoogleFonts.syne(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          ),
                          if (!widget.isRead && _responded == null)
                            Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                    color: Color(0xFFB8960A),
                                    shape: BoxShape.circle)),
                          const SizedBox(width: 6),
                          Text(widget.time,
                              style: GoogleFonts.manrope(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.fromName} wants to send a parcel with you.',
                        style: GoogleFonts.manrope(
                            fontSize: 13,
                            height: 1.4,
                            color: const Color(0xFF555555),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Tap hint
            if (_responded == null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tap to see parcel details',
                      style: GoogleFonts.manrope(
                          fontSize: 12,
                          color: const Color(0xFF9B59B6),
                          fontWeight: FontWeight.w600)),
                  const Icon(Icons.arrow_forward_ios,
                      size: 12, color: Color(0xFF9B59B6)),
                ],
              )
            else
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: _responded == 'accepted'
                        ? const Color(0xFFE6F3E8)
                        : const Color(0xFFF8E8EC),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _responded == 'accepted' ? 'Accepted ✓' : 'Declined',
                    style: GoogleFonts.syne(
                        color: _responded == 'accepted'
                            ? const Color(0xFF2E7D32)
                            : const Color(0xFFE25C5C),
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}