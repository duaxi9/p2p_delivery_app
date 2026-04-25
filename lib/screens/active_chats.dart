import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActiveChats extends StatelessWidget {
  const ActiveChats({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 25, left: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Color(0xFFCFCFCF),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      padding: EdgeInsets.all(2),
                      child: Center(
                        child: Text(
                          'All',
                          style: GoogleFonts.manrope(
                            color: Colors.black38,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ), // ← closed here

              const SizedBox(width: 10),

              Column(
                children: [
                  Container(
                    width: 95,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Color(0xFFCFCFCF),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: Text(
                        'Sending',
                        style: GoogleFonts.manrope(
                          color: Colors.black38,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 10),

              Column(
                children: [
                  Container(
                    width: 95,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Color(0xFFCFCFCF),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: Text(
                        'Traveling',
                        style: GoogleFonts.manrope(
                          color: Colors.black38,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
    );
  }
}