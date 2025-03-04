import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class BuildTextButton extends StatelessWidget {
  const BuildTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        
        text,
        style: const TextStyle(fontWeight: FontWeight.bold ,color: AppColors.kPrimaryColor,),
      ),
    );
  }
}