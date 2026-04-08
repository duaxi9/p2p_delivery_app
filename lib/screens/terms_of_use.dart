import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

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
          'Terms of Use',
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
                  Text('Terms of Use',
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
              title: 'Acceptance of Terms',
              body:
                'By accessing or using LinkExpress, you agree to be bound by these Terms of Use. '
                'If you do not agree to these terms, please do not use our platform. '
                'LinkExpress reserves the right to update these terms at any time, and continued '
                'use of the platform constitutes acceptance of any changes.',
            ),

            _Section(
              number: '2',
              title: 'Description of Service',
              body:
                'LinkExpress is a peer-to-peer delivery platform that connects Senders — individuals '
                'who need to ship parcels internationally — with Travelers who have available luggage '
                'space on their trips. LinkExpress acts solely as an intermediary and is not a licensed '
                'freight forwarder, courier, or shipping company.',
            ),

            _Section(
              number: '3',
              title: 'Eligibility',
              body:
                'You must be at least 18 years old to use LinkExpress. By registering, you confirm '
                'that all information you provide is accurate, current, and complete. Accounts found '
                'to be fraudulent or misrepresenting information will be permanently suspended.',
            ),

            _Section(
              number: '4',
              title: 'User Accounts',
              body:
                'You are responsible for maintaining the confidentiality of your account credentials. '
                'You agree to notify us immediately of any unauthorized use of your account. '
                'LinkExpress cannot be held liable for any loss resulting from unauthorized access '
                'to your account due to your failure to secure your credentials.',
            ),

            _Section(
              number: '5',
              title: 'Prohibited Items',
              body:
                'Users are strictly prohibited from sending or carrying any illegal items, including '
                'but not limited to: narcotics, weapons, counterfeit goods, hazardous materials, '
                'endangered species, or any items banned by customs regulations of the origin or '
                'destination country. Violation of this policy may result in permanent account '
                'termination and referral to law enforcement authorities.',
            ),

            _Section(
              number: '6',
              title: 'Escrow & Payments',
              body:
                'All payments on LinkExpress are processed through our secure escrow system. Funds '
                'are held in escrow until the Receiver confirms delivery. LinkExpress charges a '
                'platform service fee on each completed transaction. Refunds are subject to our '
                'Refund Policy. We are not responsible for any currency conversion fees charged '
                'by your bank or payment provider.',
            ),

            _Section(
              number: '7',
              title: 'Ratings & Reviews',
              body:
                'Both Senders and Travelers may rate and review each other after a completed '
                'transaction. Ratings must be honest and based on actual experience. Manipulating '
                'ratings, offering incentives for positive reviews, or submitting false reviews '
                'is strictly prohibited and may result in account suspension.',
            ),

            _Section(
              number: '8',
              title: 'Liability Limitation',
              body:
                'LinkExpress is not liable for any loss, damage, delay, or misdelivery of parcels. '
                'We strongly recommend that Senders declare the accurate value of items and purchase '
                'appropriate insurance. The maximum liability of LinkExpress in any dispute shall '
                'not exceed the platform fee collected for that transaction.',
            ),

            _Section(
              number: '9',
              title: 'Dispute Resolution',
              body:
                'In the event of a dispute between a Sender and Traveler, LinkExpress will act as '
                'a neutral mediator. Our support team will review evidence provided by both parties '
                'and make a final decision regarding escrow release. This decision is binding and '
                'final within the platform.',
            ),

            _Section(
              number: '10',
              title: 'Termination',
              body:
                'LinkExpress reserves the right to suspend or terminate any account at any time, '
                'with or without notice, for violations of these Terms of Use, fraudulent activity, '
                'or any conduct deemed harmful to the platform or its users.',
            ),

            _Section(
              number: '11',
              title: 'Governing Law',
              body:
                'These Terms of Use shall be governed by and construed in accordance with applicable '
                'international laws and the laws of the jurisdiction in which LinkExpress is registered. '
                'Any disputes arising shall be subject to the exclusive jurisdiction of the competent courts.',
            ),

            _Section(
              number: '12',
              title: 'Contact',
              body:
                'For questions regarding these Terms of Use, please contact us at:\n'
                'support@linkexpress.app',
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
                'By using LinkExpress, you acknowledge that you have read, understood, '
                'and agree to be bound by these Terms of Use.',
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