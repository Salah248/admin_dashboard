import 'package:admin_dashboard/core/function/show_msg_snack.dart';
import 'package:admin_dashboard/core/helper/navigation/app_navigation.dart';
import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:admin_dashboard/core/widgets/app_bar.dart';
import 'package:admin_dashboard/core/widgets/build_text_from_field.dart';
import 'package:admin_dashboard/core/widgets/custom_circle_indicator.dart';
import 'package:admin_dashboard/core/widgets/custom_elevated_button.dart';
import 'package:admin_dashboard/presentaion/auth/Login/login_view.dart';
import 'package:admin_dashboard/presentaion/home/pages/addAnAdmin/bloc/cubit/add_admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAnAdminView extends StatefulWidget {
  const AddAnAdminView({super.key});

  @override
  State<AddAnAdminView> createState() => _AddAnAdminViewState();
}

class _AddAnAdminViewState extends State<AddAnAdminView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;

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
      body: BlocProvider(
        create: (context) => AddAdminCubit(),
        child: BlocConsumer<AddAdminCubit, AddAdminState>(
          listener: (context, state) {
            if (state is AddAdminSuccess) {
              AppNavigator.pushAndRemove(context, const LoginView());
            }
            if (state is AddAdminFailure) {
              showMsgSnackBar(context, state.errMessage);
            }
          },
          builder: (context, state) {
            var cubit = context.read<AddAdminCubit>();

            return Padding(
              padding: const EdgeInsets.all(16),

              child:
                  state is AddAdminLoading
                      ? const Center(child: CustomCircularIndicator())
                      : Form(
                        key: _formKey,
                        child: Column(
                          spacing: 15,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 15),
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
                            const SizedBox(height: 20),
                            CustomElevatedButtonBro(
                              child: const Text('Add'),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.addAdmin(
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
                      ),
            );
          },
        ),
      ),
    );
  }
}
