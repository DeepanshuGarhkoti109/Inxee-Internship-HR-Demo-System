// Primary Button Component
// Atomic Design System - Atoms Layer

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inxee_hr_application/design_system/design_tokens.dart';

enum ButtonVariant {
  primary,
  secondary,
  tertiary,
  danger,
  success,
  outline,
}

enum ButtonSize {
  small,
  medium,
  large,
}

class PrimaryButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final String label;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool fullWidth;
  final double? width;
  final double? height;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.leadingIcon,
    this.trailingIcon,
    this.fullWidth = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = _getColors(theme);
    final styles = _getStyles();

    final effectiveWidth = width ?? (fullWidth ? double.infinity : null);
    final effectiveHeight = height ?? styles.height;

    return SizedBox(
      width: effectiveWidth,
      height: effectiveHeight,
      child: ElevatedButton(
        onPressed: (isDisabled || isLoading) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.backgroundColor,
          foregroundColor: colors.foregroundColor,
          disabledBackgroundColor: colors.disabledBackgroundColor,
          disabledForegroundColor: colors.disabledForegroundColor,
          elevation: styles.elevation,
          shadowColor: styles.shadowColor,
          surfaceTintColor: colors.surfaceTintColor,
          shape: RoundedRectangleBorder(
            borderRadius: styles.borderRadius,
            side: colors.borderSide,
          ),
          padding: styles.padding,
          textStyle: styles.textStyle,
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(colors.foregroundColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leadingIcon != null) ...[
                    leadingIcon!,
                    SizedBox(width: styles.iconSpacing),
                  ],
                  Text(
                    label,
                    style: styles.textStyle?.copyWith(
                      color: colors.foregroundColor,
                    ),
                  ),
                  if (trailingIcon != null) ...[
                    SizedBox(width: styles.iconSpacing),
                    trailingIcon!,
                  ],
                ],
              ),
      ),
    );
  }

  _ButtonColors _getColors(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    switch (variant) {
      case ButtonVariant.primary:
        return _ButtonColors(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: AppColors.disabled,
          disabledForegroundColor: AppColors.textDisabled,
          surfaceTintColor: colorScheme.primary,
          borderSide: BorderSide.none,
        );
      case ButtonVariant.secondary:
        return _ButtonColors(
          backgroundColor: colorScheme.secondary,
          foregroundColor: colorScheme.onSecondary,
          disabledBackgroundColor: AppColors.disabled,
          disabledForegroundColor: AppColors.textDisabled,
          surfaceTintColor: colorScheme.secondary,
          borderSide: BorderSide.none,
        );
      case ButtonVariant.tertiary:
        return _ButtonColors(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          disabledBackgroundColor: AppColors.disabledContainer,
          disabledForegroundColor: AppColors.textDisabled,
          surfaceTintColor: colorScheme.surface,
          borderSide: BorderSide.none,
        );
      case ButtonVariant.danger:
        return _ButtonColors(
          backgroundColor: colorScheme.error,
          foregroundColor: colorScheme.onError,
          disabledBackgroundColor: AppColors.disabled,
          disabledForegroundColor: AppColors.textDisabled,
          surfaceTintColor: colorScheme.error,
          borderSide: BorderSide.none,
        );
      case ButtonVariant.success:
        return _ButtonColors(
          backgroundColor: AppColors.success,
          foregroundColor: AppColors.onSuccess,
          disabledBackgroundColor: AppColors.disabled,
          disabledForegroundColor: AppColors.textDisabled,
          surfaceTintColor: AppColors.success,
          borderSide: BorderSide.none,
        );
      case ButtonVariant.outline:
        return _ButtonColors(
          backgroundColor: Colors.transparent,
          foregroundColor: colorScheme.primary,
          disabledBackgroundColor: Colors.transparent,
          disabledForegroundColor: AppColors.disabled,
          surfaceTintColor: Colors.transparent,
          borderSide: BorderSide(
            color: isDisabled ? AppColors.disabled : colorScheme.primary,
            width: 1,
          ),
        );
    }
  }

  _ButtonStyles _getStyles() {
    switch (size) {
      case ButtonSize.small:
        return _ButtonStyles(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          borderRadius: AppBorderRadius.sm,
          elevation: 0,
          shadowColor: Colors.transparent,
          textStyle: AppTypography.labelLarge.copyWith(
            fontWeight: FontWeight.w500,
          ),
          iconSpacing: 6,
        );
      case ButtonSize.medium:
        return _ButtonStyles(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          borderRadius: AppBorderRadius.md,
          elevation: 0,
          shadowColor: Colors.transparent,
          textStyle: AppTypography.labelLarge.copyWith(
            fontWeight: FontWeight.w500,
          ),
          iconSpacing: 8,
        );
      case ButtonSize.large:
        return _ButtonStyles(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          borderRadius: AppBorderRadius.lg,
          elevation: 0,
          shadowColor: Colors.transparent,
          textStyle: AppTypography.titleSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
          iconSpacing: 10,
        );
    }
  }
}

