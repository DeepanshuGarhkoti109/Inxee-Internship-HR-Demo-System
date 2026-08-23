// Authentication Provider with Riverpod
// Senior Frontend Architecture - State Management Layer

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ============ STATE MODELS ============
enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final bool isAdmin;
  final DateTime? createdAt;

  const UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.isAdmin = false,
    this.createdAt,
  });

  factory UserModel.fromFirebaseUser(User user, {bool isAdmin = false}) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      isAdmin: isAdmin,
      createdAt: user.metadata.creationTime,
    );
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? isAdmin,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      isAdmin: isAdmin ?? this.isAdmin,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AuthState {
  final AuthStatus status;
  final UserModel? user;
  final String? error;
  final bool isLoading;
  final bool isInitialized;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.error,
    this.isLoading = false,
    this.isInitialized = false,
  });

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
  bool get hasError => error != null;

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    String? error,
    bool? isLoading,
    bool? isInitialized,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  @override
  String toString() {
    return 'AuthState(status: $status, user: $user, error: $error, isLoading: $isLoading)';
  }
}

// ============ NOTIFIER ============
class AuthNotifier extends StateNotifier<AuthState> {
  final FirebaseAuth? _auth;

  AuthNotifier(this._auth, Ref ref) : super(const AuthState()) {
    _init();
  }

  bool get _isDemoMode => _auth == null;

  Future<void> _init() async {
    if (_isDemoMode) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isInitialized: true,
      );
      return;
    }

    try {
      _auth!.authStateChanges().listen((User? user) {
        if (user != null) {
          final isAdmin = user.email?.contains('admin') == true ||
              user.email?.contains('@inxee.com') == true;

          final userModel = UserModel.fromFirebaseUser(user, isAdmin: isAdmin);

          state = state.copyWith(
            status: AuthStatus.authenticated,
            user: userModel,
            error: null,
            isInitialized: true,
          );
        } else {
          state = state.copyWith(
            status: AuthStatus.unauthenticated,
            user: null,
            error: null,
            isInitialized: true,
          );
        }
      });
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isInitialized: true,
      );
    }
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
    bool isAdmin = false,
  }) async {
    if (_isDemoMode) {
      await loginWithDemoCredentials(
        email: email,
        password: password,
        isAdmin: isAdmin,
      );
      return;
    }

    try {
      state = state.copyWith(isLoading: true, error: null);

      final userCredential = await _auth!.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      
      final user = userCredential.user;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user found for that email.',
        );
      }
      
      // Store additional user info if needed
      // await _storeUserInDatabase(user, isAdmin: isAdmin);
      
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: UserModel.fromFirebaseUser(user, isAdmin: isAdmin),
        isLoading: false,
        error: null,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No account found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many attempts. Please try again later.';
          break;
        default:
          errorMessage = 'Authentication failed. Please try again.';
      }
      
      state = state.copyWith(
        status: AuthStatus.error,
        error: errorMessage,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: 'An unexpected error occurred. Please try again.',
        isLoading: false,
      );
    }
  }

  Future<void> loginWithDemoCredentials({
    required String email,
    required String password,
    bool isAdmin = false,
  }) async {
    // For demo mode without Firebase
    await Future.delayed(const Duration(milliseconds: 500));
    
    final userModel = UserModel(
      uid: 'demo_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      displayName: 'Demo User',
      photoUrl: 'https://ui-avatars.com/api/?name=Demo+User',
      isAdmin: isAdmin,
      createdAt: DateTime.now(),
    );
    
    state = state.copyWith(
      status: AuthStatus.authenticated,
      user: userModel,
      isLoading: false,
      error: null,
    );
  }

  Future<void> logout() async {
    try {
      state = state.copyWith(isLoading: true);

      if (!_isDemoMode) {
        await _auth!.signOut();
      }

      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        user: null,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: 'Failed to logout. Please try again.',
        isLoading: false,
      );
    }
  }

  Future<void> resetPassword(String email) async {
    if (_isDemoMode) {
      state = state.copyWith(
        isLoading: false,
        error: null,
      );
      return;
    }

    try {
      state = state.copyWith(isLoading: true, error: null);
      await _auth!.sendPasswordResetEmail(email: email.trim());
      
      state = state.copyWith(
        isLoading: false,
        error: null,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No account found with this email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        default:
          errorMessage = 'Failed to send reset email. Please try again.';
      }
      
      state = state.copyWith(
        error: errorMessage,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'An unexpected error occurred. Please try again.',
        isLoading: false,
      );
    }
  }

  Future<void> updateProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    if (_isDemoMode) {
      state = state.copyWith(
        user: state.user?.copyWith(
          displayName: displayName ?? state.user?.displayName,
          photoUrl: photoUrl ?? state.user?.photoUrl,
        ),
      );
      return;
    }

    try {
      final currentUser = _auth!.currentUser;
      if (currentUser == null) return;

      state = state.copyWith(isLoading: true);

      await currentUser.updateDisplayName(displayName);
      if (photoUrl != null) {
        await currentUser.updatePhotoURL(photoUrl);
      }
      
      // Update local state
      state = state.copyWith(
        user: state.user?.copyWith(
          displayName: displayName ?? state.user?.displayName,
          photoUrl: photoUrl ?? state.user?.photoUrl,
        ),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to update profile. Please try again.',
        isLoading: false,
      );
    }
  }

  void clearError() {
    if (state.hasError) {
      state = state.copyWith(error: null);
    }
  }
}

// ============ PROVIDERS ============
final firebaseAuthProvider = Provider<FirebaseAuth?>((ref) {
  if (Firebase.apps.isEmpty) {
    return null;
  }
  return FirebaseAuth.instance;
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    final auth = ref.watch(firebaseAuthProvider);
    return AuthNotifier(auth, ref);
  },
);

// Selectors for optimized rebuilds
final authStatusProvider = Provider<AuthStatus>((ref) {
  return ref.watch(authNotifierProvider.select((state) => state.status));
});

final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(authNotifierProvider.select((state) => state.user));
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider.select((state) => state.isAuthenticated));
});

final isAdminProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.isAdmin ?? false;
});

final authErrorProvider = Provider<String?>((ref) {
  return ref.watch(authNotifierProvider.select((state) => state.error));
});

final authIsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider.select((state) => state.isLoading));
});

// ============ VALIDATION ============
class EmailValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    
    return null;
  }
}

class PasswordValidator {
  static String? validate(String? value, {bool strict = false}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (!strict) {
      return null;
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    return null;
  }
}

// ============ AUTH GUARD ============
class AuthGuard {
  static bool requireAuth(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    
    if (!isAuthenticated) {
      // Navigate to login
      // Navigator.pushReplacementNamed(context, '/login');
      return false;
    }
    
    return true;
  }
  
  static bool requireAdmin(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    final isAdmin = ref.watch(isAdminProvider);
    
    if (!isAuthenticated) {
      // Navigate to login
      // Navigator.pushReplacementNamed(context, '/login');
      return false;
    }
    
    if (!isAdmin) {
      // Navigate to unauthorized or employee dashboard
      // Navigator.pushReplacementNamed(context, '/employee');
      return false;
    }
    
    return true;
  }
}

// ============ UTILITIES ============
extension AuthStateExtensions on AuthState {
  bool get canShowLoading => isLoading && !isInitialized;
  bool get canShowError => hasError && isInitialized;
  bool get canShowContent => isInitialized && !isLoading && !hasError;
}