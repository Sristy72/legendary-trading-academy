import 'package:flutter/material.dart';
import '../../controllers/module_details_controller.dart';

Widget buildModuleCard(
  Module module,
  int index,
  ModulesDetailsController controller,
) {
  return Card(
    margin: const EdgeInsets.only(bottom: 16),
    elevation: 2,
    color: Color(0XFFE8ECF1),
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
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  // Functional checkbox
                  Checkbox(
                    value: module.isCompleted,
                    onChanged: (value) {
                      controller.toggleModuleCompletion(index);
                    },
                    activeColor: Color(0XFF1A3E74),
                    checkColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  // const SizedBox(width: 8),
                  Text(
                    "Mark as Complete",
                    style: TextStyle(
                      color: Color(0XFF1A3E74),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
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
                Container(
                  child: Image(
                    image: AssetImage("assets/icons/video-recorder.png"),
                    width: 18,
                    height: 18,
                  ),
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
