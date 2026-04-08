import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


class OtpForm extends StatelessWidget {
  const OtpForm({Key? key}) : super(key: key);

  Widget _otpBox(BuildContext context, String savedKey) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Color(0xFFEDEDEC),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) FocusScope.of(context).nextFocus();
        },
        onSaved: (val) {},
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "0",
          hintStyle: TextStyle(color: Colors.black26),
          contentPadding: EdgeInsets.symmetric(vertical: 18),
        ),
        style: GoogleFonts.manrope(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'OTP Verification',
              style: GoogleFonts.syne(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Enter the verification code sent to your email',
              style: GoogleFonts.manrope(
                color: Color(0xFF9A9080),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 50),
            

            // OTP boxes
            Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _otpBox(context, 'pin1'),
                  _otpBox(context, 'pin2'),
                  _otpBox(context, 'pin3'),
                  _otpBox(context, 'pin4'),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => print('OTP Submitted'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  backgroundColor: Color(0xFFB8960A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Verify',
                  style: GoogleFonts.syne(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Resend
            Center(
              child: GestureDetector(
                onTap: () => print('Resend tapped'),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Didn't receive the code? ",
                        style: GoogleFonts.manrope(
                          color: Color(0xFF9A9080),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'Resend',
                        style: GoogleFonts.syne(
                          color: Color(0xFFB8960A),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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