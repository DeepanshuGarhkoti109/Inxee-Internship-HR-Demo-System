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
  final TextEditingController _emailController =
      TextEditingController(text: "deepanshuGarhkoti@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "password123");

  void logInUser() {
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                  // Logo / Header Icon
                  Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xff0f172a),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.badge_rounded,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'EMPLOYEE LOGIN',
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
                      'Inxee HR Management System',
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
                    hintText: 'name@inxee.com',
                    labeltext: 'Employee Email',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailController,
                  ),

                  const SizedBox(height: 18),

                  // Password input
                  TextFieldInput(
                    prefix: const Icon(Icons.lock_outline),
                    labeltext: 'Password',
                    textEditingController: _passwordController,
                    hintText: 'Enter your password',
                    textInputType: TextInputType.text,
                    isPass: true,
                  ),

                  const SizedBox(height: 8),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: navigateToForgotPassword,
                      child: Text(
                        'Forgot Password / OTP Login',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff3b82f6),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Login Button
                  ButtonInput(
                    text: 'LOGIN AS EMPLOYEE',
                    onTap: logInUser,
                  ),

                  const SizedBox(height: 28),

                  // Divider
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

                  // Switch to Admin Login
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xffcbd5e1)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: navigateToLoginPageAdmin,
                    icon: const Icon(Icons.admin_panel_settings, color: Color(0xff0f172a)),
                    label: Text(
                      'Switch to Admin Login',
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
