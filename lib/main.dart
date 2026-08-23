// Inxee HR Management System - Modern Architecture
// Senior Frontend Engineering Implementation

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:inxee_hr_application/design_system/design_tokens.dart';
import 'package:inxee_hr_application/screens/modern_login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization skipped (offline/demo mode): $e');
  }

  runApp(
    const ProviderScope(
      child: InxeeHRApp(),
    ),
  );
}

class InxeeHRApp extends ConsumerWidget {
  const InxeeHRApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inxee HR Management System',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const ModernLoginPage(isAdminLogin: false),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: mediaQuery.textScaler.clamp(
              minScaleFactor: 0.8,
              maxScaleFactor: 1.2,
            ),
          ),
          child: child!,
        );
      },
      onGenerateTitle: (context) => 'Inxee HR System',
      supportedLocales: const [
        Locale('en', 'US'),
      ],
    );
  }
}
