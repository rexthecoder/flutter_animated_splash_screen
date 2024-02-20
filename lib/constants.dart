part of 'supported_platform.dart';

// Android-related constants
/// Below is all the const path needed to inject our files and comnunicate with the android project
///  Do not modify anything here if you don't know which path to set
const String _androidSplashView =
    'android/app/src/main/res/layout/splash_view.xml';
const String _androidJsonPath =
    'android/app/src/main/res/raw/splash_screen.json';
const String _androidManifestFile = 'android/app/src/main/AndroidManifest.xml';
const String _androidStyleTheme = 'android/app/src/main/res/values/styles.xml';
const String _androidGradleFile = 'android/app/build.gradle';
const String _androidManifestProfileFile =
    'android/app/src/profile/AndroidManifest.xml';
String _androidSplashKitFile(String domain, String company, String appname) =>
    'android/app/src/main/kotlin/$domain/$company/$appname/SplashView.kt';
String _androidMainActivityKitFile(
        String domain, String company, String appname) =>
    'android/app/src/main/kotlin/$domain/$company/$appname/MainActivity.kt';
String applicationName = '\${applicationName}';
String introMessage(String currentVersion) => '''
  ════════════════════════════════════════════
   🎈ANIMATED NATIVE SPLASH (v$currentVersion)
  ════════════════════════════════════════════
  ''';

///Web
const String _webFolder = 'web/';
const String _webIndex = '${_webFolder}index.html';
const String _webRelativeStyleFile = 'web/splash/style.css';
const String _splashFile = 'web/splash/splash.json';
const String _url = '\$FLUTTER_BASE_HREF';
String _projectName = '';
