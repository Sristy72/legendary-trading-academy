import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'terms_controller.dart';
import 'term_item.dart';

class TermsDialog extends StatelessWidget {
  final String? title;
  final String confirmationText;
  final List<TermItem> terms;
  final bool useCheckbox; // if false, show "Agree & Continue" button
  final VoidCallback onAgree;

  const TermsDialog({
    Key? key,
    this.title,
    required this.terms,
    required this.confirmationText,
    required this.useCheckbox,
    required this.onAgree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TermsController controller = Get.put(TermsController());

    return Dialog(
      backgroundColor: const Color(0xFFF5F6FA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null) ...[
                    Center(
                      child: Text(
                        title!,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Text(
                    confirmationText,
                    style: const TextStyle(fontSize: 14.5, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  ...terms.map((item) => _buildTermItem(item)).toList(),
                  const SizedBox(height: 16),
                  useCheckbox
                      ? Obx(() => Row(
                    children: [
                      Checkbox(
                        value: controller.agreed.value,
                        onChanged: (val) {
                          controller.toggleAgreement(val);
                          if (val == true) onAgree();
                        },
                      ),
                      Expanded(
                        child: Text(
                          'I have read and agree to the terms and conditions above.',
                          style: TextStyle(fontSize: 14),
                        ),
                      )
                    ],
                  ))
                      : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFC107),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: onAgree,
                      child: Text(
                        'Agree & Continue',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF1D3557),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermItem(TermItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.check_circle, color: Colors.green, size: 20),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                children: [
                  TextSpan(
                    text: '${item.title}: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: item.description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
