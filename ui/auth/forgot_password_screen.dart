import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:physio_app/bloc/cubit/selection_cubit.dart';
import 'package:physio_app/bloc/forgot%20password/forgot_password_bloc.dart';
import 'package:physio_app/const/colors.dart';
import 'package:physio_app/widgets/button_widget.dart';
import 'package:physio_app/widgets/input_field_widget.dart';
import 'package:physio_app/widgets/segmented_button.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isEmailSelected = true;
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordFailure) {
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
        } else if (state is ForgotPasswordSuccess) {
          Navigator.pushNamed(context, '/code_verification_screen',
              arguments: state.email);
        }
      },
      builder: (context, state) {
        return BlocProvider(
          create: (_) => SelectionCubit(),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.backGroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Forgot Your Password?",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "No worries, you just need to type your email address or username and we will send the verification code.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 32),
                  const SegmentedWidget(),
                  const SizedBox(height: 16),
                  BlocBuilder<SelectionCubit, Selection>(
                    builder: (context, selectedSelection) {
                      return TextFieldWidget(
                        key: ValueKey(selectedSelection),
                        keyboardType: selectedSelection == Selection.email
                            ? TextInputType.emailAddress
                            : TextInputType.phone,
                        hintText: selectedSelection == Selection.email
                            ? "Enter email address"
                            : "Enter Your Phone Number",
                        isPassword: false,
                        controller: emailController,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonWidget(
                      onClick: () {
                        context
                            .read<ForgotPasswordBloc>()
                            .add(ForgotPasswordSubmit(emailController.text));
                      },
                      buttonText: "Send Verification code",
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