class _ButtonColors {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color disabledBackgroundColor;
  final Color disabledForegroundColor;
  final Color surfaceTintColor;
  final BorderSide borderSide;

  const _ButtonColors({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.disabledBackgroundColor,
    required this.disabledForegroundColor,
    required this.surfaceTintColor,
    required this.borderSide,
  });
}

class _ButtonStyles {
  final double height;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final double elevation;
  final Color shadowColor;
  final TextStyle? textStyle;
  final double iconSpacing;

  const _ButtonStyles({
    required this.height,
    required this.padding,
    required this.borderRadius,
    required this.elevation,
    required this.shadowColor,
    this.textStyle,
    required this.iconSpacing,
  });
}

// ============ BUTTON VARIANTS ============
class SecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final ButtonSize size;
  final bool isLoading;
  final bool isDisabled;

  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: onPressed,
      label: label,
      variant: ButtonVariant.secondary,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
    );
  }
}

class TertiaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final ButtonSize size;
  final bool isLoading;
  final bool isDisabled;

  const TertiaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: onPressed,
      label: label,
      variant: ButtonVariant.tertiary,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
    );
  }
}

class DangerButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final ButtonSize size;
  final bool isLoading;
  final bool isDisabled;

  const DangerButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: onPressed,
      label: label,
      variant: ButtonVariant.danger,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
    );
  }
}

class OutlineButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final ButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final Color? outlineColor;
  final Widget? leadingIcon;
  final bool fullWidth;

  const OutlineButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.outlineColor,
    this.leadingIcon,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: onPressed,
      label: label,
      variant: ButtonVariant.outline,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      leadingIcon: leadingIcon,
      fullWidth: fullWidth,
    );
  }
}

// ============ ICON BUTTON VARIANTS ============
class IconButtonPrimary extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final ButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final Color? iconColor;

  const IconButtonPrimary({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final buttonSize = _buttonSizeFor(size);
    final iconSize = _iconSizeFor(size);

    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: ElevatedButton(
        onPressed: (isDisabled || isLoading) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          disabledBackgroundColor: AppColors.disabled,
          disabledForegroundColor: AppColors.textDisabled,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonSize / 2),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: iconSize,
                height: iconSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(colors.onPrimary),
                ),
              )
            : Icon(
                icon,
                size: iconSize,
                color: iconColor ?? colors.onPrimary,
              ),
      ),
    );
  }

  double _buttonSizeFor(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return 36.0;
      case ButtonSize.medium:
        return 44.0;
      case ButtonSize.large:
        return 52.0;
    }
  }

  double _iconSizeFor(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return 16.0;
      case ButtonSize.medium:
        return 20.0;
      case ButtonSize.large:
        return 24.0;
    }
  }
}