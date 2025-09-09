import 'package:flutter/material.dart';

class CourseDemoCard extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  const CourseDemoCard({
    super.key,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background image
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),

            // Semi-transparent top bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .6),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.ondemand_video, color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    Text(
                      "Watch Course Demo Class",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

            // Play button in center
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white70,
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.play_arrow,
                size: 40,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
