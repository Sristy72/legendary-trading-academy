import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/appbar.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';

import '../../../../core/widgets/pin_code.dart';
import '../../../../core/widgets/texts.dart';

class VerifyCodeScreen extends StatelessWidget{
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(title: 'Enter security code'),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height - 32),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  // Center(
                  //   child: CustomText(
                  //     style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  //     align: TextAlign.center,
                  //   ),
                  // ),

                  const SizedBox(height: 12),

                  // Subtitle
                  CustomText(
                    'Please check your Email for a message with your code. Your code is 6 numbers long.',
                    //align: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(color: Color(0xFF4E4E4E), fontSize: 15),
                  ),

                  const SizedBox(height: 32),

                  // Pin Code Field
                  PinCode(),

                  const SizedBox(height: 16),

                  Center(child: Text('Resend code in 43s', style: TextStyle(color: AppColors.titleTextColor, fontSize: 18),)),
                  const SizedBox(height: 30),

                  // Continue Button
                  context.primaryButton(
                    // isLoading: _authController.isLoading,
                    onPressed: () {},
                    text: "Verify",
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

