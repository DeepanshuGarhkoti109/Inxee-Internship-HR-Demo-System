import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inxee_hr_application/screens/login_page_employee.dart';
import 'package:inxee_hr_application/widgets/button_input.dart';
import 'package:inxee_hr_application/widgets/text_field_input.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
  }

  void navigateToLoginScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  //icons

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Reset Password',
                        style: GoogleFonts.robotoMono(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  //username textfield
                  TextFieldInput(
                    prefix: Icon(Icons.password),
                    hintText: '1@345ddshkDejGI^',
                    labeltext: 'Password',
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                    isPass: true,
                  ),

                  const SizedBox(height: 25),

                  //password textfield

                  TextFieldInput(
                    textEditingController: _confirmpasswordController,
                    prefix: Icon(Icons.password),
                    hintText: '1@345ddshkDejGI^',
                    labeltext: 'Confirm password',
                    textInputType: TextInputType.text,
                    isPass: true,
                  ),

                  const SizedBox(height: 25),

                  //LoginIn Button

                  ButtonInput(
                    text: 'NEXT',
                    onTap: navigateToLoginScreen,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
