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
  final TextEditingController _emailcontroller =
      TextEditingController(text: "admin@inxee.com");
  final TextEditingController _passwordcontroller =
      TextEditingController(text: "admin123");

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
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
        builder: (context) => const LoginPage(),
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
                  // Admin Badge Header
                  Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xff1e293b),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.admin_panel_settings_rounded,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'ADMIN CONSOLE',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: const Color(0xff0f172a),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Executive & HR Management Access',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xff64748b),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Email input
                  TextFieldInput(
                    prefix: const Icon(Icons.email_outlined),
                    hintText: 'admin@inxee.com',
                    labeltext: 'Administrator Email',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailcontroller,
                  ),

                  const SizedBox(height: 18),

                  // Password input
                  TextFieldInput(
                    prefix: const Icon(Icons.lock_outline),
                    labeltext: 'Admin Password',
                    textEditingController: _passwordcontroller,
                    hintText: 'Enter admin password',
                    textInputType: TextInputType.text,
                    isPass: true,
                  ),

                  const SizedBox(height: 8),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: navigateToForgotPassword,
                      child: Text(
                        'Forgot Password',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff3b82f6),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Next Button -> OTP Verification
                  ButtonInput(
                    text: 'CONTINUE TO 2FA OTP',
                    onTap: navigateToAdminOtpPage,
                  ),

                  const SizedBox(height: 28),

                  Row(
                    children: [
                      const Expanded(child: Divider(color: Color(0xffe2e8f0))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'OR',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff94a3b8),
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: Color(0xffe2e8f0))),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Switch to Employee Login
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xffcbd5e1)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: navigateToLoginPageEmployee,
                    icon: const Icon(Icons.person, color: Color(0xff0f172a)),
                    label: Text(
                      'Switch to Employee Login',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff0f172a),
                      ),
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
