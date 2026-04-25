import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ChatBottomSheet extends StatefulWidget {
  final Function(String) onSend;

  const ChatBottomSheet({super.key, required this.onSend});

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _controller.clear();
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _attachOption(Icons.image, 'Photo', Color(0xFF0EA5A4)),
                _attachOption(Icons.insert_drive_file, 'File', Color(0xFF3467EB)),
                _attachOption(Icons.location_on, 'Location', Color(0xFFB8960A)),
                _attachOption(Icons.camera_alt, 'Camera', Color(0xFF515050)),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _attachOption(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 56, height: 56,
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color, size: 26),
        ),
        const SizedBox(height: 6),
        Text(label, style: GoogleFonts.manrope(fontSize: 12, color: Colors.black54)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Add / attachment ──────────────────────
          GestureDetector(
            onTap: _showAttachmentOptions,
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.add, color: Color(0xFFB8960A), size: 30),
            ),
          ),

          // ── Microphone ────────────────────────────
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Voice message — coming soon',
                      style: GoogleFonts.manrope(fontSize: 13)),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.black87,
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(Iconsax.microphone, color: Color(0xFFB8960A), size: 25),
            ),
          ),

          // ── Text input ────────────────────────────
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: TextFormField(
                controller: _controller,
                onFieldSubmitted: (_) => _send(),
                decoration: InputDecoration(
                  hintText: "Write a message..",
                  hintStyle: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // ── Send button ───────────────────────────
          GestureDetector(
            onTap: _send,
            child: Container(
              width: 45,
              height: 45,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(60),
              ),
              child: Center(
                child: Icon(Iconsax.send_2, color: Color(0xFFB8960A), size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}