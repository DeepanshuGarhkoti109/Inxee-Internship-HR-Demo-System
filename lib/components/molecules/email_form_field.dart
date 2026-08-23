// Email Form Field Component
// Atomic Design System - Molecules Layer

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inxee_hr_application/design_system/design_tokens.dart';
import 'package:inxee_hr_application/providers/auth_provider.dart';

class EmailFormField extends ConsumerWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final bool enabled;
  final bool autoFocus;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  const EmailFormField({
    super.key,
    required this.controller,
    this.labelText = 'Email',
    this.hintText = 'name@company.com',
    this.enabled = true,
    this.autoFocus = false,
    this.textInputAction,
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final authState = ref.watch(authNotifierProvider);
    
    String? errorText;
    if (authState.hasError && authState.error!.contains('email')) {
      errorText = authState.error;
    }

    return TextFormField(
      controller: controller,
      enabled: enabled,
      autofocus: autoFocus,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction ?? TextInputAction.next,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: AppTypography.bodyMedium.copyWith(
        color: enabled 
            ? colorScheme.onSurface
            : colorScheme.onSurface.withOpacity(0.5),
      ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(
          Icons.email_outlined,
          color: enabled
              ? colorScheme.onSurface.withOpacity(0.6)
              : colorScheme.onSurface.withOpacity(0.3),
        ),
        suffixIcon: controller.text.isNotEmpty && enabled
            ? IconButton(
                onPressed: () => controller.clear(),
                icon: Icon(
                  Icons.clear,
                  color: colorScheme.onSurface.withOpacity(0.4),
                  size: 20,
                ),
                splashRadius: 16,
              )
            : null,
        errorText: errorText,
        labelStyle: AppTypography.labelLarge.copyWith(
          color: enabled
              ? colorScheme.onSurface.withOpacity(0.8)
              : colorScheme.onSurface.withOpacity(0.4),
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        errorStyle: AppTypography.bodySmall.copyWith(
          color: colorScheme.error,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        filled: true,
        fillColor: enabled
            ? colorScheme.surfaceVariant.withOpacity(0.4)
            : colorScheme.surfaceVariant.withOpacity(0.2),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: AppBorderRadius.lg,
          borderSide: BorderSide(
            color: colorScheme.outline.withOpacity(0.3),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.lg,
          borderSide: BorderSide(
            color: colorScheme.outline.withOpacity(0.3),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.lg,
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.lg,
          borderSide: BorderSide(
            color: colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.lg,
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.lg,
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        return EmailValidator.validate(value);
      },
      onChanged: (value) {
        // Clear any previous email-related errors
        if (authState.hasError && authState.error!.contains('email')) {
          ref.read(authNotifierProvider.notifier).clearError();
        }
        onChanged?.call(value);
      },
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}