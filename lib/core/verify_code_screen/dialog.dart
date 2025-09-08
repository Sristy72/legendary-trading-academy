import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/widgets/disclaimer_dialog.dart';

import '../widgets/disclaimer_text_with_button.dart';

class Dialogbox extends StatelessWidget {
  const Dialogbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SuccessDialog(
        title: 'Terms and Disclaimers',
        subTitle: 'By submitting this application, I acknowledge and agree that:',
        description:'',
        buttonText: 'Agree & Continue',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }
}
