import 'package:flutter/material.dart';

class RecentChats extends StatelessWidget {
  const RecentChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _ChatTile(
          initials: "MS",
          color: Colors.purple,
          name: "Mahdi Saidi",
          message: "Is the parcel still available?",
          time: "2m",
        ),
        _ChatTile(
          initials: "AK",
          color: Colors.blue,
          name: "Ali K.",
          message: "I can carry 2kg for you",
          time: "10m",
        ),
        _ChatTile(
          initials: "LN",
          color: Colors.orange,
          name: "Lina N.",
          message: "Thanks! I’ll confirm soon",
          time: "1h",
        ),
        _ChatTile(
          initials: "YM",
          color: Colors.black,
          name: "Yacine M.",
          message: "Sent you the details",
          time: "3h",
        ),
      ],
    );
  }
}

class _ChatTile extends StatelessWidget {
  final String initials;
  final Color color;
  final String name;
  final String message;
  final String time;

  const _ChatTile({
    required this.initials,
    required this.color,
    required this.name,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          /// AVATAR
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          /// TIME
          Text(
            time,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}