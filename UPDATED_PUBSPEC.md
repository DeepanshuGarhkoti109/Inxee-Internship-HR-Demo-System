# Updated Dependencies for Senior Frontend Architecture

Add these dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Core Dependencies
  cupertino_icons: ^1.0.6
  google_fonts: ^6.1.0
  
  # State Management (Riverpod)
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.4.0
  
  # Firebase (Optional - for production)
  firebase_core: ^2.27.0
  firebase_auth: ^4.17.8
  firebase_storage: ^11.6.9
  
  # UI Components
  cached_network_image: ^3.3.0
  shimmer: ^3.0.0
  intl: ^0.19.0
  
  # Date/Time
  syncfusion_flutter_datepicker: ^24.1.50
  
  # Icons
  font_awesome_flutter: ^10.7.0
  
  # Storage
  shared_preferences: ^2.2.2
  sqflite: ^2.3.2
  path: ^1.9.0
  path_provider: ^2.1.2
  
  # Media
  image_picker: ^1.1.2
  image_picker_platform_interface: ^2.10.0
  image_picker_for_web: ^3.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  
  # Code Generation
  build_runner: ^2.4.8
  riverpod_generator: ^2.4.8
  
  # Linting
  flutter_lints: ^3.0.1
  
  # Testing
  golden_toolkit: ^3.2.0
  mocktail: ^1.0.0
```

## Installation Steps:

1. **Update pubspec.yaml:**
```bash
# Backup your current pubspec.yaml
cp pubspec.yaml pubspec.yaml.backup

# Add the new dependencies from above
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Run code generation (if needed):**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Clean and rebuild:**
```bash
flutter clean
flutter pub get
```

## Alternative: Minimal Dependencies (Start with Core)

If you want to start with just the essentials:

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Essential for new architecture
  flutter_riverpod: ^2.5.1
  google_fonts: ^6.1.0
  
  # Keep existing Firebase dependencies
  firebase_core: ^2.27.0
  firebase_auth: ^4.17.8
  
  # Keep existing UI dependencies
  cupertino_icons: ^1.0.6
  shared_preferences: ^2.2.2
  sqflite: ^2.3.2
  path: ^1.9.0
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.8
  riverpod_generator: ^2.4.8
```

## Migration Notes:

1. **Riverpod replaces setState()**: The new architecture uses Riverpod for state management
2. **Design System Centralized**: All design tokens are in `lib/design_system/`
3. **Atomic Components**: New component structure follows atomic design pattern
4. **Optional Firebase**: Firebase is now optional with offline/demo fallback

## Performance Considerations:

- **Bundle Size**: Riverpod adds ~100KB to bundle size
- **Tree Shaking**: Only imported providers affect bundle size
- **Build Time**: Code generation adds ~30s to initial build

## Testing the New Architecture:

```bash
# Run the app with new architecture
flutter run -d chrome

# Check for any dependency conflicts
flutter pub outdated

# Analyze code quality
flutter analyze
```