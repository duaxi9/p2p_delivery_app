import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:p2p_delivery_app/components/square_tile.dart';
import 'package:p2p_delivery_app/screens/signup.dart';
import 'package:p2p_delivery_app/screens/ForgotPassword.dart';
import 'package:p2p_delivery_app/screens/home_screen.dart';



class Login extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  bool isRememberMe = false;

  Widget buildEmail() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Color(0xFFEDEDEC),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      height: 60,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: GoogleFonts.manrope(color: Colors.black87, fontSize: 16),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14),
          prefixIcon: Icon(Symbols.email, color: Color(0xFF000000)),
          hintText: 'Email',
          hintStyle: GoogleFonts.manrope(color: Colors.black38, fontSize: 16),
        ),
      ),
    );
  }



bool isPasswordHidden = true;

  Widget buildPassword() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Color(0xFFEDEDEC),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      height: 60,
      child: TextField(
      obscureText: isPasswordHidden,
        style: GoogleFonts.manrope(color: Colors.black87, fontSize: 16),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14),
          prefixIcon: const Icon(Symbols.lock),
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordHidden
                ? Icons.visibility_off
                : Icons.visibility,
          ),


          onPressed: () {
            setState(() {
              isPasswordHidden = !isPasswordHidden;
            });
          },
        ),

          hintText: 'Password',
          hintStyle: GoogleFonts.manrope(color: Colors.black38, fontSize: 16),
        ),
      ),
    );
  }

  Widget buildRememberAndForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Theme(
              data: ThemeData(unselectedWidgetColor: Colors.black),
              child: Checkbox(
                value: isRememberMe,
                checkColor: Colors.white,
                activeColor: Colors.black,
                onChanged: (value) {
                  setState(() {
                    isRememberMe = value!;
                  });
                },
              ),
            ),
            Text(
              'Remember me',
              style: GoogleFonts.manrope(
                color: Color(0xFF9A9080),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ForgotPassword()),
      ),
          child: Text(
            'Forgot Password?',
            style: GoogleFonts.manrope(
              color: Color(0xFF9A9080),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildOrSignInWith() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Flexible(
                child: Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                  indent: 60,
                  endIndent: 5,
                ),
              ),
              Text(
                'Or continue with',
                style: GoogleFonts.manrope(
                  color: Color(0xFF9A9080),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Flexible(
                child: Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                  indent: 5,
                  endIndent: 60,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => print("Google tapped"),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFFEDEDEC),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SquareTile(imagePath: 'assets/images/google.png'),
                ),
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () => print("Apple tapped"),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFFEDEDEC),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SquareTile(imagePath: 'assets/images/apple.png'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildLoginBtn() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen(isDarkMode: false, onThemeChanged: (isDark) {}, onLanguageChanged: (Locale value) {  }, selectedLanguage: '',)),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Color(0xFFB8960A),
        elevation: 5,
      ),
      child: Text(
        'LOGIN',
        style: GoogleFonts.syne(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

  Widget buildSignUpBtn() {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SignUp()),
        ),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have an Account? ',
                style: GoogleFonts.manrope(
                  color: Color(0xFF9A9080),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: 'Sign Up',
                style: GoogleFonts.syne(
                  color: Color(0xFFB8960A),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Color(0xFFF5F5F5),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 45),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // ── Logo ──────────────────────────────
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
                          fontSize: 9,
                          letterSpacing: 3.5,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFAAAAAA),
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Welcome back,',
                        style: GoogleFonts.syne(
                          color: Color(0xFFB8960A),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Make it work, make it right, make it fast.',
                        style: GoogleFonts.manrope(
                          color: Color(0xFF9A9080),
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 40),
                      buildEmail(),
                      const SizedBox(height: 25),
                      buildPassword(),
                      buildRememberAndForgot(),   // ← single row
                      buildLoginBtn(),
                      buildOrSignInWith(),
                      SizedBox(height: 20),
                      buildSignUpBtn(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}