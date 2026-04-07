import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ChatBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          // ignore: deprecated_member_use
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 10,
          offset: Offset(0, 3),
        ),
      ]),

child: Row(
  children: [
    Padding(
      padding: EdgeInsets.only(left: 8),
    child: Icon(Icons.add,
    color: Color(0xFFB8960A),
    size: 30,

    ),
    ),


Padding(
      padding: EdgeInsets.only(left: 15),
      child: Icon(
        Icons.mic,
        color: Color(0xFFB8960A),
        size: 30,
      ),
    ),

    Padding(padding: EdgeInsets.only(left: 10),
    child: Container(
      alignment: Alignment.centerRight,
      width: 270,
      child: TextFormField(
        decoration: InputDecoration(hintText:
        "Write a message..",
        hintStyle: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        border: InputBorder.none,

        ),
      ),
    ),
    ),
Spacer(),

Container(
  width: 45,
  height: 45,
  decoration: BoxDecoration(
    
    color: Colors.black,
    borderRadius: BorderRadius.circular(60),
    
  ),
  
  child: Center(
    
    child: Icon(Iconsax.send_2.send, color: Color(0xFFB8960A),
    size: 20,
    ),
    ),
  )





  

  ],
),




    );
  }
}

extension on IconData {
  IconData? get send => null;
}

