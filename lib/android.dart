part of animated_native_splash_supported_platform;

/// Create Android splash screen
///
/// This use for creating all the nesscery file needed to inject inside our android project
Future<void> _createAndroidSplash({
  String? jsonPath,
}) async {
  if (jsonPath!.isNotEmpty) {
    _updategradleFile(File(_androidGradleFile));
    await _createSplashViewTemplate();
    await _saveJsonFile(jsonPath);
    await deletingAndroidMenifest();
    await _deletingAndroidStyleTheme();
  }

  await _modifyManifestFolder();
}

/// Save the json file inside the raw directory
///
/// This helps us port our json file to the android folder
/// Veyr useful since we want to a way to link our json file directory to the project
Future _saveJsonFile(path) async {
  var jsonfile = File(path).readAsBytesSync();
  if (jsonfile.isEmpty) {
    throw const _NoJsonFileFoundException('No Json file has been added');
  } else {
    print('[Android] Saving the json file insde the raw directory');
    await File(_androidJsonPath).create(recursive: true).then((File file) {
      file.writeAsBytesSync(jsonfile);
    });
  }
}

/// Updating the gradle file
///
///  We add the lot implementation line with the help of this function
/// TODO: ADD MORE PROPERTIES TO ALLOW USERS SET THEIR OWN CUSTOM VALUES
void _updategradleFile(File gradleFile) {
  final lines = gradleFile.readAsLinesSync();
  var foundExisting = false;
  for (var x = 0; x < lines.length; x++) {
    var line = lines[x];
    if (line.contains('implementation "com.airbnb.android:lottie:3.5.0"')) {
      foundExisting = true;
      print('[Android] Files already exist');
      break;
    }
  }
  if (!foundExisting) {
    if (lines.isEmpty) {
      throw const _InvalidNativeFile("File '' contains 0 lines.");
    } else {
      print('[Android] Adding the implementation files');
      lines.insert(lines.length - 1,
          '\nimplementation "com.airbnb.android:lottie:4.2.2"\nimplementation "com.android.support.constraint:constraint-layout:2.0.4"');
    }
  }
  gradleFile.writeAsStringSync(lines.join('\n'));
}

/// Modifying the Android ManifestFolder
///
/// This provide a wa for us to modify and update all the mainfest file
/// it streamline all the package injection we want to provide to our templates
Future _modifyManifestFolder() async {
  final launchBackgroundFile = File(_androidManifestProfileFile);
  final lines = await launchBackgroundFile.readAsLines();

  for (var x = 0; x < lines.length; x++) {
    var line = lines[x];
    if (line.contains('package')) {
      var patternName = line.replaceAll(r'>', '');
      final individualPattern = patternName.trim().split('"').join('.');
      print('[Android] Getting package name');
      final finalPattern = individualPattern.trim().split('.');
      print('[Android] Creating a new manifest Folder');
      createAndroidManifest(finalPattern);
      print('[Android] Creating a new Style Theme file');
      _createStyleTheme();
      print('[Android] Creating splash view');
      createSplashKitFile(finalPattern);
      print('[Android] Creating a new main activity');
      createMainActivityKitFile(finalPattern);
    }
  }
  await launchBackgroundFile.writeAsString(lines.join('\n'));
}

/// Create the splash view template
///
/// This is Function help to inject our splash screen lottie setup to the project
Future<void> _createSplashViewTemplate() async {
  final stylesFile = File(_androidSplashView);
  stylesFile.createSync(recursive: true);
  print('[Android] Creating the splash view file');
  stylesFile.writeAsStringSync(_androidSplashViewXml);
}

/// Create Splash kotlin file
///
/// This Function is use for creating a new Splash kotlin file
/// This class override the defualt slash screen provided by flutter
/// By overriding which means we can assign our own splash screen now
void createSplashKitFile(finalPattern) {
  final manifestFile = File(
      _androidSplashKitFile(finalPattern[1], finalPattern[2], finalPattern[3]));
  manifestFile.createSync(recursive: true);
  print('[Android] Creating the splash view file');
  manifestFile.writeAsStringSync(_anroidSplashView(
      '${finalPattern[1]}.${finalPattern[2]}.${finalPattern[3]}'));
}

/// Create MainActivity File
///
/// This Function is  use for creating a new MainActivity file
/// Sometimes file to give permssion in modifying the main activity file.
/// Therefore it will be a good option to delete it.
void createMainActivityKitFile(finalPattern) {
  final manifestFile = File(_androidMainActivityKitFile(
      finalPattern[1], finalPattern[2], finalPattern[3]));
  manifestFile.createSync(recursive: true);
  print('[Android] Creating the main activity file');
  manifestFile.writeAsStringSync(_androidMainActivity(
      '${finalPattern[1]}.${finalPattern[2]}.${finalPattern[3]}'));
}

// void createManifest(finalPattern) {
//   final manifestFile = File(_androidMainActivityKitFile(
//       finalPattern[1], finalPattern[2], finalPattern[3]));
//   manifestFile.createSync(recursive: true);
//   print('[Android] Creating the mainfest file');
//   manifestFile.writeAsStringSync(_androidMainActivity(
//       '${finalPattern[1]}.${finalPattern[2]}.${finalPattern[3]}'));
// }

/// Deleting the Manifest File
///
/// This Function is  use for deleting the Manifest file
/// Sometimes file to give permssion in modifying the manifest folder.
/// Therefore it will be a good option to delete it
Future<void> deletingAndroidMenifest() async {
  final androidManifest = File(_androidManifestFile);
  print('[Android] Deleting the android manifest file');
  await androidManifest.writeAsString('');
}

/// Deleting the Andriod Style File
///
/// This Function is  use for deleting the Android Theme style file
/// Sometimes the file request permssion in modifying the app folder.
/// Therefore it will be a good option to delete it
Future<void> _deletingAndroidStyleTheme() async {
  final androidThemeStyle = File(_androidStyleTheme);
  print('[Android] Deleting the android theme style file');
  await androidThemeStyle.writeAsString('');
}

/// Creating a new AndriodStyleTheme File
///
/// This Function is use for creating a new Style theme file
/// Sometimes file to give permssion in modifying the style file.
/// Therefore it will be a good option to delete it
void _createStyleTheme() {
  final androidStyleTheme = File(_androidStyleTheme);
  androidStyleTheme.createSync(recursive: true);
  print('[Android] Creating a new manifest file');
  androidStyleTheme.writeAsString(_androidStyle, mode: FileMode.write);
}

/// Creating a new maifest File
///
/// This Function is  use for creating a new Manifest file
/// Sometimes file to give permssion in modifying the manifest folder.
/// Therefore it will be a good option to delete it
void createAndroidManifest(domain) {
  final androidManifest = File(_androidManifestFile);
  androidManifest.createSync(recursive: true);
  print('[Android] Creating a new manifest file');
  androidManifest.writeAsString(
      _androidNewMainMinfest(
        '${domain[1]}.${domain[2]}.${domain[3]}',
        '${domain[3]}',
      ),
      mode: FileMode.write);
}
