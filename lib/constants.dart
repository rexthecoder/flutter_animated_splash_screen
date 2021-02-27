part of animated_native_splash_supported_platform;

// Android-related constants
const String _androidColorsFile = 'android/app/src/main/res/values/colors.xml';
const String _androidColorsDarkFile =
    'android/app/src/main/res/values-night/colors.xml';
const String _androidLaunchBackgroundFile =
    'android/app/src/main/res/drawable/launch_background.xml';
const String _androidLaunchDarkBackgroundFile =
    'android/app/src/main/res/drawable-night/launch_background.xml';
const String _androidSplashView =
    'android/app/src/main/res/layout/splash_view.xml';
const String _androidJsonPath =
    'android/app/src/main/res/raw/splash_screen.json';
const String _androidManifestFile = 'android/app/src/main/AndroidManifest.xml';
const String _androidGradleFile = 'android/app/build.gradle';
const String _androidManifestProfileFile =
    'android/app/src/profile/AndroidManifest.xml';
String _androidSplashKitFile(String domain, String company, String appname) =>
    'android/app/src/main/kotlin/$domain/$company/$appname/SplashView.kt';
String _androidMainActivityKitFile(
        String domain, String company, String appname) =>
    'android/app/src/main/kotlin/$domain/$company/$appname/MainActivity.kt';

String introMessage(String currentVersion) => '''
  ════════════════════════════════════════════
     ANIMATED NATIVE SPLASH (v$currentVersion)
  ════════════════════════════════════════════
  ''';
