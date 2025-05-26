import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final String? label;
  final IconData? icon;
  final String? hintText;
  final int? minLines;
  final int? maxLines;
  final TextCapitalization? textCapitalization;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key, 
    this.label, 
    this.icon,
    this.hintText,
    this.minLines= 1,  
    this.maxLines= 1, 
    this.textCapitalization= TextCapitalization.sentences, 
    this.obscureText= false,
    this.onChanged, 
    this.validator, 
    this.controller,
  });
  
  @override
  Widget build(BuildContext context) {

    final colorsTheme = Theme.of(context).colorScheme;

    final border= OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      // borderSide: BorderSide(color: colorsTheme.primary)
    );

    return TextFormField(
      controller: controller,
      textCapitalization: textCapitalization!,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: border,
        // focusedBorder: border.copyWith(borderSide: BorderSide(color: colorsTheme.primary)),
        errorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red.shade900)),
        focusedErrorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red.shade900)),
        labelText: label,
        alignLabelWithHint: true,
        hintText: hintText,
        focusColor: colorsTheme.primary,
        prefixIcon: icon!=null 
          ?Icon(icon, color: colorsTheme.primary) 
          :null,
      ),
    );
  }
}