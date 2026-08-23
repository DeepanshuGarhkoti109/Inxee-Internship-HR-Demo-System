import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inxee_hr_application/employee_panels/employee_panel.dart';

import 'package:inxee_hr_application/screens/login_page_admin.dart';
import 'package:inxee_hr_application/screens/otppage.dart';
import 'package:inxee_hr_application/widgets/button_input.dart';

import 'package:inxee_hr_application/widgets/text_field_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void LogInUser() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const EmployeePanelHomeScreen(),
      ),
      (route) => false,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void navigateToLoginPageAdmin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPageAdmin(),
      ),
    );
  }

  void navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpPage(),
      ),
    );
  }

  @override
  void setState(VoidCallback fn) {
    _emailController.addListener(() => setState(() {}));
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(32),
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  //icons

                  Image.asset(
                    'lib/images/unnamed.png',
                    height: 50,
                  ),

                  const SizedBox(height: 50),

                  //username textfield
                  TextFieldInput(
                    prefix: Icon(Icons.email),
                    hintText: 'abc@gmail.com',
                    labeltext: 'Email',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailController,
                  ),

                  const SizedBox(height: 25),

                  //password textfield

                  TextFieldInput(
                    prefix: Icon(Icons.password),
                    labeltext: 'Password',
                    textEditingController: _passwordController,
                    hintText: 'Enter your password',
                    textInputType: TextInputType.text,
                    isPass: true,
                  ),

                  const SizedBox(height: 5),

                  //FORGOT PASSWORD

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: navigateToForgotPassword,
                            child: Text(
                              'Forgot Password',
                              style: GoogleFonts.actor(
                                fontSize: 17,
                              ),
                            )),
                      ],
                    ),
                  ),

                  const SizedBox(height: 7),

                  //LoginIn Button

                  ButtonInput(
                    text: 'LOGIN',
                    onTap: LogInUser,
                  ),

                  const SizedBox(height: 50),

                  //divider

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'or LOGIN as',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  //admin lodin

                  Container(
                    width: 50,
                    height: 50,
                    child: GestureDetector(
                        onTap: navigateToLoginPageAdmin,
                        child: Image.asset('lib/images/administrator.png')
                        // SquareTile(
                        //   height: 50,
                        //   imagePath: 'lib/images/administrator.png',
                        // ),
                        ),
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
