import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2p_delivery_app/screens/ChatBottomSheet.dart';

class ChatPage extends StatelessWidget {
  final String initials;
  final Color color;
  final String name;

  const ChatPage({
    super.key,
    required this.initials,
    required this.color,
    required this.name,
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
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            width: 350,
            height: 94,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(17),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('📦', style: TextStyle(fontSize: 25)),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACTIVE DELIVERY',
                      style: GoogleFonts.syne(
                        color: Color(0xFFB8960A),
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Algiers → Paris',
                      style: GoogleFonts.syne(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Departs Mar15 2.5kg',
                      style: GoogleFonts.manrope(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.only(left: 20),
             // ← left padding
            child: Container(
              width: 290,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))
                  ],
              ),
              padding: EdgeInsets.only(left: 15),
              child: Center(
                child: Text('Hi! I saw your listing. I\'m flying to Paris on the 15th, I have space ',
                
                style: GoogleFonts.syne(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  
                )
                
              ),

              ),
              
            ),



            
          ),
const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 100),
             // ← left padding
            child: Container(
              
              width: 290,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))
                  ],
              ),
              

              padding: EdgeInsets.only(left: 15),
              child: Center(
                child: Text('Hello! great it\'s 2.5kg package just clothes',
                
                
                style: GoogleFonts.syne(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  
                )
                
              ),

              ),
              
            ),
          ),

          

const SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.only(left: 20),
             // ← left padding
            child: Container(
              width: 290,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))
                  ],
              ),
              padding: EdgeInsets.only(left: 3),
              child: Center(
                child: Text('Okay good, When can we meet?',
                
                
                style: GoogleFonts.syne(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  
                )
                
              ),

              ),
              
            ),
            
          ),


          const SizedBox(height: 25),


          Padding(
            padding: const EdgeInsets.only(left: 100),
             // ← left padding
            child: Container(
              
              width: 290,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))
                  ],
              ),
              

              padding: EdgeInsets.only(left: 15),
              child: Center(
                
                
                
                child: Text('Before you depart if that\'s okay with you?',
                
                
                style: GoogleFonts.syne(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  
                )
                
              ),

              ),
              
            ),
            
          ),
          const SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.only(left: 20),
             // ← left padding
            child: Container(
              width: 290,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))
                  ],
              ),
              padding: EdgeInsets.only(left: 3),
              child: Center(
                child: Text('Perfect, see you at the airport! I\'ll send you my location 📍',
                style: GoogleFonts.syne(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  
                )
              ),
              ),
              
            ),
            
          ),
        ],
      ),
    bottomSheet:  ChatBottomSheet(),
    );
  }
}