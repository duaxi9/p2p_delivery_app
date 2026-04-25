import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:my_app/screens/login.dart';
import 'package:my_app/screens/privacy_policy.dart';
import 'package:my_app/screens/terms_of_use.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUp> {
  bool isRememberMe = false;
  final TextEditingController _birthDateController = TextEditingController();

  Widget buildFirstLastName() {
    return Row(
      children: [
        Expanded(
          child: Container(
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
              keyboardType: TextInputType.name,
              style: GoogleFonts.manrope(color: Colors.black87, fontSize: 16),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Symbols.person, color: Color(0xFF000000)),
                hintText: 'First Name',
                hintStyle: GoogleFonts.manrope(color: Colors.black38, fontSize: 16),
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Container(
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
              obscureText: false,
              keyboardType: TextInputType.name,
              style: GoogleFonts.manrope(color: Colors.black87, fontSize: 16),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Symbols.person_outline, color: Color(0xFF000000)),
                hintText: 'Last Name',
                hintStyle: GoogleFonts.manrope(color: Colors.black38, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildUsername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
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
            obscureText: false,
            style: GoogleFonts.manrope(color: Colors.black87, fontSize: 16),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Symbols.person_edit, color: Color(0xFF000000)),
              hintText: 'Username',
              hintStyle: GoogleFonts.manrope(color: Colors.black38, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }


  Widget buildBirthDay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
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
            controller: _birthDateController,
            readOnly: true,
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: Color(0xFFB8960A),
                        onPrimary: Colors.white,
                        onSurface: Colors.black87,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) {
                setState(() {
                  _birthDateController.text =
                      "${picked.day.toString().padLeft(2, '0')}/"
                      "${picked.month.toString().padLeft(2, '0')}/"
                      "${picked.year}";
                });
              }
            },
            style: GoogleFonts.manrope(color: Colors.black87, fontSize: 16),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Symbols.edit_calendar, color: Color(0xFF000000)),
              hintText: 'Birth Date',
              hintStyle: GoogleFonts.manrope(color: Colors.black38, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
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
            obscureText: false,
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
        )
      ],
    );
  }

  Widget buildPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
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
            obscureText: false,
            keyboardType: TextInputType.phone,
            style: GoogleFonts.manrope(color: Colors.black87, fontSize: 16),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Symbols.call, color: Color(0xFF000000)),
              hintText: 'Phone Number',
              hintStyle: GoogleFonts.manrope(color: Colors.black38, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
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
            obscureText: true,
            style: GoogleFonts.manrope(color: Colors.black87, fontSize: 16),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Symbols.lock, color: Color(0xFF000000)),
              suffixIcon: Icon(Symbols.visibility_off, color: Color(0xFF000000)),
              hintText: 'Password',
              hintStyle: GoogleFonts.manrope(color: Colors.black38, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }

  Widget buildAgree() {
    return SizedBox(
      height: 20,
      child: Row(
        children: <Widget>[
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
            'I agree to ',
            style: GoogleFonts.manrope(
              color: Colors.black38,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PrivacyPolicyPage()),
            ),
            child: Text(
              'Privacy Policy',
              style: GoogleFonts.manrope(
                color: Color(0xFFB8960A),
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ),
          Text(
            ' and ',
            style: GoogleFonts.manrope(
              color: Colors.black38,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TermsOfUsePage()),
            ),
            child: Text(
              'Terms of use',
              style: GoogleFonts.manrope(
                color: Color(0xFFB8960A),
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLRegisterBtn() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25),
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => Login()),
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
        'Create Account',
        style: GoogleFonts.syne(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
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
                      Text(
                        'Let\'s create your account',
                        style: GoogleFonts.syne(
                          color: Color(0xFFB8960A),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 21),
                      buildFirstLastName(),
                      SizedBox(height: 15),
                      buildUsername(),
                      SizedBox(height: 15),
                      buildBirthDay(),
                      SizedBox(height: 15),
                      buildEmail(),
                      SizedBox(height: 15),
                      buildPhoneNumber(),
                      SizedBox(height: 15),
                      buildPassword(),
                      SizedBox(height: 20),
                      buildAgree(),
                      SizedBox(height: 5),
                      buildLRegisterBtn(),
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