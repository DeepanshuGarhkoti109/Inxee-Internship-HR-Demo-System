// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inxee_hr_application/screens/GetEmailOtp.dart';
import 'package:inxee_hr_application/widgets/button_input.dart';
import 'package:inxee_hr_application/widgets/text_field_input.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _emailController = TextEditingController();

  void navigateGetOtpScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => GetEmailOtp(),
        ),
        (route) => false);
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Forgot \nPassword?",
                      style: GoogleFonts.robotoMono(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),

                  //
                  SizedBox(
                    height: 15,
                  ),

                  Text(
                    "Dont't worry! It happens. Please enter the address associated wirh your account.",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  TextFieldInput(
                    prefix: Icon(Icons.email),
                    hintText: 'abc@gmail.com',
                    labeltext: 'Email',
                    textEditingController: _emailController,
                    textInputType: TextInputType.emailAddress,
                  ),

                  //

                  SizedBox(
                    height: 25,
                  ),

                  ButtonInput(
                    text: 'GET OTP',
                    onTap: navigateGetOtpScreen,
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
