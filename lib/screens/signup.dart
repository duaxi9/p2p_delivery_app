// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import 'package:my_app/Widgets/snackbar.dart';
import 'package:my_app/components/button.dart' show MyButton;
import 'package:my_app/screens/auth_service.dart';
import 'package:my_app/screens/login.dart';
import 'package:my_app/screens/privacy_policy.dart';
import 'package:my_app/screens/terms_of_use.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  final AuthService _authService = AuthService();

  bool isLoading = false;
  bool isPasswordHidden = true;
  bool isRememberMe = false;

  static const Color gold = Color(0xFFB8960A);
  static const Color background = Color(0xFFF7F7F5);
  static const Color fieldColor = Color(0xFFF0F0EE);

  final List<TextInputFormatter> nameOnlyFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z ]")),
  ];

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
  final nameRegex = RegExp(r"^[a-zA-Z ]+$");

  final firstName = firstNameController.text.trim();
  final lastName = lastNameController.text.trim();

  if (firstName.isEmpty || !nameRegex.hasMatch(firstName)) {
    showSnackBAR(context, "First name can only contain letters.");
    return;
  }

  if (lastName.isEmpty || !nameRegex.hasMatch(lastName)) {
    showSnackBAR(context, "Last name can only contain letters.");
    return;
  }

  if (!isRememberMe) {
    showSnackBAR(context, "Please agree to the Privacy Policy and Terms.");
    return;
  }

  setState(() => isLoading = true);

  final result = await _authService.signUpUser(
    email: emailController.text.trim(),
    password: passwordController.text.trim(),
    username: nameController.text.trim(),
    firstname: firstName,
    lastname: lastName,
    date: _birthDateController.text.trim(),
    phonenumber: phoneController.text.trim(),
  );

  if (!mounted) return;

  setState(() => isLoading = false);

  if (result == "success") {
    showSnackBAR(context, "Signup successful! Now login.");
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Login()),
    );
  } else {
    showSnackBAR(context, "Signup failed: $result");
  }
}

  Future<void> _pickBirthDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: gold,
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
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    bool obscureText = false,
    VoidCallback? onTap,
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        obscureText: obscureText,
        onTap: onTap,
        inputFormatters: inputFormatters,
        style: GoogleFonts.manrope(
          color: Colors.black87,
          fontSize: 14.5,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 17),
          prefixIcon: Icon(icon, color: Colors.black54, size: 22),
          suffixIcon: suffixIcon,
          hintText: hint,
          hintStyle: GoogleFonts.manrope(
            color: Colors.black38,
            fontSize: 14.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _firstLastNameFields() {
    return Row(
      children: [
        Expanded(
          child: _inputField(
            controller: firstNameController,
            hint: 'First name',
            icon: Symbols.person,
            keyboardType: TextInputType.name,
            inputFormatters: nameOnlyFormatter,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _inputField(
            controller: lastNameController,
            hint: 'Last name',
            icon: Symbols.person_outline,
            keyboardType: TextInputType.name,
            inputFormatters: nameOnlyFormatter,
          ),
        ),
      ],
    );
  }

  Widget _agreementRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: isRememberMe,
          activeColor: gold,
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          onChanged: (value) {
            setState(() => isRememberMe = value ?? false);
          },
        ),
        Expanded(
          child: Wrap(
            children: [
              Text(
                'I agree to ',
                style: GoogleFonts.manrope(
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PrivacyPolicyPage(),
                  ),
                ),
                child: Text(
                  'Privacy Policy',
                  style: GoogleFonts.manrope(
                    color: gold,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                ' and ',
                style: GoogleFonts.manrope(
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TermsOfUsePage(),
                  ),
                ),
                child: Text(
                  'Terms of use',
                  style: GoogleFonts.manrope(
                    color: gold,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _loginLink() {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Login()),
          );
        },
        child: RichText(
          text: TextSpan(
            text: "Already have an account? ",
            style: GoogleFonts.manrope(
              color: Colors.black45,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: "Login",
                style: GoogleFonts.manrope(
                  color: gold,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
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
      backgroundColor: background,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Account',
                    style: GoogleFonts.syne(
                      color: gold,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Join LinkAir and start sending parcels with trusted travelers.',
                    style: GoogleFonts.manrope(
                      color: Colors.black45,
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _firstLastNameFields(),
                        const SizedBox(height: 14),
                        _inputField(
                         controller: nameController,
                          hint: 'Username',
                          icon: Symbols.person_edit,
                          inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9_]")),
                           ],
                        ),
                        const SizedBox(height: 14),
                        _inputField(
                          controller: _birthDateController,
                          hint: 'Birth date',
                          icon: Symbols.edit_calendar,
                          readOnly: true,
                          onTap: _pickBirthDate,
                        ),
                        const SizedBox(height: 14),
                        _inputField(
                          controller: emailController,
                          hint: 'Email address',
                          icon: Symbols.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 14),
                        _inputField(
                          controller: phoneController,
                          hint: 'Phone number',
                          icon: Symbols.call,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        const SizedBox(height: 14),
                        _inputField(
                          controller: passwordController,
                          hint: 'Password',
                          icon: Symbols.lock,
                          obscureText: isPasswordHidden,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordHidden
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.black45,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordHidden = !isPasswordHidden;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        _agreementRow(),
                        const SizedBox(height: 18),
                        isLoading
                            ? const Center(
                                child: CircularProgressIndicator(color: gold),
                              )
                            : SizedBox(
                                width: double.infinity,
                                child: MyButton(
                                  onTap: _signUp,
                                  text: "Sign Up",
                                ),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  _loginLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}