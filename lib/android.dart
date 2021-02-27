part of animated_native_splash_supported_platform;

/// Create Android splash screen
Future<void> _createAndroidSplash({
   String jsonPath,
   String color,
   String darkColor,
}) async {
  if (jsonPath.isNotEmpty) {
    _updategradleFile(File(_androidGradleFile));
    await _createSplashViewTemplate();
    await _saveJsonFile(jsonPath);
    await deletingAndroidMenifest();
  }

  await _applyColor(color: color, colorFile: _androidColorsFile);
  await _modifyManifestFolder();
  await _overwriteLaunchBackgroundWithNewSplashColor(
      color: color, launchBackgroundFilePath: _androidLaunchBackgroundFile);

  if (darkColor.isNotEmpty) {
    await _applyColor(color: darkColor, colorFile: _androidColorsDarkFile);
    await _overwriteLaunchBackgroundWithNewSplashColor(
        color: color,
        launchBackgroundFilePath: _androidLaunchDarkBackgroundFile);
  }
}

/// Save the json file inside the raw directory
Future _saveJsonFile(path) async {
  var jsonfile = File(path).readAsBytesSync();
  print('[Android] Saving the json file insde the raw directory');
  await File(_androidJsonPath).create(recursive: true).then((File file) {
    file.writeAsBytesSync(jsonfile);
  });
}

/// Create or update colors.xml adding splash screen background color
Future<void> _applyColor({color,  String colorFile}) async {
  var colorsXml = File(colorFile);
  color = '#' + color;
  if (colorsXml.existsSync()) {
    print('[Android] Updating ' +
        colorFile +
        ' with color for splash screen background');
    _updateColorsFileWithColor(colorsFile: colorsXml, color: color);
  } else {
    print('[Android] No ' + colorFile + ' file found in your Android project');
    print('[Android] Creating ' +
        colorFile +
        ' file and adding it to your Android project');
    _createColorsFile(color: color, colorsXml: colorsXml);
  }
}

/// updating the gradle file
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
      throw _InvalidNativeFile("File '' contains 0 lines.");
    } else {
      print('[Android] Adding the implementation files');
      lines.insert(lines.length - 1,
          '\nimplementation "com.airbnb.android:lottie:3.5.0"\nimplementation "com.android.support.constraint:constraint-layout:2.0.4"');
    }
  }
  gradleFile.writeAsStringSync(lines.join('\n'));
}

/// Updates the colors.xml with the splash screen background color
void _updateColorsFileWithColor(
    { File colorsFile,  String color}) {
  final lines = colorsFile.readAsLinesSync();
  var foundExisting = false;

  for (var x = 0; x < lines.length; x++) {
    var line = lines[x];

    // Update background color if tag exists
    if (line.contains('name="splash_color"')) {
      foundExisting = true;
      // replace anything between tags which does not contain another tag
      line = line.replaceAll(RegExp(r'>([^><]*)<'), '>$color<');
      lines[x] = line;
      break;
    }
  }

  // Add new line if we didn't find an existing value
  if (!foundExisting) {
    if (lines.isEmpty) {
      throw _InvalidNativeFile("File 'colors.xml' contains 0 lines.");
    } else {
      lines.insert(
          lines.length - 1, '\t<color name="splash_color">$color</color>');
    }
  }

  colorsFile.writeAsStringSync(lines.join('\n'));
}

/// Creates a colors.xml file if it was missing from android/app/src/main/res/values/colors.xml
void _createColorsFile({ String color,  File colorsXml}) {
  colorsXml.create(recursive: true).then((File colorsFile) {
    colorsFile.writeAsString(_androidColorsXml).then((File file) {
      _updateColorsFileWithColor(colorsFile: colorsFile, color: color);
    });
  });
}

/// modifying the Android ManifestFolder
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
      print('[Android] Creating splash view');
      createSplashKitFile(finalPattern);
      print('[Android] Creating a new main activity');
      createMainActivityKitFile(finalPattern);
    }
  }
  await launchBackgroundFile.writeAsString(lines.join('\n'));
}

/// Updates the line which specifies the splash screen background color within the AndroidManifest.xml
/// with the new icon name (only if it has changed)
///
/// Note: default color = "splash_color"
Future _overwriteLaunchBackgroundWithNewSplashColor(
    { String color,  String launchBackgroundFilePath}) async {
  final launchBackgroundFile = File(_androidManifestFile);
  final lines = await launchBackgroundFile.readAsLines();

  for (var x = 0; x < lines.length; x++) {
    var line = lines[x];
    if (line.contains('android:theme')) {
      // Using RegExp replace the value of android:drawable to point to the new image
      // anything but a quote of any length: [^"]*
      // an escaped quote: \\" (escape slash, because it exists regex)
      // quote, no quote / quote with things behind : \"[^"]*
      // repeat as often as wanted with no quote at start: [^"]*(\"[^"]*)*
      // escaping the slash to place in string: [^"]*(\\"[^"]*)*"
      // result: any string which does only include escaped quotes
      line = line.replaceAll(RegExp(r'android:theme="[^"]*(\\"[^"]*)*"'),
          'android:theme="@style/NormalTheme"');
      lines[x] = line;
      // used to stop git showing a diff if the icon name hasn't changed
      lines.add('');
    }
  }
  await launchBackgroundFile.writeAsString(lines.join('\n'));
}

/// Create the splash view template
Future<void> _createSplashViewTemplate() async {
  final stylesFile = File(_androidSplashView);
  stylesFile.createSync(recursive: true);
  print('[Android] Creating the splash view file');
  stylesFile.writeAsStringSync(_androidSplashViewXml);
}

/// Create Splash kotlin file
void createSplashKitFile(finalPattern) {
  final manifestFile = File(
      _androidSplashKitFile(finalPattern[1], finalPattern[2], finalPattern[3]));
  manifestFile.createSync(recursive: true);
  print('[Android] Creating the splash view file');
  manifestFile.writeAsStringSync(_anroidSplashView(
      '${finalPattern[1]}.${finalPattern[2]}.${finalPattern[3]}'));
}

/// Create Main Activity File
void createMainActivityKitFile(finalPattern) {
  final manifestFile = File(_androidMainActivityKitFile(
      finalPattern[1], finalPattern[2], finalPattern[3]));
  manifestFile.createSync(recursive: true);
  print('[Android] Creating the main activity file');
  manifestFile.writeAsStringSync(_androidMainActivity(
      '${finalPattern[1]}.${finalPattern[2]}.${finalPattern[3]}'));
}

/// Create MainFest File
void createManifest(finalPattern) {
  final manifestFile = File(_androidMainActivityKitFile(
      finalPattern[1], finalPattern[2], finalPattern[3]));
  manifestFile.createSync(recursive: true);
  print('[Android] Creating the mainfest file');
  manifestFile.writeAsStringSync(_androidMainActivity(
      '${finalPattern[1]}.${finalPattern[2]}.${finalPattern[3]}'));
}

Future<void> deletingAndroidMenifest() async {
  final androidManifest = File(_androidManifestFile);
  print('[Android] Deleting the android manifest file');
  await androidManifest.writeAsString('');
}

void createAndroidManifest(domain) {
  final androidManifest = File(_androidManifestFile);
  androidManifest.createSync(recursive: true);
  print('[Android] Creating a new manifest file');
  androidManifest.writeAsString(
      _androidNewMainMinfest(
        '${domain[1]}.${domain[2]}.${domain[3]}',
      ),
      mode: FileMode.write);
}
