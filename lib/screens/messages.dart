import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2p_delivery_app/screens/active_chats.dart';
import 'package:p2p_delivery_app/screens/recent_chats.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDEC),
      
      
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child:
        Text(
          "Messages",
          style: GoogleFonts.syne(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w900,
            
        ),
        ),
        ),

        

        Padding(padding: EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white54,
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
                Icon(Icons.search,
                color: Colors.blueGrey,
                ),
                Container(
                  
                  width: 300,
                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search conversations",
                      hintStyle: GoogleFonts.manrope(
                        color: Colors.black38,
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
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



      ActiveChats(),
      RecentChats(),




      ],
      ),

      
    
    );
  }
}