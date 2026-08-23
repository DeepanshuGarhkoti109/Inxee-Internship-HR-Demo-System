// Modern Login Page
// Senior Frontend Architecture - Refactored Implementation

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inxee_hr_application/components/atoms/primary_button.dart';
import 'package:inxee_hr_application/components/molecules/email_form_field.dart';
import 'package:inxee_hr_application/components/molecules/password_form_field.dart';
import 'package:inxee_hr_application/design_system/design_tokens.dart';
import 'package:inxee_hr_application/employee_panels/employee_panel.dart';
import 'package:inxee_hr_application/panels_ADMIN/admin_panel.dart';
import 'package:inxee_hr_application/providers/auth_provider.dart';
import 'package:inxee_hr_application/screens/otppage.dart';

class ModernLoginPage extends ConsumerStatefulWidget {
  final bool isAdminLogin;
  
  const ModernLoginPage({
    super.key,
    this.isAdminLogin = false,
  });

  @override
  ConsumerState<ModernLoginPage> createState() => _ModernLoginPageState();
}

class _ModernLoginPageState extends ConsumerState<ModernLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    // Demo credentials for testing
    if (!widget.isAdminLogin) {
      _emailController.text = 'employee@inxee.com';
      _passwordController.text = 'Password123';
    } else {
      _emailController.text = 'admin@inxee.com';
      _passwordController.text = 'AdminPassword123';
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authNotifier = ref.read(authNotifierProvider.notifier);
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    await authNotifier.loginWithEmailAndPassword(
      email: email,
      password: password,
      isAdmin: widget.isAdminLogin,
    );

    final authState = ref.read(authNotifierProvider);
    if (authState.isAuthenticated && mounted) {
      _navigateToDashboard();
    }
  }

  void _navigateToDashboard() {
    final user = ref.read(currentUserProvider);
    final destination = user?.isAdmin == true
        ? const AdminPanelHomeScreen()
        : const EmployeePanelHomeScreen();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => destination),
      (route) => false,
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OtpPage()),
    );
  }

  void _navigateToSwitchLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ModernLoginPage(
          isAdminLogin: !widget.isAdminLogin,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final title = widget.isAdminLogin ? 'Admin Login' : 'Employee Login';
    final subtitle = widget.isAdminLogin
        ? 'Inxee HR Management System - Admin Portal'
        : 'Inxee HR Management System - Employee Portal';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primary,
              colorScheme.primaryContainer,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: AppSpacing.paddingXl,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Container(
                  padding: AppSpacing.paddingXl,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: AppBorderRadius.xl,
                    boxShadow: [
                      AppElevation.shadow4,
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo & Header
                      _buildHeader(theme, title, subtitle),
                      
                      const SizedBox(height: AppSpacing.xxl),
                      
                      // Login Form
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            EmailFormField(
                              controller: _emailController,
                              enabled: !authState.isLoading,
                            ),
                            
                            const SizedBox(height: AppSpacing.lg),
                            
                            PasswordFormField(
                              controller: _passwordController,
                              isPasswordVisible: _isPasswordVisible,
                              onToggleVisibility: _togglePasswordVisibility,
                              enabled: !authState.isLoading,
                            ),
                            
                            const SizedBox(height: AppSpacing.md),
                            
                            // Remember Me & Forgot Password
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: authState.isLoading
                                      ? null
                                      : (value) {
                                          setState(() {
                                            _rememberMe = value ?? false;
                                          });
                                        },
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: AppBorderRadius.sm,
                                  ),
                                  fillColor: MaterialStateProperty.resolveWith(
                                    (states) {
                                      if (states.contains(MaterialState.selected)) {
                                        return colorScheme.primary;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    'Remember me',
                                    style: AppTypography.bodySmall.copyWith(
                                      color: colorScheme.onSurface.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: TextButton(
                                    onPressed: authState.isLoading
                                        ? null
                                        : _navigateToForgotPassword,
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      'Forgot Password?',
                                      style: AppTypography.bodySmall.copyWith(
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: AppSpacing.xl),
                            
                            // Error Message
                            if (authState.hasError)
                              Container(
                                padding: AppSpacing.paddingMd,
                                decoration: BoxDecoration(
                                  color: colorScheme.errorContainer,
                                  borderRadius: AppBorderRadius.md,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: colorScheme.error,
                                      size: 20,
                                    ),
                                    const SizedBox(width: AppSpacing.md),
                                    Expanded(
                                      child: Text(
                                        authState.error!,
                                        style: AppTypography.bodySmall.copyWith(
                                          color: colorScheme.error,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        ref.read(authNotifierProvider.notifier)
                                            .clearError();
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: colorScheme.error,
                                        size: 20,
                                      ),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                  ],
                                ),
                              ),
                            
                            if (authState.hasError)
                              const SizedBox(height: AppSpacing.lg),
                            
                            // Login Button
                            PrimaryButton(
                              onPressed: authState.isLoading ? null : _handleLogin,
                              label: 'Sign In',
                              variant: ButtonVariant.primary,
                              size: ButtonSize.large,
                              isLoading: authState.isLoading,
                              fullWidth: true,
                              leadingIcon: authState.isLoading
                                  ? null
                                  : Icon(
                                      Icons.login_rounded,
                                      size: 20,
                                      color: colorScheme.onPrimary,
                                    ),
                            ),
                            
                            const SizedBox(height: AppSpacing.xl),
                            
                            // Divider
                            _buildDivider(colorScheme),
                            
                            const SizedBox(height: AppSpacing.xl),
                            
                            // Switch Login Type
                            OutlineButton(
                              onPressed: authState.isLoading ? null : _navigateToSwitchLogin,
                              label: widget.isAdminLogin
                                  ? 'Switch to Employee Login'
                                  : 'Switch to Admin Login',
                              size: ButtonSize.medium,
                              isDisabled: authState.isLoading,
                              fullWidth: true,
                              leadingIcon: Icon(
                                widget.isAdminLogin
                                    ? Icons.person_outline
                                    : Icons.admin_panel_settings_outlined,
                                size: 18,
                                color: colorScheme.primary,
                              ),
                            ),
                            
                            const SizedBox(height: AppSpacing.xl),
                            
                            // Demo Mode Note
                            Container(
                              padding: AppSpacing.paddingMd,
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceVariant.withOpacity(0.3),
                                borderRadius: AppBorderRadius.md,
                                border: Border.all(
                                  color: colorScheme.outline.withOpacity(0.2),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        size: 16,
                                        color: colorScheme.primary,
                                      ),
                                      const SizedBox(width: AppSpacing.sm),
                                      Text(
                                        'Demo Mode',
                                        style: AppTypography.labelMedium.copyWith(
                                          color: colorScheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    'Credentials are pre-filled for testing. '
                                    'In production, this would connect to your authentication service.',
                                    style: AppTypography.bodySmall.copyWith(
                                      color: colorScheme.onSurface.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, String title, String subtitle) {
    final colorScheme = theme.colorScheme;
    
    return Column(
      children: [
        // Logo/Icon
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: AppBorderRadius.lg,
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            widget.isAdminLogin
                ? Icons.admin_panel_settings_rounded
                : Icons.badge_rounded,
            color: colorScheme.onPrimary,
            size: 36,
          ),
        ),
        
        const SizedBox(height: AppSpacing.lg),
        
        // Title
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: AppSpacing.xs),
        
        // Subtitle
        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: colorScheme.onSurface.withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDivider(ColorScheme colorScheme) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: colorScheme.outline.withOpacity(0.3),
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Text(
            'OR',
            style: AppTypography.labelSmall.copyWith(
              color: colorScheme.onSurface.withOpacity(0.4),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: colorScheme.outline.withOpacity(0.3),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}