import 'package:flutter/material.dart';

class ModuleResourceItem extends StatelessWidget {
  final String title;
  final String subtitle; // e.g. "PDF • 2 MB"
  final VoidCallback? onTap;

  const ModuleResourceItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffE8ECF1),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff090F12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
