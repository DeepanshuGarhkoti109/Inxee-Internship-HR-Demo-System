// Inxee HR Management System - Design Tokens
// Senior Frontend Architecture v1.0

import 'package:flutter/material.dart';

/// Complete design token system following Material Design 3 specifications
/// All colors, typography, spacing, and elevation tokens centralized here

// ============ COLOR SYSTEM ============
class AppColors {
  // Primary Colors (Slate)
  static const Color primary = Color(0xff0f172a);
  static const Color primaryDark = Color(0xff020617);
  static const Color primaryLight = Color(0xff1e293b);
  static const Color primaryContainer = Color(0xff334155);
  static const Color onPrimary = Colors.white;
  static const Color onPrimaryContainer = Color(0xffe2e8f0);

  // Secondary Colors (Blue)
  static const Color secondary = Color(0xff3b82f6);
  static const Color secondaryDark = Color(0xff1d4ed8);
  static const Color secondaryLight = Color(0xff60a5fa);
  static const Color secondaryContainer = Color(0xffdbeafe);
  static const Color onSecondary = Colors.white;
  static const Color onSecondaryContainer = Color(0xff1e40af);

  // Semantic Colors
  static const Color success = Color(0xff10b981);
  static const Color successDark = Color(0xff047857);
  static const Color successLight = Color(0xff34d399);
  static const Color successContainer = Color(0xffd1fae5);
  static const Color onSuccess = Colors.white;

  static const Color warning = Color(0xfff59e0b);
  static const Color warningDark = Color(0xffd97706);
  static const Color warningLight = Color(0xfffbbf24);
  static const Color warningContainer = Color(0xfffef3c7);
  static const Color onWarning = Color(0xff78350f);

  static const Color error = Color(0xffef4444);
  static const Color errorDark = Color(0xffdc2626);
  static const Color errorLight = Color(0xfff87171);
  static const Color errorContainer = Color(0xfffee2e2);
  static const Color onError = Colors.white;

  static const Color info = Color(0xff0ea5e9);
  static const Color infoDark = Color(0xff0284c7);
  static const Color infoLight = Color(0xff38bdf8);
  static const Color infoContainer = Color(0xffe0f2fe);
  static const Color onInfo = Colors.white;

  // Neutral Colors
  static const Color surface = Color(0xfff8fafc);
  static const Color surfaceDark = Color(0xff0f172a);
  static const Color surfaceLight = Color(0xffffffff);
  
  static const Color background = Color(0xfff1f5f9);
  static const Color backgroundDark = Color(0xff1e293b);
  
  static const Color outline = Color(0xffcbd5e1);
  static const Color outlineDark = Color(0xff475569);
  static const Color outlineLight = Color(0xffe2e8f0);
  
  static const Color disabled = Color(0xff94a3b8);
  static const Color disabledContainer = Color(0xfff1f5f9);
  
  // Text Colors
  static const Color textPrimary = Color(0xff0f172a);
  static const Color textSecondary = Color(0xff475569);
  static const Color textTertiary = Color(0xff64748b);
  static const Color textDisabled = Color(0xff94a3b8);
  
  static const Color textPrimaryDark = Color(0xfff1f5f9);
  static const Color textSecondaryDark = Color(0xffcbd5e1);
  static const Color textTertiaryDark = Color(0xff94a3b8);
  
  // Interactive States
  static const Color hover = Color(0x0a000000); // 4% opacity black
  static const Color focus = Color(0x1a3b82f6); // 10% opacity secondary
  static const Color pressed = Color(0x14000000); // 8% opacity black
  static const Color dragged = Color(0x0f000000); // 6% opacity black
}

// ============ TYPOGRAPHY SYSTEM ============
class AppTypography {
  // Display
  static final TextStyle displayLarge = TextStyle(
    fontSize: 57,
    height: 64 / 57,
    letterSpacing: -0.25,
    fontWeight: FontWeight.w700,
  );
  
  static final TextStyle displayMedium = TextStyle(
    fontSize: 45,
    height: 52 / 45,
    fontWeight: FontWeight.w600,
  );
  
  static final TextStyle displaySmall = TextStyle(
    fontSize: 36,
    height: 44 / 36,
    fontWeight: FontWeight.w600,
  );
  
