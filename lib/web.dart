part of animated_native_splash_supported_platform;

Future<void> _createWebSplash({String? path}) async {
  if (path!.isNotEmpty) {
    await _deleteWebFile();
    await _createStylesheet();
    await _saveWebJsonFile(path);
    await _createIndex(path);
  }
}

/// Deleting the web file
///
/// This allow us to replace the web file with a modiy version,
/// Thus, a version with lottie added or integrated
Future<void> _deleteWebFile() async {
  final webFile = File(_webIndex);
  print('[Web] Deleting the web index file');
  await webFile.writeAsString('');
}

/// Create stylesheet
///
/// This positions the element and allow us to visible hide
/// when ever necessary
Future<void> _createStylesheet() async {
  final stylesheet = File(_webRelativeStyleFile);
  stylesheet.createSync(recursive: true);
  print('[Web] Creating the style file.');
  stylesheet.writeAsStringSync(_style);
}

/// Create index file
///
/// Replace the old index with the new template
/// This contains the lottie player already set up
Future<void> _createIndex(path) async {
  var jsonfile = File(path).readAsBytesSync();
  if (jsonfile.isEmpty) {
    throw const _NoJsonFileFoundException('No Json file has been added');
  }
  final index = File(_webIndex);
  index.createSync(recursive: true);
  print('[Web] Creating the Index file.');
  index.writeAsStringSync(
    indexTemplate(
      projectName: _projectName,
    ),
  );
}

/// Save the json file inside the raw directory
///
/// This helps us port our json file to the android folder
/// Veyr useful since we want to a way to link our json file directory to the project
Future _saveWebJsonFile(path) async {
  var jsonfile = File(path).readAsBytesSync();
  if (jsonfile.isEmpty) {
    throw const _NoJsonFileFoundException('No Json file has been added');
  } else {
    print('[Web] Saving the json file insde the splash directory');
    await File(_splashFile).create(recursive: true).then((File file) {
      file.writeAsBytesSync(jsonfile);
    });
  }
}
