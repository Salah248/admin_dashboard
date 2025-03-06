import 'package:admin_dashboard/core/helper/navigation/app_navigation.dart';
import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:admin_dashboard/core/widgets/app_bar.dart';
import 'package:admin_dashboard/core/widgets/build_text_from_field.dart';
import 'package:admin_dashboard/core/widgets/custom_elevated_button.dart';
import 'package:admin_dashboard/presentaion/home/home_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        hideBack: true,
        backgroundColor: AppColors.kPrimaryColor,
        title: Text(
          'Login As An Admin',
          style: TextStyle(color: AppColors.kWhiteColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15,
          children: [
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
            CustomElevatedButtonBro(
              child: const Text('Login'),
              onPressed: () {
                AppNavigator.pushReplacement(context, const HomeView());
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
