// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inxee_hr_application/screens/admin_phone_otp_login.dart';
import 'package:inxee_hr_application/screens/login_page_employee.dart';
import 'package:inxee_hr_application/screens/otppage.dart';
import 'package:inxee_hr_application/widgets/button_input.dart';

import 'package:inxee_hr_application/widgets/text_field_input.dart';

class LoginPageAdmin extends StatefulWidget {
  const LoginPageAdmin({super.key});

  @override
  State<LoginPageAdmin> createState() => _LoginPageAdminState();
}

class _LoginPageAdminState extends State<LoginPageAdmin> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void navigateToAdminOtpPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminPhoneOtpLogin(),
      ),
      (route) => false,
    );
  }

  void navigateToLoginPageEmployee() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
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

                  //logo
                  Image.asset(
                    'lib/images/unnamed.png',
                  ),

                  const SizedBox(height: 25),

                  //ADMIN LOGIN
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'ADMIN LOGIN',
                        style: GoogleFonts.acme(
                          textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    )),
                  ),

                  const SizedBox(height: 15),

                  //email textfield
                  TextFieldInput(
                      prefix: Icon(Icons.email),
                      textEditingController: _emailcontroller,
                      hintText: 'abc@gmail.com',
                      labeltext: 'Email',
                      textInputType: TextInputType.emailAddress),

                  const SizedBox(height: 25),

                  //password textfield
                  TextFieldInput(
                    prefix: Icon(Icons.password),
                    textEditingController: _passwordcontroller,
                    hintText: '1@345ddshkDejGI^',
                    labeltext: 'Password',
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

                  //NEXT BUTTON

                  ButtonInput(
                    text: 'NEXT',
                    onTap: navigateToAdminOtpPage,
                  ),

                  const SizedBox(height: 50),

                  //DIVIDER
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

                  const SizedBox(height: 45),

                  //employee login

                  Container(
                    width: 50,
                    height: 50,
                    child: GestureDetector(
                        onTap: navigateToLoginPageEmployee,
                        child: Image.asset('lib/images/912318.png')
                        // SquareTile(
                        //   height: 45,
                        //   imagePath: 'lib/images/912318.png',
                        // ),
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
