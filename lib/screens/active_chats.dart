import 'package:flutter/material.dart';

class ActiveChats extends StatelessWidget {
  const ActiveChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TITLE
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "ACTIVE",
            style: TextStyle(
              color: Colors.grey,
              letterSpacing: 2,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 85,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            children: const [
              _ActiveUser("MS", Colors.purple, "Mahdi"),
              _ActiveUser("AK", Colors.blue, "Ali"),
              _ActiveUser("LN", Colors.orange, "Lina"),
              _ActiveUser("YM", Colors.black, "Yacine"),
              _ActiveUser("SL", Colors.teal, "Sofia"),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActiveUser extends StatelessWidget {
  final String initials;
  final Color color;
  final String name;

  const _ActiveUser(this.initials, this.color, this.name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
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

              Positioned(
                right: 2,
                bottom: 2,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            name,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}