import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

void showMsgSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text), backgroundColor: AppColors.kPrimaryColor),
  );
}
