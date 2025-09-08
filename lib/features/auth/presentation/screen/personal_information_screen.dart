import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/core/extensions/input_decoration_extensions.dart';
import 'package:flutter_ladydenily/core/widgets/texts.dart';
import 'package:flutx_core/core/validation/validators.dart';

import '../../../../core/common/texts/texts.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final TextEditingController _personalNameController = TextEditingController();
  final TextEditingController _personalAgeController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _personalNameFocus = FocusNode();
  final FocusNode _personalAgeFocus = FocusNode();
  final FocusNode _genderFocus = FocusNode();
  final FocusNode _nationalityFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
          'Personal Information',
          style: TextStyle(
            color: Color(0xFF1A3E74),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText('To create your new account, provide your information.'),
            SizedBox(height: 16),

            Row(
              children: [
                CustomText(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                CustomText(
                  '*',
                  style: TextStyle(
                    color: Color(0xFFEF1A26),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            //CustomText('Name*', style: TextStyle(fontWeight: FontWeight.w400 , fontSize: 16)),
            SizedBox(height: 8),
            TextFormField(
              controller: _personalNameController,
              focusNode: _personalNameFocus,
              keyboardType: TextInputType.emailAddress,
              decoration: context.primaryInputDecoration.copyWith(
                hintText: TTexts.personalName,
              ),
              validator: Validators.email,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_personalNameFocus),
              autofillHints: const [AutofillHints.email],
            ),

            SizedBox(height: 14),

            Row(
              children: [
                CustomText(
                  'Age',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                CustomText(
                  '*',
                  style: TextStyle(
                    color: Color(0xFFEF1A26),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _personalAgeController,
              focusNode: _personalAgeFocus,
              keyboardType: TextInputType.emailAddress,
              decoration: context.primaryInputDecoration.copyWith(
                hintText: TTexts.personalAge,
              ),
              validator: Validators.email,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_personalAgeFocus),
              autofillHints: const [AutofillHints.email],
            ),

            SizedBox(height: 14),
            Row(
              children: [
                CustomText(
                  'Gender',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                CustomText(
                  '*',
                  style: TextStyle(
                    color: Color(0xFFEF1A26),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _genderController,
              focusNode: _genderFocus,
              keyboardType: TextInputType.emailAddress,
              decoration: context.primaryInputDecoration.copyWith(
                hintText: TTexts.gender,
                suffixIcon: Icon(Icons.keyboard_arrow_down),
              ),
              validator: Validators.email,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_genderFocus),
              autofillHints: const [AutofillHints.email],
            ),

            SizedBox(height: 14),
            Row(
              children: [
                CustomText(
                  'Nationality',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                CustomText(
                  '*',
                  style: TextStyle(
                    color: Color(0xFFEF1A26),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _nationalityController,
              focusNode: _nationalityFocus,
              keyboardType: TextInputType.emailAddress,
              decoration: context.primaryInputDecoration.copyWith(
                hintText: TTexts.nationality,
                suffixIcon: Icon(Icons.keyboard_arrow_down),
              ),
              validator: Validators.email,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_nationalityFocus),
              autofillHints: const [AutofillHints.email],
            ),

            SizedBox(height: 14),
            Row(
              children: [
                CustomText(
                  'Address',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                CustomText(
                  '*',
                  style: TextStyle(
                    color: Color(0xFFEF1A26),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _addressController,
              focusNode: _addressFocus,
              keyboardType: TextInputType.emailAddress,
              decoration: context.primaryInputDecoration.copyWith(
                hintText: TTexts.address,
              ),
              validator: Validators.email,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_addressFocus),
              autofillHints: const [AutofillHints.email],
            ),

            SizedBox(height: 205),
            context.primaryButton(onPressed: () {}, text: 'Continue'),
          ],
        ),
      ),
    );
  }
}