  // Headline
  static final TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w600,
  );
  
  static final TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    height: 36 / 28,
    fontWeight: FontWeight.w500,
  );
  
  static final TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w500,
  );
  
  // Title
  static final TextStyle titleLarge = TextStyle(
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w500,
  );
  
  static final TextStyle titleMedium = TextStyle(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );
  
  static final TextStyle titleSmall = TextStyle(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );
  
  // Body
  static final TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    height: 24 / 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );
  
  static final TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    height: 20 / 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );
  
  static final TextStyle bodySmall = TextStyle(
    fontSize: 14,
    height: 16 / 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );
  
  // Label
  static final TextStyle labelLarge = TextStyle(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );
  
  static final TextStyle labelMedium = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
  
  static final TextStyle labelSmall = TextStyle(
    fontSize: 11,
    height: 16 / 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
}

// ============ SPACING SYSTEM ============
class AppSpacing {
  // Base unit: 4px (0.25rem)
  static const double unit = 4.0;
  
  // Spacing scale (4px increments)
  static const double xs = unit * 1;      // 4px
  static const double sm = unit * 2;      // 8px
  static const double md = unit * 3;      // 12px
  static const double lg = unit * 4;      // 16px
  static const double xl = unit * 6;      // 24px
  static const double xxl = unit * 8;     // 32px
  static const double xxxl = unit * 12;   // 48px
  static const double huge = unit * 16;   // 64px
  
  // Padding scales
  static const EdgeInsetsGeometry paddingXs = EdgeInsets.all(xs);
  static const EdgeInsetsGeometry paddingSm = EdgeInsets.all(sm);
  static const EdgeInsetsGeometry paddingMd = EdgeInsets.all(md);
  static const EdgeInsetsGeometry paddingLg = EdgeInsets.all(lg);
  static const EdgeInsetsGeometry paddingXl = EdgeInsets.all(xl);
  
  // Margin scales
  static const EdgeInsetsGeometry marginXs = EdgeInsets.all(xs);
  static const EdgeInsetsGeometry marginSm = EdgeInsets.all(sm);
  static const EdgeInsetsGeometry marginMd = EdgeInsets.all(md);
  static const EdgeInsetsGeometry marginLg = EdgeInsets.all(lg);
  static const EdgeInsetsGeometry marginXl = EdgeInsets.all(xl);
  
  // Symmetric padding
  static EdgeInsetsGeometry symmetric({double? horizontal, double? vertical}) {
    return EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    );
  }
}

// ============ BORDER RADIUS ============
class AppBorderRadius {
  static const BorderRadius none = BorderRadius.zero;
  static const BorderRadius xs = BorderRadius.all(Radius.circular(4));
  static const BorderRadius sm = BorderRadius.all(Radius.circular(8));
  static const BorderRadius md = BorderRadius.all(Radius.circular(12));
  static const BorderRadius lg = BorderRadius.all(Radius.circular(16));
  static const BorderRadius xl = BorderRadius.all(Radius.circular(24));
  static const BorderRadius full = BorderRadius.all(Radius.circular(999));
  
  // Custom radius
  static BorderRadius only({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft),
      topRight: Radius.circular(topRight),
      bottomLeft: Radius.circular(bottomLeft),
      bottomRight: Radius.circular(bottomRight),
    );
  }
}

// ============ ELEVATION ============
class AppElevation {
  // Material Design 3 elevation levels
  static const double level0 = 0;
  static const double level1 = 1;
  static const double level2 = 3;
  static const double level3 = 6;
  static const double level4 = 8;
  static const double level5 = 12;
  
  // Shadow configurations
  static BoxShadow get shadow1 => BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 3,
    offset: const Offset(0, 1),
  );
  
  static BoxShadow get shadow2 => BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 6,
    offset: const Offset(0, 2),
  );
  
  static BoxShadow get shadow3 => BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 12,
    offset: const Offset(0, 4),
  );
  
  static BoxShadow get shadow4 => BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 16,
    offset: const Offset(0, 6),
  );
  
  static BoxShadow get shadow5 => BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 24,
    offset: const Offset(0, 8),
  );
}

// ============ DURATIONS ============
class AppDurations {
  static const Duration instant = Duration(milliseconds: 0);
  static const Duration fastest = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration slower = Duration(milliseconds: 700);
  
  // Animation curves
  static const Curve standard = Curves.easeInOut;
  static const Curve emphasize = Curves.easeOutBack;
  static const Curve decelerate = Curves.decelerate;
  static const Curve accelerate = Curves.easeIn;
}

