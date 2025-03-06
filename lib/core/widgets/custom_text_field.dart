import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key, required this.label, this.controller,
  });
final String label;
final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:controller ,
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
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.kGreyColor),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}
