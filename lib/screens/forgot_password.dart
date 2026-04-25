import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_app/screens/otp_form.dart';



class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
  backgroundColor: Color(0xFFF5F5F5),
),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forgot Password',
              style: GoogleFonts.syne(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Enter your email to reset your password',
              style: GoogleFonts.manrope(
                color: Color(0xFF9A9080),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 40),

            // Email field
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFEDEDEC),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 2))
                ],
              ),
                height: 55,

              child: TextFormField(
              keyboardType: TextInputType.emailAddress,

                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  hintText: 'E-Mail',
                  hintStyle: GoogleFonts.manrope(color: Colors.black, fontSize: 16),
                  prefixIcon: Icon(Iconsax.direct_right, color: Color(0xFF000000)),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => OtpForm()),
      ),
      style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  backgroundColor: Color(0xFFB8960A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                
                child: Text(
                  'Submit',
                  style: GoogleFonts.syne(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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