import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:physio_app/bloc/auth/auth_bloc.dart';
import 'package:physio_app/const/assets.dart';
import 'package:physio_app/const/colors.dart';
import 'package:physio_app/const/text.dart';
import 'package:physio_app/widgets/button_widget.dart';
import 'package:physio_app/widgets/input_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _value = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                content: Text(state.error),
                backgroundColor: const Color.fromARGB(175, 244, 67, 54),
              ),
            );
          } else if (state is AuthSuccess) {
            Navigator.pushNamed(context, '/home');
          } else if (state is StayConnected) {
            _value = state.stayConnected;
          }
        },
        builder: (
          BuildContext context,
          AuthState state,
        ) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(child: Image.asset(Assets.logo)),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum.",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.infoText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    child: Column(
                      children: [
                        TextFieldWidget(
                          hintText: "Enter Email Address",
                          isPassword: false,
                          controller: emailController,
                        ),
                        const SizedBox(height: 16),
                        TextFieldWidget(
                          hintText: "Enter Password",
                          isPassword: true,
                          controller: passwordController,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  activeColor: AppColors.primaryColor,
                                  value: _value,
                                  onChanged: (bool? value) {
                                    context.read<AuthBloc>().add(
                                          ChangeStayConnected(value!),
                                        );
                                  },
                                ),
                                Text('Stay connected',
                                    style: AppTextStyle.infoText.copyWith(
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/forgot_password_screen');
                              },
                              child: Text('Forgot password',
                                  style: AppTextStyle.infoText.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ButtonWidget(
                            buttonText: "Sign in",
                            onClick: () {
                              context.read<AuthBloc>().add(AuthLoginRequested(
                                  email: emailController.text,
                                  password: passwordController.text));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
