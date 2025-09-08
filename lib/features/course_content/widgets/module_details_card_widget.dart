import 'package:flutter/material.dart';
import '../presentation/controllers/module_details_controller.dart';

Widget buildModuleCard(Module module, int index, ModulesDetailsController controller) {
  return Card(
    margin: const EdgeInsets.only(bottom: 16),
    elevation: 2,
    color: Color(0XFFB8C3D4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0XFF1A3E74),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  module.title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0XFFEFC227),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Text("Marked as Complete",style: TextStyle(
                    color: Color(0XFF1A3E74)
                  ),)
                  ]
              )
            ],
          ),
          const SizedBox(height: 8),
          // Module description
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              module.description,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF090F12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Recordings count
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Icon(
                  Icons.video_camera_front_outlined,
                  size: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff4E4E4E),
                ),
                const SizedBox(width: 6),
                Text(
                  '${module.recordingsCount} Class Recordings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff4E4E4E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
