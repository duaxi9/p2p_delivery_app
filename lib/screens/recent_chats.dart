import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2p_delivery_app/screens/ChatPage.dart';

class RecentChats extends StatelessWidget {
  final List<Map<String, dynamic>> chats = [
    {
      'initials': 'YM',
      'color': Colors.black,
      'name': 'Yacine Mansouri',
      'message': 'Ok i can take it, when can we meet?',
      'time': '2m ago',
      'unread': 2,
    },
    {
      'initials': 'MS',
      'color': Color(0xFFB8960A),
      'name': 'Mehdi Saidi',
      'message': 'Package is ready for pickup!',
      'time': '15m ago',
      'unread': 1,
    },
    {
      'initials': 'SL',
      'color': Color(0xFF0EA5A4),
      'name': 'Sofia Lopez',
      'message': 'I\'ll be at the airport at 9am',
      'time': '1h ago',
      'unread': 0,
    },
    {
      'initials': 'DC',
      'color': Colors.red,
      'name': 'Daniel Costa',
      'message': 'Delivery confirmed, thanks!',
      'time': '3h ago',
      'unread': 0,
    },
    {
      'initials': 'DK',
      'color': Color(0xFF3467EB),
      'name': 'Douaa Kebaili',
      'message': 'Can you send me the tracking number?',
      'time': 'Yesterday',
      'unread': 3,
    },
    {
      'initials': 'CM',
      'color': Color(0xFF515050),
      'name': 'Chloe Martin',
      'message': 'The parcel arrived safely, merci!',
      'time': '2d ago',
      'unread': 0,
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