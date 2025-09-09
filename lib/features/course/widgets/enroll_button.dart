// lib/features/courses/widgets/enroll_button.dart

import 'package:flutter/material.dart';

class EnrollButton extends StatelessWidget {
  final double price;
  final VoidCallback onTap;

  const EnrollButton({super.key, required this.price, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[100],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total  \$${price.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow[700],
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: onTap,
            child: const Text("Enroll Now"),
          ),
        ],
      ),
    );
  }
}
