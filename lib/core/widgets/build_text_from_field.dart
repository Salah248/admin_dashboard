import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.onChanged,
    this.focusNode, // إضافة FocusNode
  });

  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool obscureText;
  final String obscuringCharacter;
  final Function(String)? onChanged;
  final FocusNode? focusNode; // إضافة FocusNode

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      obscureText: obscureText,
      onChanged: onChanged,
      focusNode: focusNode, // ربط FocusNode
      obscuringCharacter: obscuringCharacter,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.kBordersideColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.kBordersideColor,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.kPrimaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.kGreyColor),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
