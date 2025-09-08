import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/core/extensions/input_decoration_extensions.dart';
import 'package:flutter_ladydenily/core/widgets/texts.dart';
import 'package:flutx_core/core/validation/validators.dart';

import '../../../../core/common/texts/texts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final FocusNode _emailFocus = FocusNode();


  final TextEditingController _emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back, color: Color(0xFF1A3E74), size: 24),
        ),
        title: Text(
          'Forgot Password',
          style: TextStyle(
            color: Color(0xFF1A3E74),
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),
      
      body: Column(
        children: [
          CustomText('Select which contact details should we use to reset your password', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),

          SizedBox(height: 16,),

          TextFormField(
            controller: _emailController,
            focusNode: _emailFocus,
            keyboardType: TextInputType.emailAddress,
            decoration: context.primaryInputDecoration.copyWith(
                hintText: TTexts.email,
                prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF666666),)
            ),
            validator: Validators.email,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_emailFocus),
            autofillHints: const [AutofillHints.email],
          ),

          SizedBox(height: 20,),
          context.primaryButton(onPressed: () {  }, text: 'Continue'),

        ],
      ),
    );
  }
}
