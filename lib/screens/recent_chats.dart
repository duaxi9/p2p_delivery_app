import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/screens/chat_page.dart';
import 'package:my_app/screens/auth_service.dart';

class RecentChats extends StatelessWidget {
  RecentChats({super.key});

  final AuthService _authService = AuthService();

  // ── Demo chats shown when no real chats exist ─────────────────────
  final List<Map<String, dynamic>> _demoChats = [
    {
      'initials': 'YM',
      'color': Color.fromARGB(255, 234, 138, 218),
      'name': 'Yacine Mansouri',
      'message': 'That works for me 👍',
      'time': '2m ago',
      'unread': 2,
      'rating': 4.8,
      'trips': 31,
      'deliveries': 74,
      'otherUid': '',
      'messages': [
        {'text': 'Hi, I saw your delivery request from Paris to Algiers.', 'isSent': false},
        {'text': 'Hi! That\'s perfect. Are you available to take a small package?', 'isSent': true},
        {'text': 'Yes, I have space in my luggage', 'isSent': false},
        {'text': 'Around 2 kg, just clothes,', 'isSent': true},
        {'text': 'That works for me 👍', 'isSent': false},
      ],
    },
    {
      'initials': 'MS',
      'color': Color(0xFFB8960A),
      'name': 'Mehdi Saidi',
      'message': 'Perfect, that\'s easier for me.',
      'time': '15m ago',
      'unread': 1,
      'rating': 4.9,
      'trips': 48,
      'deliveries': 120,
      'otherUid': '',
      'messages': [
        {'text': 'Can you tell me what\'s inside the package exactly?', 'isSent': false},
        {'text': 'Clothes and a pair of shoes, nothing fragile', 'isSent': true},
        {'text': 'Great. And where should we meet?', 'isSent': false},
        {'text': 'At the airport, departure area.', 'isSent': true},
        {'text': 'Perfect, that\'s easier for me.', 'isSent': false},
      ],
    },
  ];

  String _formatTime(dynamic timestamp) {
    if (timestamp == null) return '';
    try {
      final dt = (timestamp as Timestamp).toDate();
      final now = DateTime.now();
      final diff = now.difference(dt);
      if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
      if (diff.inHours < 24) return '${diff.inHours}h ago';
      return '${diff.inDays}d ago';
    } catch (_) {
      return '';
    }
  }

  Widget _chatTile(BuildContext context, Map<String, dynamic> chat,
      {bool isDemo = false}) {
    final color = chat['color'] as Color? ?? const Color(0xFFB8960A);
    final initials = (chat['initials'] ?? '?').toString();
    final name = (chat['name'] ?? 'Unknown').toString();
    final message = (chat['lastMessage'] ?? chat['message'] ?? '').toString();
    final time = isDemo
        ? chat['time'].toString()
        : _formatTime(chat['lastTimestamp']);
    final unread = (chat['unread'] ?? 0) as int;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatPage(
            initials: initials,
            color: color,
            name: name,
            messages: isDemo
                ? List<Map<String, dynamic>>.from(chat['messages'] ?? [])
                : [],
            rating: (chat['rating'] ?? 0.0) as double,
            trips: (chat['trips'] ?? 0) as int,
            deliveries: (chat['deliveries'] ?? 0) as int,
            otherUid: isDemo ? '' : (chat['otherUid'] ?? ''),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 13, right: 13),
        child: SizedBox(
          height: 70,
          child: Row(
            children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(initials,
                      style: GoogleFonts.syne(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(name,
                        style: GoogleFonts.syne(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 180,
                      child: Text(
                        message.isEmpty ? 'Start a conversation' : message,
                        style: GoogleFonts.manrope(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(time,
                        style: GoogleFonts.manrope(
                            fontSize: 12,
                            color: Colors.black38,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    unread > 0
                        ? Container(
                            height: 22, width: 22,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFB8960A),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text('$unread',
                                style: GoogleFonts.manrope(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                          )
                        : const SizedBox(height: 22),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _authService.getChatsStream(),
      builder: (context, snapshot) {
        // ── Loading ──────────────────────────────────
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Center(
                child: CircularProgressIndicator(color: Color(0xFFB8960A))),
          );
        }

        // ── Real chats exist ─────────────────────────
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          final docs = snapshot.data!.docs;
          return Column(
            children: docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              // find the other participant
              final participants =
                  List<String>.from(data['participants'] ?? []);
              final myUid = _authService.currentUid ?? '';
              final otherUid =
                  participants.firstWhere((id) => id != myUid, orElse: () => '');

              return _chatTile(context, {
                ...data,
                'otherUid': otherUid,
                'initials': (data['travelerName'] ?? '?')
                    .toString()
                    .split(' ')
                    .map((e) => e.isNotEmpty ? e[0] : '')
                    .take(2)
                    .join()
                    .toUpperCase(),
                'color': const Color(0xFFB8960A),
                'name': data['travelerName'] ?? 'Unknown',
                'rating': 0.0,
                'trips': 0,
                'deliveries': 0,
                'unread': 0,
              });
            }).toList(),
          );
        }

        // ── No real chats yet — show demo ────────────
        return Column(
          children: _demoChats
              .map((chat) => _chatTile(context, chat, isDemo: true))
              .toList(),
        );
      },
    );
  }
}