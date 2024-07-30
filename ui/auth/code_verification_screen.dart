import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:physio_app/bloc/forgot%20password/forgot_password_bloc.dart';
import 'package:physio_app/const/colors.dart';
import 'package:physio_app/const/text.dart';
import 'package:physio_app/widgets/button_widget.dart';

class CodeVerificationScreen extends StatefulWidget {
  final String email;
  const CodeVerificationScreen({super.key, required this.email});

  @override
  State<CodeVerificationScreen> createState() => _CodeVerificationScreenState();
}

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  late bool _onEditing;
  String code = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
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
          } else if (state is VerificationSuccess) {
            Navigator.pushNamed(context, '/new_password_screen',
                arguments: state.email);
          }
        },
        builder: (context, state) {
          if (state is ForgotPasswordLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Enter Verification Code",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "Enter the code we sent you to your email ",
                        style: TextStyle(
                          color: AppColors.textColor,
                        ),
                      ),
                      TextSpan(
                        text: widget.email,
                        style: const TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ]),
                  ),
                  const SizedBox(height: 16),
                  VerificationCode(
                    fillColor: AppColors.fieldsColor,
                    fullBorder: true,
                    underlineWidth: 0.5,
                    textStyle: const TextStyle(
                        fontSize: 20.0, color: AppColors.infoTextColor),
                    keyboardType: TextInputType.number,
                    underlineColor: AppColors.primaryColor,
                    length: 4,
                    cursorColor: Colors.blue,
                    onCompleted: (String value) {
                      code = value;
                    },
                    onEditing: (bool value) {
                      setState(() {
                        _onEditing = value;
                      });
                      if (!_onEditing) FocusScope.of(context).unfocus();
                    },
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                      width: double.infinity,
                      child: ButtonWidget(
                        onClick: () {
                          BlocProvider.of<ForgotPasswordBloc>(context)
                              .add(VerificationRequested(code));
                        },
                        buttonText: "Verify",
                      )),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {},
                    child: Text('Resend Code',
                        style: AppTextStyle.infoText.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        )),
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
