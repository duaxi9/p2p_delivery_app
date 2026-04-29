import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/screens/recent_chats.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDEC),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              child: Text(
                "Messages",
                style: GoogleFonts.syne(
                  color: const Color.fromARGB(255, 167, 145, 35),
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white, // ← solid white
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.search, color: Color(0xFFB8960A)), // ← gold
                    Expanded( // ← no more hardcoded width
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Search conversations",
                            hintStyle: GoogleFonts.manrope(
                              color: Colors.black38,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            RecentChats(),
          ],
        ),
      ),
    );
  }
}