import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/core/widgets/texts.dart';
import 'package:get/get.dart';


class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key, required this.title, required this.description, required this.buttonText, this.showClose = true, this.style, required this.subTitle});

  final String title;
  final String subTitle;
  final String description;
  final String buttonText;
  final bool showClose;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    return Dialog(
      backgroundColor: Color(0xFFE8ECF1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image + Close button
            Stack(
              children: [
                Center(
                  child: Text(title, style: style)
                ),

                if(showClose)
                  Positioned(
                    right: -10,
                    top: -10, // <-- moves the icon upward
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 28,),
                      onPressed: () => Get.back(),
                    ),
                  )
              ],
            ),
            const SizedBox(height: 20),

            // Title
            CustomText(
              subTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 15,color: Color(0xFF4E4E4E)
              ),
            ),
            const SizedBox(height: 12),

            // Description
            CustomText(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),

            const SizedBox(height: 24),

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: context.primaryButton(onPressed: () {  }, text: 'Agree & Continue')
            )
          ],
        ),
      ),
    );
  }
}