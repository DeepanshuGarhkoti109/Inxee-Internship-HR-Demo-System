// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inxee_hr_application/panels_ADMIN/admin_panel.dart';
import 'package:inxee_hr_application/widgets/button_input.dart';
import 'package:pinput/pinput.dart';

class AdminPhoneOtpLogin extends StatefulWidget {
  const AdminPhoneOtpLogin({super.key});

  @override
  State<AdminPhoneOtpLogin> createState() => _AdminPhoneOtpLoginState();
}

class _AdminPhoneOtpLoginState extends State<AdminPhoneOtpLogin> {
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
                  SizedBox(
                    height: 50,
                  ),

                  //

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'One more step!',
                        style: GoogleFonts.abhayaLibre(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),

                  //
                  SizedBox(
                    height: 5,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '2-step verification',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      Text(
                        "An 4 digit code has been sent to dhdhjdfxhdghdjhdgxhxhdfc",
                        style: GoogleFonts.lato(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 35,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SizedBox(
                      width: double.infinity,
                      child: Pinput(
                        length: 4,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        defaultPinTheme: PinTheme(
                          height: 64,
                          width: 64,
                          textStyle: GoogleFonts.urbanist(
                              fontSize: 30,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black87.withOpacity(1),
                              ),
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle),
                        ),
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  //

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Resend Code',
                                style: GoogleFonts.actor(
                                  fontSize: 17,
                                ),
                              )),
                        ]),
                  ),

                  //
                  ButtonInput(
                    text: 'Login',
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminPanelHomeScreen(),
                          ),
                          (route) => false);
                    },
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
