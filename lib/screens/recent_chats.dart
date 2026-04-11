import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2p_delivery_app/screens/ChatPage.dart';

class RecentChats extends StatelessWidget {
  final List<Map<String, dynamic>> chats = [
    {
      'initials': 'YM',
      'color': Colors.black,
      'name': 'Yacine Mansouri',
      'message': 'That works for me 👍',
      'time': '2m ago',
      'unread': 2,
      'rating': 4.8,
      'trips': 31,
      'deliveries': 74,
      'messages': [
        {'text': 'Hi, I saw your delivery request from Paris to Algiers. I\'ll be traveling there this Friday.', 'isSent': false},
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
      'messages': [
        {'text': 'Can you tell me what\'s inside the package exactly?', 'isSent': false},
        {'text': 'Clothes and a pair of shoes, nothing fragile', 'isSent': true},
        {'text': 'Great. And where should we meet?', 'isSent': false},
        {'text': 'At the airport, departure area.', 'isSent': true},
        {'text': 'Perfect, that\'s easier for me.', 'isSent': false},
      ],
    },
    {
      'initials': 'SL',
      'color': Color(0xFF0EA5A4),
      'name': 'Sofia Lopez',
      'message': 'Deal 👍',
      'time': '1h ago',
      'unread': 0,
      'rating': 4.7,
      'trips': 22,
      'deliveries': 55,
      'messages': [
        {'text': 'You proposed 20€, for the ge is that flexible?', 'isSent': false},
        {'text': 'I can go up to 25€ max.', 'isSent': true},
        {'text': 'Alright, 25€ works for me.', 'isSent': false},
        {'text': 'Deal 👍', 'isSent': true},
      ],
    },
    {
      'initials': 'DC',
      'color': Colors.red,
      'name': 'Daniel Costa',
      'message': 'Of course, everything is ready.',
      'time': '3h ago',
      'unread': 0,
      'rating': 4.7,
      'trips': 18,
      'deliveries': 40,
      'messages': [
        {'text': 'Hi, just confirming — my flight is tomorrow at 10 AM.', 'isSent': false},
        {'text': 'Yes, I\'ll be there at 8:30 AM.', 'isSent': true},
        {'text': 'Perfect. Please make sure the package is well packed.', 'isSent': false},
        {'text': 'Of course, everything is ready.', 'isSent': true},
      ],
    },
    {
      'initials': 'DK',
      'color': Color(0xFF3467EB),
      'name': 'Douaa Kebaili',
      'message': 'He\'ll meet you at the airport exit in 30 minutes.',
      'time': 'Yesterday',
      'unread': 3,
      'rating': 4.3,
      'trips': 14,
      'deliveries': 30,
      'messages': [
        {'text': 'I\'ve arrived in Algiers.', 'isSent': false},
        {'text': 'Great! I\'ll contact the receiver now.', 'isSent': true},
        {'text': 'Let me know when and where to meet.', 'isSent': false},
        {'text': 'He\'ll meet you at the airport exit in 30 minutes.', 'isSent': false},
      ],
    },
    {
      'initials': 'CM',
      'color': Color(0xFF515050),
      'name': 'Chloe Martin',
      'message': 'I\'ll leave you a good rating ⭐',
      'time': '2d ago',
      'unread': 0,
      'rating': 4.7,
      'trips': 27,
      'deliveries': 63,
      'messages': [
        {'text': 'Package delivered successfully 👍', 'isSent': false},
        {'text': 'Perfect, thank you so much!', 'isSent': true},
        {'text': 'No problem, everything went smoothly.', 'isSent': false},
        {'text': 'I\'ll leave you a good rating ⭐', 'isSent': true},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: chats.map((chat) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatPage(
                initials: chat['initials'],
                color: chat['color'],
                name: chat['name'],
                messages: List<Map<String, dynamic>>.from(chat['messages']),
                rating: chat['rating'],
                trips: chat['trips'],
                deliveries: chat['deliveries'],
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 12, left: 13, right: 13),
            child: Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: chat['color'],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          chat['initials'],
                          style: GoogleFonts.syne(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          chat['name'],
                          style: GoogleFonts.syne(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: 180,
                          child: Text(
                            chat['message'],
                            style: GoogleFonts.manrope(
                              fontSize: 13,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
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
                        Text(
                          chat['time'],
                          style: GoogleFonts.manrope(
                            fontSize: 13,
                            color: Colors.black38,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        chat['unread'] > 0
                            ? Container(
                                height: 22,
                                width: 22,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFB8960A),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  '${chat['unread']}',
                                  style: GoogleFonts.manrope(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
      }).toList(),
    );
  }
}