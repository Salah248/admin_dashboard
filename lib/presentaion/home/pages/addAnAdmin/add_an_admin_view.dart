import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:admin_dashboard/core/widgets/app_bar.dart';
import 'package:admin_dashboard/core/widgets/build_text_from_field.dart';
import 'package:admin_dashboard/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class AddAnAdminView extends StatefulWidget {
  const AddAnAdminView({super.key});

  @override
  State<AddAnAdminView> createState() => _AddAnAdminViewState();
}

class _AddAnAdminViewState extends State<AddAnAdminView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text(
          'Add An Admin',
          style: TextStyle(color: AppColors.kWhiteColor),
        ),
        backgroundColor: AppColors.kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 15,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            CustomTextFormField(label: 'Name', controller: _nameController),
            CustomTextFormField(
              label: 'Email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            CustomTextFormField(
              label: 'Password',
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            CustomElevatedButtonBro(
              child: const Text('Add'),
              onPressed: () {},
            )
            ],
        ),
      ),
    );
  }
}
