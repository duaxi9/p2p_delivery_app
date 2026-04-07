import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2p_delivery_app/screens/signup.dart';
// ignore: unused_import
import 'package:p2p_delivery_app/screens/home_screen.dart';

class WelcomeScreens extends StatelessWidget {
  const WelcomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xFFEDEDED);

    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Column(
          children: [
            /// TOP
            Expanded(
              child: Container(
                width: double.infinity,
                color: mainColor,
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, left: 24),
                    child: LogoWidget(),
                  ),
                ),
              ),
            ),

            /// DIVIDER
            Container(
              height: 1,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Color(0xFFDDDDD8),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            /// BOTTOM
            const BottomContent(),
          ],
        ),
      ),
    );
  }
}

/// ================= BOTTOM =================
class BottomContent extends StatelessWidget {
  const BottomContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 26, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

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

const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: GoogleFonts.syne(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  height: 1.3,
                ),
                children: const [
                  TextSpan(
                    text: "Your parcel,\n",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: "their journey.",
                    style: TextStyle(color: Color(0xFFB8960A)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// SUBTITLE
            Text(
              "Connect with travelers and get items delivered safely across borders.",
              style: GoogleFonts.manrope(
                fontSize: 16,
                color: const Color(0xFF9A9080),
                height: 1.7,
              ),
            ),

            const SizedBox(height: 32),

        //Log in button
            SizedBox(
  width: double.infinity,
  height: 54,
  child: ElevatedButton(
       onPressed: () {
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFB8960A),
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    child: const Text(
      "Log In",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
),

            const SizedBox(height: 18),

            /// SIGN UP BUTTON
            SizedBox(
            width: double.infinity,
            height: 54,
            child: OutlinedButton(
            onPressed: () {
              Navigator.push(
            context,
              MaterialPageRoute(builder: (_) => const SignUp()),
             );
          },
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.black,
      side: const BorderSide(color: Color(0xFFD8D2C8)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    child: const Text(
      "Sign Up",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}

/// ================= LOGO =================
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
              fontSize: 34,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
              height: 1,
            ),
            children: const [
              TextSpan(
                text: 'Link',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: 'Air',
                style: TextStyle(color: Color(0xFFB8960A)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 6),

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