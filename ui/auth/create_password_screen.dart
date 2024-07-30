import 'package:flutter/material.dart';
import 'package:physio_app/const/colors.dart';
import 'package:physio_app/widgets/button_widget.dart';
import 'package:physio_app/widgets/input_field_widget.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final passwordController = TextEditingController();
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
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create a new password",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "Create a new strong password, it should be composed of numbers, symbols and letters",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              hintText: "New password",
              isPassword: true,
              controller: passwordController,
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              hintText: "Confirm new password",
              isPassword: true,
              controller: passwordController,
            ),
            const SizedBox(height: 16),
            SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                  onClick: () {
                    Navigator.pushNamed(context, '/');
                  },
                  buttonText: "Create Password",
                )),
          ],
        ),
      ),
    );
  }
}
