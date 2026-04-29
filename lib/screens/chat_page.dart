import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/screens/chatbottomsheet_page.dart';
import 'package:my_app/screens/user_profile_page.dart';

class ChatPage extends StatefulWidget {
  final String initials;
  final Color color;
  final String name;
  final List<Map<String, dynamic>> messages;
  final double rating;
  final int trips;
  final int deliveries;

  const ChatPage({
    super.key,
    required this.initials,
    required this.color,
    required this.name,
    required this.messages,
    required this.rating,
    required this.trips,
    required this.deliveries,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late List<Map<String, dynamic>> _messages;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _messages = List.from(widget.messages);
  }

  void _addMessage(String text) {
    setState(() {
      _messages.add({'text': text, 'isSent': true});
    });
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
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
            const SizedBox(height: 16),
            _menuOption(
              icon: Icons.person_outline,
              label: 'View Profile',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserProfilePage(
                      initials: widget.initials,
                      color: widget.color,
                      name: widget.name,
                      rating: widget.rating,
                      trips: widget.trips,
                      deliveries: widget.deliveries,
                    ),
                  ),
                );
              },
            ),
            _menuOption(
              icon: Icons.notifications_off_outlined,
              label: 'Mute notifications',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.name} muted',
                        style: GoogleFonts.manrope(fontSize: 13)),
                    backgroundColor: Colors.black87,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            _menuOption(
              icon: Icons.flag_outlined,
              label: 'Report',
              onTap: () {
                Navigator.pop(context);
                _showConfirmDialog(
                  title: 'Report ${widget.name}?',
                  message: 'This will send a report to our team for review.',
                  confirmLabel: 'Report',
                  confirmColor: Colors.orange,
                );
              },
            ),
            _menuOption(
              icon: Icons.block,
              label: 'Block',
              color: Colors.red,
              onTap: () {
                Navigator.pop(context);
                _showConfirmDialog(
                  title: 'Block ${widget.name}?',
                  message: 'They won\'t be able to message you anymore.',
                  confirmLabel: 'Block',
                  confirmColor: Colors.red,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.black87,
  }) {
    return ListTile(
      leading: Icon(icon, color: color, size: 22),
      title: Text(
        label,
        style: GoogleFonts.syne(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
      onTap: onTap,
    );
  }

  void _showConfirmDialog({
    required String title,
    required String message,
    required String confirmLabel,
    required Color confirmColor,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title,
            style: GoogleFonts.syne(fontWeight: FontWeight.w700, fontSize: 16)),
        content: Text(message,
            style: GoogleFonts.manrope(fontSize: 14, color: Colors.black54)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: GoogleFonts.manrope(color: Colors.black54)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(confirmLabel,
                style: GoogleFonts.manrope(
                    color: confirmColor, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDEC),
      appBar: AppBar(
        backgroundColor: Color(0xFFEDEDEC),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios_new,
                    color: Colors.black87, size: 20),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserProfilePage(
                      initials: widget.initials,
                      color: widget.color,
                      name: widget.name,
                      rating: widget.rating,
                      trips: widget.trips,
                      deliveries: widget.deliveries,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          widget.initials,
                          style: GoogleFonts.syne(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.name,
                          style: GoogleFonts.syne(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
 'Online',
                          style: GoogleFonts.manrope(
                            color: Color(0xFF00B32D),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Icon(Icons.call, color: Colors.black38, size: 20),
              const SizedBox(width: 10),
              Icon(Icons.videocam_rounded, color: Colors.black38, size: 20),
              const SizedBox(width: 10),
              // ── 3 dots ────────────────────────────
              GestureDetector(
                onTap: _showMoreOptions,
                child: Icon(Icons.more_vert, color: Colors.black38, size: 20),
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: Container(color: Colors.black12, height: 1),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isSent = msg['isSent'] as bool;
                return Align(
                  alignment:
                      isSent ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding:
                        EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: 270),
                    decoration: BoxDecoration(
                      color: isSent ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            offset: Offset(0, 2))
                      ],
                    ),
                    child: Text(
                      msg['text'],
                      style: GoogleFonts.syne(
                        color: isSent ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomSheet: ChatBottomSheet(onSend: _addMessage),
    );
  }
}