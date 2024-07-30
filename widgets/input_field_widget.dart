import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:physio_app/bloc/auth/auth_bloc.dart';
import 'package:physio_app/const/colors.dart';
import 'package:physio_app/const/text.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  const TextFieldWidget(
      {super.key,
      required this.hintText,
      required this.isPassword,
      required this.controller,
      this.keyboardType = TextInputType.emailAddress});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool showText;
  bool showPassword = false;
  @override
  void initState() {
    showText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is PasswordShown) {
          showPassword = state.showPassword;
        }
      },
      builder: (context, state) {
        return TextField(
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          obscureText: widget.isPassword && showPassword,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            filled: true,
            fillColor: AppColors.fieldsColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            hintText: widget.hintText,
            hintStyle: AppTextStyle.infoText,
            suffixIcon: widget.isPassword
                ? showPassword
                    ? IconButton(
                        icon: const Icon(Icons.visibility_off),
                        onPressed: () {
                          context
                              .read<AuthBloc>()
                              .add(ChangePasswordShown(!showPassword));
                        })
                    : IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {
                          context
                              .read<AuthBloc>()
                              .add(ChangePasswordShown(!showPassword));
                        })
                : null,
          ),
        );
      },
    );
  }
}
