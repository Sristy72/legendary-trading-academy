import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final int index;
  final String title;
  final String ImagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const ItemWidget({
    super.key,
    required this.index,
    required this.title,
    required this.ImagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Color(0XFFB8C3D4),//isSelected ? Colors.blue[50] : Color(0XFFB8C3D4),,
          borderRadius: BorderRadius.circular(8),
          // border: isSelected
          //     ? Border.all(color: Colors.blue, width: 1)
          //     : Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue[100] : Colors.grey[200],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Image.asset(
                  ImagePath,
                  width: 26,
                  height: 26,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0XFF1A3E74),
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.blue[800],
              ),
          ],
        ),
      ),
    );
  }
}