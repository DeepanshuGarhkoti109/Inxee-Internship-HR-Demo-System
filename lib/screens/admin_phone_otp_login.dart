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
  final TextEditingController _pinController = TextEditingController(text: "1234");

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void loginToAdmin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminPanelHomeScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f172a),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 440),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xffeff6ff),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.security_rounded,
                        color: Color(0xff3b82f6),
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Two-Step Verification',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff0f172a),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'A 4-digit verification code has been sent to your registered admin device (+91 98*** ***10)',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xff64748b),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  Pinput(
                    length: 4,
                    controller: _pinController,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    defaultPinTheme: PinTheme(
                      height: 56,
                      width: 56,
                      textStyle: GoogleFonts.poppins(
                        fontSize: 22,
                        color: const Color(0xff0f172a),
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xfff8fafc),
                        border: Border.all(color: const Color(0xffcbd5e1)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      height: 56,
                      width: 56,
                      textStyle: GoogleFonts.poppins(
                        fontSize: 22,
                        color: const Color(0xff0f172a),
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xff3b82f6), width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('OTP resent to your device!')),
                        );
                      },
                      child: Text(
                        'Resend Code',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff3b82f6),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  ButtonInput(
                    text: 'VERIFY & ENTER ADMIN PANEL',
                    onTap: loginToAdmin,
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
