import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/core/extensions/input_decoration_extensions.dart';
import 'package:flutter_ladydenily/core/widgets/texts.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/upload_profile_screen.dart';
import 'package:flutx_core/flutx_core.dart';
import 'package:get/get.dart';

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
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _personalNameFocus = FocusNode();
  final FocusNode _personalAgeFocus = FocusNode();
  final FocusNode _nationalityFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  String gender = "Male";

  void _submit() {
    /// [Note: Form Key]
    Get.to(UploadProfileScreen());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Personal Information',
          style: TextStyle(
            color: Color(0xFF1A3E74),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      'To create your new account, provide your information.',
                    ),
                    SizedBox(height: 16),

                    Row(
                      children: [
                        CustomText(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
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
                      controller: _personalNameController,
                      focusNode: _personalNameFocus,
                      keyboardType: TextInputType.emailAddress,
                      decoration: context.primaryInputDecoration.copyWith(
                        hintText: TTexts.personalName,
                      ),
                      validator: Validators.email,
                      onFieldSubmitted: (_) => FocusScope.of(
                        context,
                      ).requestFocus(_personalNameFocus),
                      autofillHints: const [AutofillHints.email],
                    ),

                    SizedBox(height: 14),

                    Row(
                      children: [
                        CustomText(
                          'Age',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
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
                      keyboardType: TextInputType.number,
                      decoration: context.primaryInputDecoration.copyWith(
                        hintText: TTexts.personalAge,
                      ),
                      validator: Validators.email,
                      onFieldSubmitted: (_) => FocusScope.of(
                        context,
                      ).requestFocus(_personalAgeFocus),
                      autofillHints: const [AutofillHints.email],
                    ),

                    SizedBox(height: 14),
                    Row(
                      children: [
                        CustomText(
                          'Gender',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
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

                    DropdownButtonFormField<String>(
                      initialValue: gender,
                      items: const [
                        DropdownMenuItem(value: "Male", child: Text("Male")),
                        DropdownMenuItem(
                          value: "Female",
                          child: Text("Female"),
                        ),
                        DropdownMenuItem(value: "Other", child: Text("Other")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFE8ECF1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    SizedBox(height: 14),
                    Row(
                      children: [
                        CustomText(
                          'Nationality',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
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
                      onFieldSubmitted: (_) => FocusScope.of(
                        context,
                      ).requestFocus(_nationalityFocus),
                      autofillHints: const [AutofillHints.email],
                    ),

                    SizedBox(height: 14),
                    Row(
                      children: [
                        CustomText(
                          'Address',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
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
                  ],
                ),
              ),
            ),

            // Fixed bottom button
            Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              child: context.primaryButton(
                onPressed: () {
                  _submit();
                },
                text: 'Continue',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
