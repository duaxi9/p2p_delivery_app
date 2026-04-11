import 'package:flutter/material.dart';
import 'package:p2p_delivery_app/components/button.dart';
import 'package:p2p_delivery_app/screens/Colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2p_delivery_app/screens/login.dart';
import 'package:p2p_delivery_app/screens/signup.dart';

class WelcomeScreens extends StatelessWidget {
  const WelcomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor,
      body: Column(
        children: [
          // TOP
          Expanded(
            child: Container(
              color: MainColor,
              child: const Stack(
                children: [
                  SizedBox(
                    height: 220,
                    width: double.maxFinite,
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 50, left: 24),
                        child: LogoWidget(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // DIVIDER
          Container(
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.transparent,
                Color(0xFFDDDDD8),
                Colors.transparent,
              ]),
            ),
          ),


          // BOTTOM
          const BottomContent(),

        ],
      ),
    );
  }
}

// ── Bottom Content ────────────────────────────────────────────
class BottomContent extends StatelessWidget {
  const BottomContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: const Color(0xFFFFFFFF),
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 40),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [



          const SizedBox(height: 1),

          Row(
          children: [
            Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
            color: const Color(0xFFB8960A),
            borderRadius: BorderRadius.circular(20),
          ),
            child: const Text(
          "Trusted travelers",
          style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    const SizedBox(width: 10),

  
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEAE6DD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        "Cross-border",
        style: TextStyle(
          color: Colors.black87,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ],
),
          // Text block
          RichText(
            text: TextSpan(
              style: GoogleFonts.syne(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                height: 2.0,
              ),
              children: const [
                TextSpan(
                  text: "Your parcel,\n",
                  style: TextStyle(color: Color(0xFF000000), fontSize:25 ),
                ),
                TextSpan(
                
                  text: "their journey.",
                  style: TextStyle(color: Color(0xFFB8960A), fontSize: 25, height: 1.3),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Connect with travelers and get items delivered safely across borders.",
            style: GoogleFonts.manrope(
              fontSize: 16,
              color: const Color(0xFF9A9080),
              height: 1.8,
              
            ),
          ),
          const SizedBox(height: 20),

    MyButton(
  text: "Log In",
  filled: true,
  onTap: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) =>  Login()),
  ),
),
const SizedBox(height: 15),
MyButton(
  text: "Sign Up",
  filled: false,
  onTap: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => SignUp()),
  ),
),
        ],
      ),
    );
  }
}

// ── Logo ──────────────────────────────────────────────────────
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.syne(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
              height: 1,
            ),
            children: const [
              TextSpan(text: 'Link', style: TextStyle(color: Color(0xFF000000))),
              TextSpan(text: 'Air',  style: TextStyle(color: Color(0xFFB8960A))),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'EXPRESS DELIVERY',
          style: GoogleFonts.manrope(
            fontSize: 11,
            letterSpacing: 3.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFAAAAAA),
          ),
        ),
      ],
    );
  }
}