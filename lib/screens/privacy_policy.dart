import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F7),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF111111), size: 18),
        ),
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.syne(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF111111),
            letterSpacing: -0.3,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('LinkAir',
                    style: GoogleFonts.syne(
                      fontSize: 20, fontWeight: FontWeight.w800,
                      color: const Color(0xFFB8960A),
                    )),
                  const SizedBox(height: 4),
                  Text('Privacy Policy',
                    style: GoogleFonts.syne(
                      fontSize: 15, fontWeight: FontWeight.w700,
                      color: Colors.white,
                    )),
                  const SizedBox(height: 8),
                  Text('Last updated: March 2026',
                    style: GoogleFonts.manrope(
                      fontSize: 11, color: Colors.white38,
                      fontWeight: FontWeight.w500,
                    )),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _Section(
              number: '1',
              title: 'Introduction',
              body:
                'LinkAir ("we", "our", "us") is committed to protecting your personal information. '
                'This Privacy Policy explains how we collect, use, store, and share your data when '
                'you use our platform. By using LinkAir, you consent to the practices described '
                'in this policy.',
            ),

            _Section(
              number: '2',
              title: 'Information We Collect',
              body:
                'We collect the following types of information:\n\n'
                '• Identity data: full name, date of birth, nationality\n'
                '• Contact data: email address, phone number\n'
                '• Profile data: profile photo, user preferences, ratings\n'
                '• Travel data: flight details, travel dates, routes\n'
                '• Parcel data: item descriptions, declared values, photos\n'
                '• Payment data: billing details (processed securely, not stored by us)\n'
                '• Device data: IP address, device type, operating system\n'
                '• Usage data: pages visited, features used, time spent',
            ),

            _Section(
              number: '3',
              title: 'How We Use Your Information',
              body:
                'We use your information to:\n\n'
                '• Create and manage your account\n'
                '• Match Senders with Travelers\n'
                '• Process payments through our escrow system\n'
                '• Verify identity and prevent fraud\n'
                '• Send transaction confirmations and notifications\n'
                '• Provide customer support\n'
                '• Improve our platform and services\n'
                '• Comply with legal obligations',
            ),

            _Section(
              number: '4',
              title: 'Identity Verification',
              body:
                'To maintain trust and safety on our platform, we may require identity verification '
                'documents such as a national ID, passport, or driver\'s license. These documents '
                'are processed securely and used solely for verification purposes. We use '
                'industry-standard encryption to protect all identity documents.',
            ),

            _Section(
              number: '5',
              title: 'Data Sharing',
              body:
                'We do not sell your personal data. We may share your data with:\n\n'
                '• Other users: only the information necessary to complete a delivery '
                '(e.g. first name, rating, general location)\n'
                '• Payment processors: to facilitate secure transactions\n'
                '• Identity verification providers: to verify user identity\n'
                '• Law enforcement: when required by law or to protect our users\n'
                '• Service providers: who assist in operating our platform under strict confidentiality agreements',
            ),

            _Section(
              number: '6',
              title: 'Data Retention',
              body:
                'We retain your personal data for as long as your account is active or as needed '
                'to provide services. You may request deletion of your account and associated data '
                'at any time by contacting our support team. Some data may be retained for legal '
                'compliance purposes for up to 5 years after account deletion.',
            ),

            _Section(
              number: '7',
              title: 'Cookies & Tracking',
              body:
                'Our app uses cookies and similar tracking technologies to enhance your experience, '
                'analyze usage patterns, and improve our services. You can control cookie preferences '
                'through your device settings. Disabling certain cookies may affect the functionality '
                'of the platform.',
            ),

            _Section(
              number: '8',
              title: 'Data Security',
              body:
                'We implement industry-standard security measures including end-to-end encryption, '
                'secure servers, and regular security audits to protect your data. However, no '
                'method of transmission over the internet is 100% secure. We encourage you to '
                'use a strong password and to log out after each session.',
            ),

            _Section(
              number: '9',
              title: 'Your Rights',
              body:
                'You have the right to:\n\n'
                '• Access the personal data we hold about you\n'
                '• Request correction of inaccurate data\n'
                '• Request deletion of your data\n'
                '• Object to processing of your data\n'
                '• Request restriction of processing\n'
                '• Data portability\n\n'
                'To exercise any of these rights, contact us at privacy@linkexpress.app',
            ),

            _Section(
              number: '10',
              title: 'Children\'s Privacy',
              body:
                'LinkExpress is not intended for users under the age of 18. We do not knowingly '
                'collect personal information from minors. If we discover that a minor has created '
                'an account, we will immediately delete all associated data.',
            ),

            _Section(
              number: '11',
              title: 'International Transfers',
              body:
                'Your data may be transferred to and processed in countries other than your own. '
                'We ensure that all international transfers comply with applicable data protection '
                'laws and that appropriate safeguards are in place to protect your information.',
            ),

            _Section(
              number: '12',
              title: 'Changes to This Policy',
              body:
                'We may update this Privacy Policy from time to time. We will notify you of any '
                'significant changes via email or through the app. Your continued use of LinkExpress '
                'after changes are posted constitutes acceptance of the updated policy.',
            ),

            _Section(
              number: '13',
              title: 'Contact Us',
              body:
                'For any privacy-related questions or requests, please contact our Data Protection team:\n\n'
                'Email: privacy@linkexpress.app\n'
                'Response time: within 72 hours',
            ),

            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0EDE8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0D8C8)),
              ),
              child: Text(
                'Your privacy matters to us. We are committed to being transparent about '
                'how we handle your data and giving you control over your information.',
                style: GoogleFonts.manrope(
                  fontSize: 11,
                  color: const Color(0xFF9A9080),
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String number, title, body;
  const _Section({required this.number, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24, height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFFB8960A),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(number,
                    style: GoogleFonts.syne(
                      fontSize: 10, fontWeight: FontWeight.w800,
                      color: Colors.white,
                    )),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(title,
                  style: GoogleFonts.syne(
                    fontSize: 14, fontWeight: FontWeight.w800,
                    color: const Color(0xFF111111),
                    letterSpacing: -0.2,
                  )),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 34),
            child: Text(body,
              style: GoogleFonts.manrope(
                fontSize: 13,
                color: const Color(0xFF6B6560),
                height: 1.7,
                fontWeight: FontWeight.w400,
              )),
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFEEEEEB), thickness: 1),
        ],
      ),
    );
  }
}