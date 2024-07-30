import 'package:flutter/material.dart';
import 'package:physio_app/const/colors.dart';
import 'package:physio_app/const/text.dart';

class ButtonWidget extends StatefulWidget {
  final String buttonText;
  final VoidCallback onClick;
  const ButtonWidget(
      {super.key, required this.buttonText, required this.onClick});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onClick,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(54),
        ),
        backgroundColor: AppColors.primaryColor, // Custom blue color
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      ),
      child: Text(
        widget.buttonText,
        style: AppTextStyle.buttonText,
      ),
    );
  }
}
