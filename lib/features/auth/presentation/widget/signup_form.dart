import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/texts/texts.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/core/extensions/input_decoration_extensions.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/personal_information_screen.dart';

import 'package:flutx_core/core/validation/validators.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/theme/app_colors.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            ///Email
            TextFormField(
              controller: _emailController,
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress,
              decoration: context.primaryInputDecoration.copyWith(
                hintText: TTexts.email,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Color(0xFF666666),
                ),
              ),
              validator: Validators.email,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_passwordFocus),
              autofillHints: const [AutofillHints.email],
            ),

            SizedBox(height: 15),

            ///Password
            ValueListenableBuilder<bool>(
              valueListenable: _obscurePassword,
              builder: (context, obscure, _) {
                return TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  obscureText: obscure,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color: AppColors.text),
                  decoration: context.primaryInputDecoration.copyWith(
                    hintText: TTexts.password,
                    prefixIcon: Icon(Icons.lock_outline),
                  ),

                  validator: Validators.password,
                  autofillHints: const [AutofillHints.password],
                );
              },
            ),

            SizedBox(height: 15),

            ValueListenableBuilder<bool>(
              valueListenable: _obscurePassword,
              builder: (context, obscure, _) {
                return TextFormField(
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocus,
                  obscureText: obscure,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color: AppColors.text),
                  decoration: context.primaryInputDecoration.copyWith(
                    hintText: TTexts.password,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Color(0xFF666666),
                    ),
                  ),

                  validator: Validators.password,
                  autofillHints: const [AutofillHints.password],
                );
              },
            ),

            SizedBox(height: 16),

            ///Sign in
            context.primaryButton(
              onPressed: () {
                Get.to(
                  PersonalInformationScreen(),
                );
              },
              text: 'Sign up',
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
