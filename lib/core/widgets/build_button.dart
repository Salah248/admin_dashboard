import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:admin_dashboard/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const BuildButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        CustomElevatedButton(onPressed: onPressed, child: const Icon(Icons.arrow_forward,color: AppColors.kWhiteColor))
      ],
    );
  }
}

