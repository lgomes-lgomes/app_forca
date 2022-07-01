import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {

    CustomFormField({
      Key? key,
      required this.hintText,
      this.customInputFormatters,
      this.validator,
      this.customController,
      this.inputDecoration,
      required this.customObscureText,
    }): super(key: key);

    final String hintText;
    final List<TextInputFormatter>? customInputFormatters;
    final String? Function(String?)? validator;
    final TextEditingController? customController;
    final InputDecoration? inputDecoration;
    final bool customObscureText;

   @override
   Widget build(BuildContext context) {
       return SizedBox(
        height: 40,
         child: TextFormField(
          inputFormatters: customInputFormatters,
          validator: validator,
          controller: customController,
          decoration: inputDecoration,
          obscureText: customObscureText,
         ),
       );
  }
}