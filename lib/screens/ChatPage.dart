// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/screens/chatbottomsheet_page.dart';
import 'package:my_app/screens/user_profile_page.dart';
import 'package:my_app/screens/auth_service.dart';

class ChatPage extends StatefulWidget {
  final String initials;
  final Color color;
  final String name;
  final List<Map<String, dynamic>> messages;
  final double rating;
  final int trips;
  final int deliveries;
  final String? otherUid; // ← optional, for real chats

  const ChatPage({
    super.key,
    required this.initials,
    required this.color,
    required this.name,
    required this.messages,
    required this.rating,
    required this.trips,
    required this.deliveries,
    this.otherUid,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final AuthService _authService = AuthService();
  late String _chatId;
  bool _useRealtime = false;

  @override
  void initState() {
    super.initState();
    if (widget.otherUid != null && widget.otherUid!.isNotEmpty) {
      _chatId = _authService.getChatId(widget.otherUid!);
      _useRealtime = true;
    }
  }

  void _sendMessage(String text) async {
    if (_useRealtime) {
      await _authService.sendMessage(chatId: _chatId, text: text);
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
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
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => UserProfilePage(
                    initials: widget.initials,
                    color: widget.color,
                    name: widget.name,
                    rating: widget.rating,
                    trips: widget.trips,
                    deliveries: widget.deliveries,
                  ),
                ));
              },
            ),
            _menuOption(
              icon: Icons.notifications_off_outlined,
              label: 'Mute notifications',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${widget.name} muted',
                      style: GoogleFonts.manrope(fontSize: 13)),
                  backgroundColor: Colors.black87,
                  duration: const Duration(seconds: 2),
                ));
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
      title: Text(label,
          style: GoogleFonts.syne(
              fontSize: 15, fontWeight: FontWeight.w600, color: color)),
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

  Widget _buildMessageBubble(String text, bool isSent) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: const BoxConstraints(maxWidth: 270),
        decoration: BoxDecoration(
          color: isSent ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))
          ],
        ),
        child: Text(
          text,
          style: GoogleFonts.syne(
            color: isSent ? Colors.white : Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildRealtimeMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: _authService.getMessagesStream(_chatId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: Color(0xFFB8960A)));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('No messages yet.\nSay hello! 👋',
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                    color: Colors.black38, fontSize: 14)),
          );
        }
        final docs = snapshot.data!.docs;
        final myUid = _authService.currentUid ?? '';
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent);
          }
        });
        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final isSent = data['senderId'] == myUid;
            return _buildMessageBubble(data['text'] ?? '', isSent);
          },
        );
      },
    );
  }

  Widget _buildStaticMessages() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        final msg = widget.messages[index];
        return _buildMessageBubble(
            msg['text'] ?? '', msg['isSent'] as bool);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDEC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEDEDEC),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.black87, size: 20),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (_) => UserProfilePage(
                    initials: widget.initials,
                    color: widget.color,
                    name: widget.name,
                    rating: widget.rating,
                    trips: widget.trips,
                    deliveries: widget.deliveries,
                  ),
                )),
                child: Row(
                  children: [
                    Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(widget.initials,
                            style: GoogleFonts.syne(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.name,
                            style: GoogleFonts.syne(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                        Text(
                          _useRealtime ? 'Online' : 'Demo chat',
                          style: GoogleFonts.manrope(
                            color: _useRealtime
                                ? const Color(0xFF00B32D)
                                : Colors.black38,
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
              const Icon(Icons.call, color: Colors.black38, size: 20),
              const SizedBox(width: 10),
              const Icon(Icons.videocam_rounded, color: Colors.black38, size: 20),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: _showMoreOptions,
                child: const Icon(Icons.more_vert,
                    color: Colors.black38, size: 20),
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Container(color: Colors.black12, height: 1),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: _useRealtime
                ? _buildRealtimeMessages()
                : _buildStaticMessages(),
          ),
        ],
      ),
      bottomSheet: ChatBottomSheet(onSend: _sendMessage),
    );
  }
}