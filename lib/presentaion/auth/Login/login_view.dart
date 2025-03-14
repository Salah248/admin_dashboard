import 'package:admin_dashboard/core/function/show_msg_snack.dart';
import 'package:admin_dashboard/core/helper/navigation/app_navigation.dart';
import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:admin_dashboard/core/widgets/app_bar.dart';
import 'package:admin_dashboard/core/widgets/build_text_from_field.dart';
import 'package:admin_dashboard/core/widgets/custom_circle_indicator.dart';
import 'package:admin_dashboard/core/widgets/custom_elevated_button.dart';
import 'package:admin_dashboard/presentaion/auth/bloc/cubit/auth_cubit.dart';
import 'package:admin_dashboard/presentaion/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        child: BlocProvider(
          create: (context) => AuthCubit(),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                AppNavigator.pushAndRemove(context, const HomeView());
              }
              if (state is AuthFailure) {
                showMsgSnackBar(context, state.msgError);
              }
            },
            builder: (context, state) {
              var cubit = context.read<AuthCubit>();
              return state is AuthLoading
                  ? const CustomCircularIndicator()
                  : Form(
                    key: _formKey,
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
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          obscureText: isPasswordVisible,
                        ),
                        CustomElevatedButtonBro(
                          child: const Text('Login'),
                          onPressed: () {
                            if ( _formKey.currentState!.validate()) {
                              cubit.login(
                                data: {
                                  'email': _emailController.text,
                                  'password': _passwordController.text,
                                },
                              );
                            } 
                          },
                        ),
                      ],
                    ),
                  );
            },
          ),
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
