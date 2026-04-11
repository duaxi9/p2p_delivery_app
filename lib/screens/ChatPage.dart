import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2p_delivery_app/screens/ChatBottomSheet.dart';
import 'package:p2p_delivery_app/screens/UserProfilePage.dart';

class ChatPage extends StatelessWidget {
  final String initials;
  final Color color;
  final String name;
  final List<Map<String, dynamic>> messages;
  final double rating;
  final int trips;
  final int deliveries;

  const ChatPage({
    super.key,
    required this.initials,
    required this.color,
    required this.name,
    required this.messages,
    required this.rating,
    required this.trips,
    required this.deliveries,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDEC),
      appBar: AppBar(
        backgroundColor: Color(0xFFEDEDEC),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserProfilePage(
                      initials: initials,
                      color: color,
                      name: name,
                      rating: rating,
                      trips: trips,
                      deliveries: deliveries,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 62,
                      height: 58,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          initials,
                          style: GoogleFonts.syne(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.syne(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Online',
                          style: GoogleFonts.manrope(
                            color: Color(0xFF00B32D),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Icon(Icons.call, color: Colors.black38, size: 24),
              const SizedBox(width: 18),
              Icon(Icons.videocam_rounded, color: Colors.black38, size: 24),
              const SizedBox(width: 18),
              Icon(Icons.more_vert, color: Colors.black38, size: 24),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: Container(color: Colors.black12, height: 1),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isSent = msg['isSent'] as bool;
                return Align(
                  alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: 270),
                    decoration: BoxDecoration(
                      color: isSent ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))
                      ],
                    ),
                    child: Text(
                      msg['text'],
                      style: GoogleFonts.syne(
                        color: isSent ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomSheet: ChatBottomSheet(),
    );
  }
}