// ============ BREAKPOINTS ============
class AppBreakpoints {
  // Material Design breakpoints
  static const double mobile = 0;
  static const double tablet = 600;
  static const double desktop = 900;
  static const double largeDesktop = 1200;
  
  // Custom breakpoints
  static const double xs = 0;
  static const double sm = 600;
  static const double md = 900;
  static const double lg = 1200;
  static const double xl = 1536;
  
  // Helper methods
  static bool isMobile(double width) => width < sm;
  static bool isTablet(double width) => width >= sm && width < md;
  static bool isDesktop(double width) => width >= md && width < lg;
  static bool isLargeDesktop(double width) => width >= lg;
}

// ============ THEME EXTENSION ============
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color hover;
  final Color focus;
  final Color pressed;
  final Color dragged;
  
  const AppThemeExtension({
    required this.hover,
    required this.focus,
    required this.pressed,
    required this.dragged,
  });
  
  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? hover,
    Color? focus,
    Color? pressed,
    Color? dragged,
  }) {
    return AppThemeExtension(
      hover: hover ?? this.hover,
      focus: focus ?? this.focus,
      pressed: pressed ?? this.pressed,
      dragged: dragged ?? this.dragged,
    );
  }
  
  @override
  ThemeExtension<AppThemeExtension> lerp(
    ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }
    
    return AppThemeExtension(
      hover: Color.lerp(hover, other.hover, t) ?? hover,
      focus: Color.lerp(focus, other.focus, t) ?? focus,
      pressed: Color.lerp(pressed, other.pressed, t) ?? pressed,
      dragged: Color.lerp(dragged, other.dragged, t) ?? dragged,
    );
  }
}

// ============ THEME DATA ============
class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      primaryContainer: AppColors.primaryContainer,
      secondary: AppColors.secondary,
      secondaryContainer: AppColors.secondaryContainer,
      surface: AppColors.surface,
      background: AppColors.background,
      error: AppColors.error,
      errorContainer: AppColors.errorContainer,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onSecondary,
      onSurface: AppColors.textPrimary,
      onBackground: AppColors.textPrimary,
      onError: AppColors.onError,
      outline: AppColors.outline,
    ),
    extensions: const [
      AppThemeExtension(
        hover: AppColors.hover,
        focus: AppColors.focus,
        pressed: AppColors.pressed,
        dragged: AppColors.dragged,
      ),
    ],
  );
  
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryLight,
      primaryContainer: AppColors.primaryContainer,
      secondary: AppColors.secondaryLight,
      secondaryContainer: AppColors.secondaryContainer,
      surface: AppColors.surfaceDark,
      background: AppColors.backgroundDark,
      error: AppColors.errorLight,
      errorContainer: AppColors.errorContainer,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onSecondary,
      onSurface: AppColors.textPrimaryDark,
      onBackground: AppColors.textPrimaryDark,
      onError: AppColors.onError,
      outline: AppColors.outlineDark,
    ),
    extensions: const [
      AppThemeExtension(
        hover: AppColors.hover,
        focus: AppColors.focus,
        pressed: AppColors.pressed,
        dragged: AppColors.dragged,
      ),
    ],
  );
}

// ============ UTILITIES ============
class AppDesignUtils {
  // Border styling
  static Border border({Color? color, double width = 1}) {
    return Border.all(
      color: color ?? AppColors.outline,
      width: width,
    );
  }
  
  // Rounded container decoration
  static BoxDecoration roundedContainer({
    Color? color,
    BorderRadius? borderRadius,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: color ?? AppColors.surface,
      borderRadius: borderRadius ?? AppBorderRadius.md,
      border: border,
      boxShadow: boxShadow,
    );
  }
  
  // Elevation container
  static BoxDecoration elevatedContainer({
    Color? color,
    BorderRadius? borderRadius,
    double elevation = AppElevation.level2,
  }) {
    return BoxDecoration(
      color: color ?? AppColors.surface,
      borderRadius: borderRadius ?? AppBorderRadius.md,
      boxShadow: [AppElevation.shadow2],
    );
  }
  
  // Interactive states
  static Color getInteractiveColor({
    required BuildContext context,
    bool isHovered = false,
    bool isFocused = false,
    bool isPressed = false,
  }) {
    final theme = Theme.of(context).extension<AppThemeExtension>();
    
    if (isPressed && theme != null) return theme.pressed;
    if (isHovered && theme != null) return theme.hover;
    if (isFocused && theme != null) return theme.focus;
    
    return Colors.transparent;
  }
}