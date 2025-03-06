import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    this.child,
    this.style,
  });

  final VoidCallback? onPressed;
  final Widget? child;
  final ButtonStyle? style;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(style: style, onPressed: onPressed, child: child);
  }
}

class CustomElevatedButtonBro extends StatelessWidget {
  const CustomElevatedButtonBro({
    super.key,
    this.width,
    this.height,
    this.child,
    this.onPressed,
  });
  final double? width;
  final double? height;
  final Widget? child;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
          foregroundColor: AppColors.kWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: child,
      ),
    );
  }
}
